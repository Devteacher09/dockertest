package com.web.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.common.AESEncryptor;
import com.web.common.PasswordEncoder;
import com.web.member.model.dto.Member;
import com.web.member.model.service.MemberService;

@WebServlet(name="memberEnrollEndServlet",
			urlPatterns="/member/memberenrollend.do")
public class MemberEnrollEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public MemberEnrollEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//클라이언트가 전달한 데이터를 DB에 저장하는 기능
		//회원정보를 전달받아 member테이블에 저장
		//인코딩설정
		request.setCharacterEncoding("utf-8");
		String userId=request.getParameter("userId");
		String password=request.getParameter("password");
		String gender=request.getParameter("gender");
		int age=Integer.parseInt(request.getParameter("age"));
		String userName=request.getParameter("userName");
		String email=request.getParameter("email");
		String phone=request.getParameter("phone");
		String address=request.getParameter("address");
		String[] hooby=request.getParameterValues("hobby");
		
//		PasswordEncoder encoder=new PasswordEncoder();
//		String encPw=encoder.getSHA512(password);
//		System.out.println(encPw);
		
		try {
			address=AESEncryptor.encryptData(address);
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println(address);
		Member m=Member.builder()
				.userId(userId)
				.password(password)
				.userName(userName)
				.gender(gender)
				.age(age)
				.email(email)
				.phone(phone)
				.address(address)
				.hobby(hooby)
				.build();
		
		int result=MemberService.memberService().insertMember(m);
		
		//저장성공 : result == 1
		//저장실패 : result == 0
		String url="";
		if(result>0) {
			//메인화면으로 이동
//			request.getRequestDispatcher("/").forward(request, response);
			url="/";
		}else {
			//회원가입페이지로 이동
//			request.getRequestDispatcher("/WEB-INF/views/member/enrollmember.jsp")
//			.forward(request, response);
			url="/member/enrollmember.do";
//			request.getHeader("Referer"); //이전페이지
			
		}
		
		response.sendRedirect(request.getContextPath()+url);
		
		
		
		
		
		
		
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
