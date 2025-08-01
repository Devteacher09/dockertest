<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="/WEB-INF/views/common/header.jsp"%> --%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="액션태그"/>
</jsp:include>
<%-- ${loginMember} --%>
<section>
	<h2>액션태그</h2>
	<p>
		jsp페이지에서 java코드를 html방식으로 작성할 수 있게 해주는 기능
	</p>
	<ul>
		<li>표준액션태그 : jsp가 기본으로 제공하는 액션태그 태그의 접두어에 jsp를 사용
			<%-- <jsp:태그명 속성명="속성값"/> --%>
		</li>
		<li>커스텀액션태그 : 별도의 jar로 제공되는 액션태그 -> JSTL태그(apache)<br>
			1. jar파일을 프로젝트에 추가<br>
			2. jsp파일에 <%-- <%@ taglib  prefix="" uri="" %> --%>를 이용해서 사용할 커스텀 태그를 선언<br>
			3. <!-- <prefix속성값:태그명 속성명="" 속성명=""/> -->
		</li>
	</ul>
	<h3>표준액션태그</h3>
	<h4>jsp:include / jsp:param태그에 대해 알아보자</h4>
	<p>
		jsp:include : 다른 jsp를 불러올때 사용하는 태그 -> == <%-- <%@ include file="" %> --%>
		jsp:param : 다른 jsp를 불러올때 jsp에 parameter값을 전달할때 사용하는 태그
	</p>
	<p>
		<%-- <jsp:include page="불러올 jsp페이지 경로"/> --%>
		<%-- <jsp:include page="불러올 jsp페이지 경로">
				<jsp:param name="key값" value="전달값"/>
			 </jsp:include>
		 --%>
	</p>
	<h3>EL표현식</h3>
	<p>
		<%-- <%= %> --%>태그를 이용해서 java코드를 html페이지에 출력한 것을 대신하는 문법<br>
		jsp내장객체(ServlerContext(appliction),HttpSession, HttpServletRequest)에 저장된 데이터, 
		request에 저장된 정보(parameter,header,cookie)를 가져올 때 사용<br>
		<%-- ${key } --%>
		EL표현식 내부에는 연산자를 사용할 수 있음, 메소드 호출도 가능, getter를 쉽게 호출할 수 있음<br>
	</p>
	<h3>
		<a href="${pageContext.request.contextPath }/eltest.do?name=JMS&lunch=마라탕&lunch=짜장면&lunch=유린기&lunch=난자완스">
			EL표현식 사용하기
		</a>
	</h3>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>












