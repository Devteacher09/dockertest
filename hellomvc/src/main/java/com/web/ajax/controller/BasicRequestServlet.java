package com.web.ajax.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BasicRequestServlet
 */
@WebServlet("/ajax/basicrequest.do")
public class BasicRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BasicRequestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ajax요청을 받음");
		String name=request.getParameter("name");
		response.setContentType("text/plain;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(name+"님 "+"우와 ajax요청에 응답했어~");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("post로 요청");
//		String name=request.getParameter("name");
//		System.out.println(name);
		BufferedReader br=request.getReader();
		String data=br.lines().collect(Collectors.joining());
		System.out.println(data);
		
		doGet(request, response);
	}

}
