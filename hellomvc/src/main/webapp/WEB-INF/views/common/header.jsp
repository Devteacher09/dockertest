<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.web.member.model.dto.Member" %>    
<%
	Member loginMember=(Member)session.getAttribute("loginMember");
	Cookie[] cookies=request.getCookies();
	String saveId=null;
	if(cookies!=null){
		for(Cookie c : cookies){
			if(c.getName().equals("saveId")){
				saveId=c.getValue();
				break;
			}
		}
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 첫 프로젝트</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/style.css">
<script src="<%=request.getContextPath()%>/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
	<div id="header">
		<header>
			<h1><%-- <%=request.getParameter("title")!=null?request.getParameter("title"):"HelloMvc" %> --%>
				${param.title!=null?param.title:"HelloMVC" }
			</h1>
			<div class="login-container">
				<%if(loginMember==null){ %>
				<form action="<%=request.getContextPath() %>/member/login.do"
				 method="post">
					<table>
						<tr>
							<td>
								<input type="text" name="userId" id="userId"
								placeholder="아이디입력" value="<%=saveId!=null?saveId:"" %>" 
								>
							</td>
							<td></td>
						</tr>
						<tr>
							<td>
								<input type="password" name="password" id="passwod"
								placeholder="패스워드입력">
							</td>
							<td>
								<input type="submit" value="로그인" >
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="checkbox" name="saveId" 
								id="saveId" <%=saveId!=null?"checked":"" %>>
								<label for="saveId">아이디저장</label>
								<input type="button" value="회원가입"
								onclick="location.assign('<%=request.getContextPath()%>/member/enrollmember.do');">							</td>
						</tr>
					</table>
				</form>
				<%}else{ %>
					<table id="logged-in">
						<tr>
							<td colspan="2">
								<%=loginMember.getUserName() %>님, 환영합니다. :)
							</td>
						</tr>
						<tr>
							<td>
								<input type="button" value="내정보보기"
								onclick="location.assign('<%=request.getContextPath()%>/member/memberinfo.do?userId=<%=loginMember.getUserId()%>')">
								<form action="<%=request.getContextPath()%>/member/memberinfo.do" method="post">
									
								</form>
							</td>
							<td>
								<input type="button" value="로그아웃" 
								onclick="location.replace('<%=request.getContextPath()%>/member/logout.do')">
							</td>
						</tr>
					</table>
				<%} %>
			</div>
			<nav>
				<ul class="main-nav">
					<li class="home">
						<a href="">Home</a>
					</li>
					<li id="notice">
						<a href="<%=request.getContextPath()%>/notice/noticelist.do">공지사항</a>
					</li>
					<li>
						<a href="<%=request.getContextPath()%>/board/boardlist.do">게시판</a>
					</li>
					<li>
						<a href="<%=request.getContextPath()%>/ajax/main.do">ajax요청</a>
					</li>
					<%if(loginMember!=null){ %>
						<li>
							<a href="<%=request.getContextPath()%>/chatting/chatpage.do">채팅하기</a>
						</li>
					<%} %>
				</ul>
			</nav>
		</header>
	</div>