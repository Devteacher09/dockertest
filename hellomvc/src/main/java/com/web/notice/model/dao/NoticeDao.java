package com.web.notice.model.dao;

import static com.web.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.web.notice.model.dto.Notice;

public class NoticeDao {
	private static final NoticeDao DAO=new NoticeDao();
	private NoticeDao() {
		String path=NoticeDao.class
				.getResource("/sql/notice_sql.properties").getPath();
		try(FileReader fr=new FileReader(path)){
			sql.load(fr);
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	public static NoticeDao noticeDao() {
		return DAO;
	}
	
	private Properties sql=new Properties();
	
	public List<Notice> searchNoticeAll(Connection conn, int cPage, int numPerpage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Notice> list=new ArrayList<>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchNoticeAll"));
			
			pstmt.setInt(1, (cPage-1)*numPerpage+1);
			pstmt.setInt(2, cPage*numPerpage);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				list.add(getNotice(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
	
	public int noticeCount(Connection conn) {
		Statement stmt=null;
		ResultSet rs=null;
		int result=0;
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql.getProperty("noticeCount"));
			if(rs.next()) result=rs.getInt(1);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
		}return result;
	}
	
	public int insertNotice(Connection conn, Notice n) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertNotice"));
			pstmt.setString(1, n.getNoticeTitle());
			pstmt.setString(2, n.getNoticeWriter());
			pstmt.setString(3, n.getNoticeContent());
			pstmt.setString(4, n.getFilePath());
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	public Notice searchNoticeByNo(Connection conn, int no) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Notice n=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchNoticeByNo"));
			pstmt.setInt(1, no);
			rs=pstmt.executeQuery();
			if(rs.next()) n=getNotice(rs);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
		}
		return n;
	}
	
	
	private Notice getNotice(ResultSet rs) throws SQLException{
		return Notice.builder()
				.noticeNo(rs.getInt("notice_no"))
				.noticeTitle(rs.getString("notice_title"))
				.noticeWriter(rs.getString("notice_writer"))
				.noticeContent(rs.getString("notice_content"))
				.noticeDate(rs.getDate("notice_date"))
				.filePath(rs.getString("filepath"))
				.status(rs.getString("status"))
				.build();
	}
	
	
}









