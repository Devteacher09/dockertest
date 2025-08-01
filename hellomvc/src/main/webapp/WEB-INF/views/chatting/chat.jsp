<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section id="content">
	<div id="chat-container">
		<div id="msg-container"></div>
		<div>
			<input type="text" id="msg">
			<button class="btn btn-outline-primary" id="send-btn">전송</button>
		</div>	
	</div>
	<div id="info-container">현재 접속자 정보</div>
	<script>
		const sender="<%=loginMember.getUserId()%>";
		//접속요청을 서버에 보냄
		let socket=new WebSocket("ws://10.41.0.111:9090<%=request.getContextPath()%>/chatting");
		//핸들러 등록하기
		socket.onopen=(response)=>{
			console.log(response);
			const msg=new Message("A",sender,"","","");
			socket.send(msg.msgToJson());
		}
		socket.onmessage=(e)=>{
			const message=JSON.parse(e.data);
			switch(message.type){
				case "A" : alramMessage(message);break;
				case "M" : msgPrint(message);break;
			}
			/* $("#msg-container").append($("<p>"+message+"</p>")); */
		}
		$("#send-btn").click(e=>{
			const message=$("#msg").val();
			sendMessage(message);
		});
		const alramMessage=(message)=>{
			const $h3=$("<h3>").text(message.data).css("textAlign","center");
			$("#msg-container").append($h3);
		}
		const msgPrint=(message)=>{
			const $container=$("<div>").css({"display":"flex","width":"100%"});
			const $div=$("<div>").css("width","30%");
			const $h4=$("<h4>").text(message.data).css("marginLeft","3%");
			const $span=$("<span>").text(message.sender);
			$div.append($span).append($h4);
			$container.append($div);
			if(sender==message.sender){
				//내 메세지면
				$container.css("justifyContent","end");
			}
			$("#msg-container").append($container);
		}
		
		
		const sendMessage=(message)=>{
			const msg=new Message('M',sender,'',message,'');
			//메세지 전송용 함수
			socket.send(msg.msgToJson());
		}
		
		class Message{
			constructor(type,sender,receiver,data,room){
				this.type=type;
				this.sender=sender;
				this.receiver=receiver;
				this.data=data;
				this.room=room;
			}
			msgToJson(){
				return JSON.stringify(this);
			}
		}
		
	</script>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>


