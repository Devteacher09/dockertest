package com.web.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.common.Subject_catetory;
import com.web.member.model.dto.Member;
import com.web.member.model.service.MemberService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(name = "loginServlet", 
			urlPatterns = { "/member/login.do" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 클라이언트가 보낸 userId, password 값 가져오기
		String userId=request.getParameter("userId");
		String password=request.getParameter("password");
		
		
		
		String saveId=request.getParameter("saveId");
//		System.out.println(saveId);
		if(saveId!=null) {
			//check했을때
			Cookie c=new Cookie("saveId",userId);
			c.setMaxAge(60*60*24*7);
			c.setPath("/");
			response.addCookie(c);
		}else {
			Cookie c=new Cookie("saveId",userId);
			c.setMaxAge(0);
			c.setPath("/");
			response.addCookie(c);
		}
		
		
		//2. DB의 Member테이블에 userId, password가 일치하는 회원이 있는지 조회
		Member m=MemberService.memberService().searchMemberById(userId);
		//3. 결과를 저장
		if(m!=null && m.getPassword().equals(password)) {
			//인증성공
//			request.setAttribute("loginMember",m);
			HttpSession session=request.getSession();
			session.setAttribute("loginMember", m);
			response.sendRedirect(request.getContextPath());	
		}else {
			request.setAttribute("msg", "아이디나 패드워드가 일치하지 않습니다. :(");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
			.forward(request, response);
		}		
				
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
