package com.web.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.board.model.dto.Board;
import com.web.board.model.service.BoardService;
import com.web.common.CommonTemplate;

/**
 * Servlet implementation class BoardViewServlet
 */
@WebServlet("/board/boardview.do")
public class BoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public BoardViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no=Integer.parseInt(request.getParameter("no"));
		
		Cookie[] cookies=request.getCookies();
		String readBoard="";
		boolean readResult=false;
		if(cookies!=null) {
			for(Cookie c : cookies) {
				if(c.getName().equals("readBoard")) {
					readBoard=c.getValue();
					if(readBoard.contains("|"+no+"|")) {
						readResult=true;
					}
				}
			}
		}
		
		if(!readResult) {
			Cookie c=new Cookie("readBoard",readBoard+"|"+no+"|");
			c.setMaxAge(60*60*24);
			response.addCookie(c);
		}
				
		
		Board b=BoardService.SERVICE.searchBoardByNo(no,readResult);
		
		
		request.setAttribute("board", b);
		
		request.getRequestDispatcher(CommonTemplate.WEB_VIEWS+"/board/boardView.jsp")
		.forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
