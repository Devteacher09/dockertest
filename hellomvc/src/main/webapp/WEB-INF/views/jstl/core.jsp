<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section>
<h3>jstl이 제공하는 core태그 이용하기</h3>
<p>
	조건문, 반복문, 변수저장, 출력하는 태그를 제공
</p>
<h3>set, out태그활용</h3>
<p>
	c:set태그 : 사용할 변수에 값을 저장하는 태그 -> 내장객체에 저장(setAttribute())<br>
	c:out태그 : 페이지에 출력 데이터를 출력하는 태그 -> <%-- ${key } --%>동일 / <%-- <%= %> --%><br>
	속성을 이용해서 저장, 출력을 함.
</p>
<ul>set태그 속성
	<li>var : key를 설정</li>
	<li>value : 저장할 데이터를 설정</li>
	<li>scope : request,session,application 중 한개 선택</li>
</ul>
<ul>out태그 속성
	<li>value : 페이지에 출력될 데이터 설정</li>
	<li>default : 출력될 내용이 없을때 대체출력할 값 설정</li>
	<li>escapeXml : 출력할 데이터가 html방식일때 html로 출력할지 선택하는 설정</li>
</ul>

<c:set var="comment" value="3일 쉬니 힘들다, 하지만 할 수 있다" />
<p>comment : ${comment }</p>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<p>${path }</p>
<c:set var="request" value="requestData" scope="request"/>
<c:set var="session" value="sessionData" scope="session"/>
<c:set var="application" value="applicationData" scope="application"/>
<p>${requestScope.request }</p>
<p>${sessionScope.session }</p>
<p>${applicationScope.application }</p>

<h3><c:out value="오늘 점심 뭐먹지?"/></h3>
<h3><c:out value="${request }"/></h3>
<h3>${request }</h3>

<c:set var="msg" value="<script>location.assign('https://www.naver.com');</script>"/>
<h4><c:out value="${msg }" escapeXml='true'/></h4>

<h3>조건문활용하기</h3>
<p>
	c:if, c:choose 태그를 이용
</p>
<%-- <%if(test.equals("t")){ %>
<%} %> --%>
<c:if test="${msg.contains('script') }">
	<h3>msg에 script감지</h3>
</c:if>
<c:if test="${request == 'session' }" var="requestVal">
	<h3>request값은 session이야</h3>
</c:if>
<c:if test="${!requestVal }">
	<h3>조건문 재사용하기</h3>
</c:if>
<!-- if ~ else if else if else문과 동일 -->
<c:set var="su" value="0"/>
<c:choose>
	<c:when test="${su>10 }">
		<h3>su가 10보다 크네</h3>
	</c:when>
	<c:when test="${su>5 }">
		<h3>su가 5보다 크네</h3>
	</c:when>
	<c:when test="${su>0 }">
		<h3>su가 0보다 크네</h3>
	</c:when>
	<c:otherwise>
		<h3>su가 음수네</h3>
	</c:otherwise>	
</c:choose>

<h3>반복문</h3>
<p>
	c:forEach태그사용<br>
	1. 기본반복문 : 특정 횟수만큼 반복하는 구문(i값을 증가)<br>
	2. 리스트, 배열에 있는 값을 순회하는 반복문 : forEach문 <br>
</p>
<ul>forEach속성
	<li>var : 값을 저장하는 변수명</li>
	<li>begin : 시작 수</li>
	<li>end : 끝낼 수 </li>
	<li>step : 증가범위 설정</li>
	<li>varStatus : 반복문의 정보를 저장한 객체명</li>
	<li>items : 리스트, set, 배열타입을 설정</li>
</ul>

<h4>1~4까지 출력하기</h4>
<ul>
	<c:forEach var="i" begin="0" end="3" step="1">
		<li>${i+1 }</li>
	</c:forEach>
</ul>
<c:forEach var="i" begin="1" end="6" step="1">
	<h${i }>우와 신기하다</h${i }>
</c:forEach>
<%@ page import="java.util.*" %>
<%
	List<String> names=List.of("유병승","홍길동","이순신","신사임당","세종대왕");
	request.setAttribute("names",names);
%>
<ul>
	<c:forEach var="name" items="${names }" varStatus="vs">
		<li ${vs.first or vs.last?"style='color:red'":""}>인덱스 : ${vs.index } 실행수 : ${vs.count } 
			첫번째값? : ${vs.first }
			마지막값? : ${vs.last }
		값 : <c:out value="${name }"/></li>
	</c:forEach>
</ul>

<table class="table">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<c:forEach var="board" items="${boards }">
		<c:if test="${board.boardWriter() ne 'admin' }">
			<tr>
				<td>${board.boardNo() }</td>
				<td>${board.boardTitle() }</td>
				<td>${board.boardWriter() }</td>
				<td>${board.boardDate() }</td>
				<td>${board.boardReadCount() }</td>
			</tr>
		</c:if>
	</c:forEach>
</table>

<h4>그외 코어태그들</h4>
<p>c:import : 다른 jsp를 불러올때 사용 == jps:include, %@ include</p>
<c:import url="/WEB-INF/views/ajax/main.jsp" var="importPage">
	<c:param name="title" value="c:import테스트"/>
</c:import>

<div>
	${importPage}
</div>

<p>
	c:catch태그 : Exception에 대한 예외처리 태그
</p>
<%
	String test1=null;
%>
<c:catch var="e">
	<p>
		<%=test1.length() %>
	</p>
</c:catch>
<c:if test="${e!=null }">
	<h2>${e }</h2>
</c:if>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>







