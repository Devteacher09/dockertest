package com.web.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.web.member.model.dto.Member;

/**
 * Servlet Filter implementation class LoginCheckFilter
 */
@WebFilter(urlPatterns = {"/member/memberinfo.do"})
public class LoginCheckFilter extends HttpFilter implements Filter {
       
    public LoginCheckFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		HttpSession session
			=((HttpServletRequest)request).getSession(false);
		if(session!=null) {
			Member loginMember=(Member)session.getAttribute("loginMember");
			if(loginMember==null) {
				request.setAttribute("msg", "로그인한 사용자만 이용이 가능합니다 :(");
				request.setAttribute("loc", "/");
				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
				.forward(request, response);
				return;
			}
		}else {
			request.setAttribute("msg", "로그인한 사용자만 이용이 가능합니다 :(");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
			.forward(request, response);
			return;
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
