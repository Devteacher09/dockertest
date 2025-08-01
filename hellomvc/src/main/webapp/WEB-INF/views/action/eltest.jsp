<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="/WEB-INF/views/common/header.jsp"%> --%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="EL표현식 활용"/>
</jsp:include>
<section>
	<h3>EL표현식 활용하기</h3>
	<h4>리터럴값 출력하기</h4>
	<p>${"안녕" } ${100 }</p>
	<% 
		int age=19; 
		request.setAttribute("age",age);
	%>
	<p>${pageScop.eage }</p>
	<p><%=request.getAttribute("age") %></p>
	
	<h3>내장객체에 저장된 값을 가져오기</h3>
	<%
		request.setAttribute("request","requestData");
		session.setAttribute("session","sessionData");
		application.setAttribute("application", "applicationData");
	%>
	<p>
		내장객체에 저장된것은 작은 생명주기를 갖는 객체부터 자동으로 탐색해서 데이터를 가져옴
		request -> session -> application
	</p>
	<ul>
		<li>${request }</li>
		<li>${session }</li>
		<li>${application }</li>
	</ul>
	<h4>key값이 중복되면 어떻게 될까?</h4>
	<p>
		EL표현식으로 데이터를 가져올때 내장객체를 지정해서 가져오기<br>
		requestScope.key<br>
		sessionScope.key<br>
		applicationScope.key<br>
	</p>
	<%
		session.setAttribute("request","나는 session에 저장한 request");
	%>
	<p>${sessionScope.request }</p>
	
	<h4>EL표현식은 자동으로 형변환을 해줌</h4>
	<%-- <%=((String)request.getAttribute("request")).charAt(0) %> --%>
	<p>${request.length() }</p>
	<p>${request.charAt(0) }</p>
	
	<h2>파마미터값 가져오기</h2>
	<p>
		param.key : 단일값을 가져올때<br> 
		paramValues.key : 다수값을 가져올때<br>
	</p>
	<h4>단일값 : ${param.name }</h4>
	<h4>다수값 : ${paramValues.lunch[0] }</h4>
	<h4>다수값 : ${paramValues.lunch[1] }</h4>
	<h4>다수값 : ${paramValues.lunch[2] }</h4>
	
	<h3>서블릿에서 저장된 데이터 가져오기</h3>
	<h4>${iu }</h4>
	<h4>객체의 각 필드값 출력하기</h4>
	<ul>
		<li>이름 : ${iu.userName }</li>
		<li>전화번호 : ${iu.phone }</li>
		<li>프로필 : ${iu.profile }</li>
		<li>나이 : ${iu.age }</li>
	</ul>
	
	<h4>Collection으로 저장된 객체 가져오기</h4>
	<h4>${actors }</h4>
	<ul>
		<li>${actors.get(0).userName }</li>
		<li>${actors.get(1).userName }</li>
		<li>${actors.get(2).userName }</li>
		<li>${actors.get(3).userName }</li>
	</ul>
	<ul>
		<li>${actorsMap.a.userName }</li>
		<li>${actorsMap.b.userName }</li>
		<li>${actorsMap.c.userName }</li>
		<li>${actorsMap.d.userName }</li>
	</ul>
	
	<h3>메소드 호출하기</h3>
	<h4>size : ${actors.size() }</h4>
	<h4>contains : ${actors.contains(actorsMap.c) }</h4>
	<h4>isEmpty : ${actors.isEmpty() } ${!actors.isEmpty() }</h4>
	<h4>stream메소드 : ${actors.stream().anyMatch(e->e.userName.equals("유병승")).get() }</h4>
	
	<h3>연산처리하기</h3>
	<p>산술,비교,논리,삼항연산</p>
	<%
		request.setAttribute("su",19);
		request.setAttribute("su1",30);
		request.setAttribute("su2",30);
		request.setAttribute("testData","admin");
	%>
	<h4>+ : ${su+su1 }</h4>
	<h4>- : ${su-su1 }</h4>
	<h4>* : ${su*su1 }</h4>
	<h4>/ : ${su/su1 }</h4>
	<h4>다수연산 : ${(su+su2)-su/su1 }</h4>
	<%-- <h4>문자연산 : ${su+testData }</h4> --%>
	
	<h4>== : ${su==su1 } ${su1==su2 } ${su1 eq su2 }</h4>
	<h4>!= : ${su!=su1 } ${su1!=su2 } ${su1 ne su2 }</h4>
	<h4> > : ${su>su1 } ${su1>su2 } ${su1 gt su2 } ${su1 ge su2 }</h4>
	<h4> < : ${su<su1 } ${su1<su2 } ${su1 lt su2 } ${su1 le su2 }</h4>
	<h4>문자열 동등비교 : ${testData == "admin" } ${testData eq "admin" }</h4>
	
	<h4>${su<su1 && testData=='admin'} ${su<su1 and testData=='admin'}</h4>
	<h4>${su<su1 || testData=='유병승'} ${su<su1 or testData=='유병승'}</h4>
	
	<h4>값이 없음을 나타낼때</h4>
	<h4>없는 키 : ${test == null }</h4>
	<h4>없는 키 : ${test eq null }</h4>
	<h4>없는 키 : ${test != null }</h4>
	<h4>없는 키 : ${test ne null }</h4>
	<h4>${test.length()>10 }</h4>
	<%request.setAttribute("test","나 test 있어!"); %>
	<h4>${test==null?"test는 없어!":test }</h4>
	
	<img src="${testData=='admin1'?'/hellomvc/resources/images/iu.jpg':'resources/images/go.png' }" width="300" height="300">
	
	<h3>추가 정보 출력하기</h3>
	<p>
		 cookie, header, contextPath, requestURI, requestURL
	</p>
	<h4>contextPath : ${pageContext.request.contextPath }</h4>
	<h4>requestURI : ${pageContext.request.requestURI }</h4>
	<h4>requestURL : ${pageContext.request.requestURL }</h4>
	<h4>cookie : ${cookie }</h4>
	<h4>cookie : ${cookie.JSESSIONID.name }</h4>
	<h4>cookie : ${cookie.JSESSIONID.value }</h4>
	<h4>cookie : ${cookie.saveId }</h4>
	
	<h4>header: ${header }</h4>
	<h4>header: ${header.referer }</h4>
	<h4>header: ${header.host }</h4>
	<h4>header: ${header['user-agent'] }</h4>
	
	<%-- <%=new Date()%> --%>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>











