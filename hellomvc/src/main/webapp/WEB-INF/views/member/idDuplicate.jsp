<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean result=(Boolean)request.getAttribute("result");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 확인</title>
</head>
<body>
	<section id="content">
		<div id="checkId-container">
		<% if(result){ %>
			[<span><%=request.getParameter("userId") %></span>]는 사용가능합니다.	
			<br><br>
			<button type="button" onclick="winClose();">닫기</button>
		<%}else{ %>
			[<span id="duplicated"><%=request.getParameter("userId") %></span>]는 사용중입니다.
			<br><br>
			<!-- 아이디 재입력창 구성 -->
			<form action="<%=request.getContextPath() %>/member/idduplicate.do" 
				method="get" >
				<input type="text" name="userId" id="userId">
				<input type="submit" value="중복검사" >
			</form>
		<%} %>
		</div>
	</section>
	<script>
		const winClose=()=>{
			const inputValue="<%=request.getParameter("userId")%>";			
			//부모창에 접근하기 -> opener.document
			const $parentUserId=opener.document.getElementById("userId_");
			$parentUserId.value=inputValue;
			$parentUserId.readOnly=true;
			$parentUserId.style.backgroundColor='lightgray';
			window.close();
		}
	</script>
</body>
</html>
