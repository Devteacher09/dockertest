package com.web.notice.model.service;

import java.sql.Connection;
import java.util.List;

import com.web.notice.model.dao.NoticeDao;
import com.web.notice.model.dto.Notice;
import static com.web.common.JDBCTemplate.*;

public class NoticeService {
	
	private static final NoticeService SERVICE=new NoticeService();
	private NoticeService() {}
	public static NoticeService noticeService() {
		return SERVICE;
	}
	
	private NoticeDao dao=NoticeDao.noticeDao();
	
	public List<Notice> searchNoticeAll(int cPage, int numPerpage){
		Connection conn=getConnection();
		List<Notice> result=dao.searchNoticeAll(conn, cPage, numPerpage);
		close(conn);
		return result;
	}

	public int noticeCount() {
		Connection conn=getConnection();
		int totalData=dao.noticeCount(conn);
		close(conn);
		return totalData;
	}
	
	
	public int insertNotice(Notice n) {
		Connection conn=getConnection();
		int result=dao.insertNotice(conn,n);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	public Notice searchNoticeByNo(int no) {
		Connection conn=getConnection();
		Notice n=dao.searchNoticeByNo(conn,no);
		close(conn);
		return n;
	}
	
	
}






