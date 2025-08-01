package com.web.ajax.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.ajax.model.dto.Actor;

/**
 * Servlet implementation class AjaxMemberListServlet
 */
@WebServlet("/ajax/memberlist.do")
public class AjaxMemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AjaxMemberListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Actor> actors=List.of(Actor.builder()
				.userName("공유").age(45).profile("gongu.jpg")
				.phone("010-3421-8765")
				.build(),
				Actor.builder()
				.userName("한소희").age(34).profile("hanso.avif")
				.phone("010-2341-0989")
				.build(),
				Actor.builder()
				.userName("고윤정").age(28).profile("go.png")
				.phone("010-3467-7894")
				.build(),
				Actor.builder()
				.userName("아이유").age(31).profile("iu.jpg")
				.phone("010-2472-3495")
				.build()
				);
	
		response.setContentType("text/csv;charset=utf-8");
		String sendData="";
		for(int i=0;i<actors.size();i++) {
			if(i!=0) sendData+="\n";
			sendData+=actors.get(i);
		}
		//객체를 csv방식으로 응답
		response.getWriter().print(sendData);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
