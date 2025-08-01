package com.web.ajax.controller;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.web.ajax.model.dto.Actor;


@WebServlet("/ajax/saveActor.do")
public class AjaxActorSaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public AjaxActorSaveServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsonData=request.getReader().lines().collect(Collectors.joining());
		System.out.println(jsonData);
		
		//Gson을 이용해서 객체로 변환하기
		Gson gson=new Gson();
		Actor a=gson.fromJson(jsonData, Actor.class);
		System.out.println(a);
		
		
		
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
