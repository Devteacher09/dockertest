package com.web.member.model.service;

import java.sql.Connection;

import com.web.member.model.dao.MemberDao;
import com.web.member.model.dto.Member;
import static com.web.common.JDBCTemplate.*;
public class MemberService {
	
	private static final MemberService SERVICE=new MemberService();
	
	private MemberService() {}
	public static MemberService memberService() {
		return SERVICE;
	}
	
	
	private MemberDao dao=MemberDao.memberDao();
	
	public int insertMember(Member m) {
		Connection conn=getConnection();
		int result=dao.insertMember(conn,m);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public Member searchMemberById(String userId) {
		Connection conn=getConnection();
		Member m=MemberDao.memberDao().searchMemberById(conn,userId);
		close(conn);
		return m;
	}
	
	public int updateMember(Member m) {
		Connection conn=getConnection();
		int result=MemberDao.memberDao().updateMember(conn,m);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
}
