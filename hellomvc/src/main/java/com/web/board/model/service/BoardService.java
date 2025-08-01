package com.web.board.model.service;

import static com.web.common.JDBCTemplate.close;
import static com.web.common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.web.board.model.dao.BoardDao;
import com.web.board.model.dto.Board;
import com.web.board.model.dto.BoardComment;
import com.web.common.JDBCTemplate;
public enum BoardService {
	SERVICE;
	
	private BoardDao dao=BoardDao.DAO;
	
	public List<Board> searchBoardAll(int cPage,int numPerpage){
		Connection conn=getConnection();
		List<Board> boards=dao.searchBoardAll(conn, cPage, numPerpage);
		close(conn);
		return boards;
	}
	public Board searchBoardByNo(int no,boolean readResult) {
		Connection conn=getConnection();
		Board board=dao.searchBoardByNo(conn,no);
		//List<BoardComment> comments=dao.searchBoardComment(conn, no);
//		board.setComments(comments);
//		board=Board.builder()
//				.boardNo(board.boardNo())
//				.boardContent(board.boardContent())
//				.boardDate(board.boardDate())
//				.boardReadCount(board.boardReadCount()+1)
//				.boardTitle(board.boardTitle())
//				.boardWriter(board.boardWriter())
//				.comments(comments)
//				.build();
//		Map<String,Object> resultValue=Map.of("board",board,"comments",comments);
		if(board!=null&&!readResult) {
			int result=dao.updateBoardReadCount(conn,no);
			if(result>0) { 
				board=dao.searchBoardByNo(conn,no);
//				board.setBoardReadCount(board.getBoardReadCount()+1);
//				board=Board.builder()
//					.boardNo(board.boardNo())
//					.boardContent(board.boardContent())
//					.boardDate(board.boardDate())
//					.boardReadCount(board.boardReadCount()+1)
//					.boardTitle(board.boardTitle())
//					.boardWriter(board.boardWriter())
//					.comments(comments)
//					.build();
			}
		}
		close(conn);
		return board;
	}
	public int boardCount() {
		Connection conn=getConnection();
		int count=dao.boardCount(conn);
		close(conn);
		return count;
	}
	
	public int insertBoardComment(BoardComment bc) {
		Connection conn=getConnection();
		int result=dao.insertBoardComment(conn,bc);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		close(conn);
		return result;
	}
	
}


