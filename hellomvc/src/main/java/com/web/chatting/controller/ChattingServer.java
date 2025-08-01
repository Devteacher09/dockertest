package com.web.chatting.controller;

import java.io.IOException;
import java.util.Set;

import javax.websocket.EncodeException;
import javax.websocket.EndpointConfig;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/chatting",
encoders = {MessageSerializer.class}, 
decoders= {MessageDeSerializer.class})
public class ChattingServer {
	
	@OnOpen
	public void open(Session session, EndpointConfig config) {
		//클라이언트가 접속했을때 실행되는 메소드
		System.out.println("클라이언트 접속");
		//Session객체 : 클라이언트의 정보를 저장하고 있는 객체
		// 클라이언에게 데이터를 전송하거나 클라이언트의 특정 정보를 저장할 수 있음
		
		//접속한 클라이언트에 데이터 전송하기
		try {
			session.getBasicRemote().sendText("접속을 환영합니다");
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	@OnMessage
	public void message2(Session session, Message msg) {
		System.out.println(msg);
		try {
			session.getBasicRemote().sendObject(msg);
		}catch(IOException | EncodeException e) {
			e.printStackTrace();
		}
	}
//	@OnMessage
//	public void message(Session session, String data) {
//		//클라이언트가 데이터를 전송했을때 실행되는 메소드
//		System.out.println(data);
//		
//		Message message=new Gson().fromJson(data,Message.class);
//		
//		//접속한 session가져오기
//		Set<Session> clients=session.getOpenSessions();
//		
//		switch(message.getType()) {
//			case "A" : initAlram(clients,message);break;
//			case "M" : sendChatMsg(clients,message);break;
//			
//		}
//		
//		
////		try {
////			clients.stream().forEach(client->{
////				try {
////					client.getBasicRemote().sendText(data);
////				}catch(IOException e) {
////					e.printStackTrace();
////				}
////			});
////			session.getBasicRemote().sendText(data);
////		}catch(IOException e) {
////			e.printStackTrace();
////		}
//		
//	}
	private void initAlram(Set<Session> clients, Message msg) {
		//000님이 접속했습니다.
		Message m=Message.builder().type("A")
				.data(msg.getSender()+"님이 접속했습니다")
				.build();
		clients.stream().forEach(client->{
			try {
				client.getBasicRemote().sendText(m.toJson());
			}catch(IOException e) {
				e.printStackTrace();
			}
		});
	}
	private void sendChatMsg(Set<Session> clients, Message msg) {
		
		if(!msg.getReceiver().equals("")) {
			
		}else if(!msg.getRoom().equals("")) {
			
		}else {
			clients.stream().forEach(client->{
				try {
					client.getBasicRemote().sendText(msg.toJson());
				}catch(IOException e) {
					e.printStackTrace();
				}
			});
		}
	}
	
}







