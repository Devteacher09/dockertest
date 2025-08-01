package com.web.chatting.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.common.CommonTemplate;

/**
 * Servlet implementation class ChattingPageServlet
 */
@WebServlet("/chatting/chatpage.do")
public class ChattingPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ChattingPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher(
				CommonTemplate.WEB_VIEWS+"/chatting/chat.jsp")
		.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
