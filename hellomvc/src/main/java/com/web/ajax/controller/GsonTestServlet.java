package com.web.ajax.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.web.notice.model.dto.Notice;
import com.web.notice.model.service.NoticeService;

/**
 * Servlet implementation class GsonTestServlet
 */
@WebServlet("/ajax/searchnotice.do")
public class GsonTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GsonTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Notice> notices=NoticeService.noticeService().searchNoticeAll(1, 20);
		
		response.setContentType("application/json;charset=utf-8");
		//gson객체 생성하기
		Gson gson=new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
//		gson=new GsonBuilder().registerTypeAdapter(Date.Class, new )
//		String jsonData=gson.toJson(notices.get(0));
		String jsonData=gson.toJson(notices);
		System.out.println(jsonData);
		
		response.getWriter().print(jsonData);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
