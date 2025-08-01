package com.web.ajax.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.web.board.model.dto.Board;
import com.web.board.model.service.BoardService;

@WebServlet("/ajax/boardlist.do")
public class AjaxSearchBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AjaxSearchBoardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Board> boards=BoardService.SERVICE.searchBoardAll(1, 20);
		Gson gson=new Gson();
		response.setContentType("application/json;charset=utf-8");
		gson.toJson(boards,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
