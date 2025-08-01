package com.web.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.member.model.dto.Member;
import com.web.member.model.service.MemberService;

/**
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/member/memberupdate.do")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String userId=request.getParameter("userId");
		String gender=request.getParameter("gender");
		int age=Integer.parseInt(request.getParameter("age"));
		String userName=request.getParameter("userName");
		String email=request.getParameter("email");
		String phone=request.getParameter("phone");
		String address=request.getParameter("address");
		String[] hooby=request.getParameterValues("hobby");
		
		Member m=Member.builder()
				.userId(userId)
				.userName(userName)
				.gender(gender)
				.age(age)
				.email(email)
				.phone(phone)
				.address(address)
				.hobby(hooby)
				.build();
		
		int result=MemberService.memberService().updateMember(m);
		String msg,loc;
		if(result>0) {
			msg="회원정보 수정완료 :)";
			HttpSession session=request.getSession();
			session.setAttribute("loginMember", m);
		}else {
			msg="회원정보 수정실패 :(";
		}
		loc="/member/memberinfo.do?userId="+userId;
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
		.forward(request, response);
	
	
	
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
