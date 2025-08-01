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

import com.web.common.exception.LoginCheckException;
import com.web.member.model.dto.Member;

/**
 * Servlet Filter implementation class CheckAuthenticationFilter
 */
@WebFilter(urlPatterns = {"/member/memberinfo.do"})
public class CheckAuthenticationFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public CheckAuthenticationFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//		List<String> auth=List.of("ADMIN","MANAGER");
		// place your code here
		HttpSession session=((HttpServletRequest)request).getSession();
		Member loginMember=(Member)session.getAttribute("loginMember");
		if(loginMember!=null&&request.getParameter("userId")!=null
				&&(loginMember.getUserId().equals("admin")
					||loginMember.getUserId().equals(request.getParameter("userId")))) {
			chain.doFilter(request, response);
		}else {
			throw new LoginCheckException("로그인 후 이용할 수 있습니다.");
//			request.setAttribute("msg", "사용할 수 있는 권한이 없습니다! :(");
//			request.setAttribute("loc", "/");
//			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
//			.forward(request, response);
//			return;
		}
		
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
