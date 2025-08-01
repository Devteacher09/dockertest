package com.web.ajax.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class AjaxHobbySearchServlet
 */
@WebServlet("/ajax/hobbies.do")
public class AjaxHobbySearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AjaxHobbySearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> hobby=List.of(
				"코딩","운동","게임","음주","노래","영화",
				"독서","독서2","게임2","음악감상","리코더연주",
				"영어","동전수집","수영");
		String keyword=request.getParameter("keyword");
		
		List<String> searchHobby=hobby.stream().filter(h->h.contains(keyword)).toList();
		
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(searchHobby,response.getWriter());
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
