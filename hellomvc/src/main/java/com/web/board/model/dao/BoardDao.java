package com.web.board.model.dao;

import static com.web.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

import com.web.board.model.dto.Board;
import com.web.board.model.dto.BoardComment;

public enum BoardDao {
	DAO;
	private Properties sql=new Properties();
	
	{//초기화 블록
		String path=BoardDao.class.getResource("/sql/board_sql.properties")
				.getPath();
		try(FileReader fr=new FileReader(path)){
			sql.load(fr);
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<Board> searchBoardAll(Connection conn, int cPage, int numPerpage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Board> boards=new ArrayList<>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchBoardAll"));
			pstmt.setInt(1, (cPage-1)*numPerpage+1);
			pstmt.setInt(2, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				boards.add(getBoard(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return boards;
	}
	
	public int boardCount(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("boardCount"));
			rs=pstmt.executeQuery();
			if(rs.next()) count=rs.getInt(1);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return count;
	}
	public Board searchBoardByNo(Connection conn, int no) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Board b=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchBoardByNo"));
			pstmt.setInt(1, no);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				b=getBoard(rs);
				do {
					b.comments().add(getBoardComment(rs));
				}while(rs.next());
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return b;
	}
	
	public int updateBoardReadCount(Connection conn, int no) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement("UPDATE BOARD SET BOARD_READCOUNT=BOARD_READCOUNT+1 WHERE BOARD_NO=?");
			pstmt.setInt(1, no);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public int insertBoardComment(Connection conn, BoardComment bc) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertBoardComment"));
			pstmt.setInt(1, bc.boardCommentLevel());
			pstmt.setString(2, bc.boardCommentWriter());
			pstmt.setString(3,bc.boardCommentContent());
			pstmt.setInt(4, bc.boardRef());
			pstmt.setString(5, bc.boardCommentRef()==0?null:String.valueOf(bc.boardCommentRef()));
			result=pstmt.executeUpdate();			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public List<BoardComment> searchBoardComment(Connection conn, int boardNo){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardComment> comments=new ArrayList<>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchBoardComment"));
			pstmt.setInt(1, boardNo);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				comments.add(getBoardComment(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return comments;
	}
	
	private BoardComment getBoardComment(ResultSet rs) throws SQLException {
		return BoardComment.builder()
				.boardCommentNo(rs.getInt("board_comment_no"))
				.boardCommentLevel(rs.getInt("board_comment_level"))
				.boardCommentWriter(rs.getString("board_comment_writer"))
				.boardCommentContent(rs.getString("board_comment_content"))
				.boardRef(rs.getInt("board_ref"))
				.boardCommentRef(rs.getInt("board_comment_ref"))
				.boardCommentDate(rs.getDate("board_comment_date"))
				.build();
	}
	
	
	
	private Board getBoard(ResultSet rs) throws SQLException {
		return new Board(rs.getInt("board_no"),
				rs.getString("board_title"),
				rs.getString("board_writer"),
				rs.getString("board_content"),
				Optional.ofNullable(rs.getString("board_original_filename")).orElse(" "),
				rs.getString("board_renamed_filename"),
				rs.getDate("board_date"),
				rs.getInt("board_readcount"),new ArrayList<>());
	}
}
