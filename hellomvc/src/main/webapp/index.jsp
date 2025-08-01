<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<section id="content">
	<img src="<%=request.getContextPath()%>/resources/images/logo.png"
	width="80%" alt="천재it교육센터로고">
	
	<h2>액션태그</h2>
	<h3>
		<a href="${pageContext.request.contextPath }/action.do">액션태그</a>
	</h3>
	
	<h2>JSTL활용하기</h2>
	<h3>
		<a href="${pageContext.request.contextPath }/jstl.do">JSTL활용</a>
	</h3>
	
	
	<script>
		window.addEventListener("beforeunload",e=>{
			console.log(e);
			$.get("<%=request.getContextPath()%>/ajax/basicrequest.do")
			.done(data=>{
				
			}).fail(e=>{
			});
			e.preventDefault();
			e.returnValue="11";
			return "11";
		});
	
	</script>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>





