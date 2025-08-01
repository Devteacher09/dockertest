package com.web.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.board.model.dto.BoardComment;
import com.web.board.model.service.BoardService;

/**
 * Servlet implementation class BoardCommentInsertServlet
 */
@WebServlet("/board/insertcomment")
public class BoardCommentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardCommentInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String writer=request.getParameter("writer");
		String content=request.getParameter("content");
		int level=Integer.parseInt(request.getParameter("level"));
		int boardRef=Integer.parseInt(request.getParameter("boardRef"));
		int boardCommentRef=Integer.parseInt(request.getParameter("boardCommentRef"));
		BoardComment bc=BoardComment.builder()
				.boardCommentLevel(level)
				.boardCommentWriter(writer)
				.boardCommentContent(content)
				.boardRef(boardRef)
				.boardCommentRef(boardCommentRef)
				.build();
		int result=BoardService.SERVICE.insertBoardComment(bc);
		
		response.sendRedirect(request.getContextPath()+"/board/boardview.do?no="+boardRef);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
