<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<section>
	<h3>날짜데이터 출력하기</h3>
	<c:set var="today" value="<%=new java.util.Date()%>"/>
	<p><c:out value="${today }"/></p>
	<p>
		fmt:formatDate태그<br>
		type : 출력내용을 설정하는 속성<br>
			date : 년월일 출력<br>
			time : 시분초 출력<br>
			both : 년월일 시분초 출력<br>
		dateStyle : 날짜출력형태를 설정
			default, short, long, full<br>
		timeStyle : 시간출력형태를 설정
			medium, short, long, full<br>	 
	</p>
	<h4>기본출력 : <fmt:formatDate value="${today }"/></h4>
	<h4>date : <fmt:formatDate value="${today }" type="date"/></h4>
	<h4>time : <fmt:formatDate value="${today }" type="time"/></h4>
	<h4>both : <fmt:formatDate value="${today }" type="both"/></h4>
	
	<h4>short : <fmt:formatDate value="${today }" type="date" dateStyle="short"/></h4>
	<h4>long : <fmt:formatDate value="${today }" type="date" dateStyle="long"/></h4>
	<h4>full : <fmt:formatDate value="${today }" type="date" dateStyle="full"/></h4>
	
	<h4>short : <fmt:formatDate value="${today }" type="time" timeStyle="short"/></h4>
	<h4>long : <fmt:formatDate value="${today }" type="time" timeStyle="long"/></h4>
	<h4>full : <fmt:formatDate value="${today }" type="time" timeStyle="full"/></h4>
	
	<h4>full : <fmt:formatDate value="${today }" type="both" 
			timeStyle="short" dateStyle="full"/></h4>
			
			
	<h3>원하는 패턴으로 날짜 출력하기</h3>
	<p>
		y : 년 M : 월 d : 일 hh : 시 mm : 분 ss : 초<br>
		pattern속성에 설정<br>
	</p>
	<p>
		<fmt:formatDate value="${today }" pattern="yyyy/MM/dd"/>
	</p>
	<p>
		<fmt:formatDate value="${today }" type="time"
		 pattern="HH mm ss"/>
	</p>
	<p>
		<fmt:formatDate value="${today }" type="both"
		 pattern="yy-MM-dd (E) HH:mm:ss"/>
	</p>
	
	<h3>표준시 설정하기</h3>
	<p>
		<fmt:formatDate value="${today }" type="time"/>
	</p>
	<p>
		<fmt:timeZone value="GMT">
			<fmt:formatDate value="${today }" type="time"/>	
		</fmt:timeZone>
	</p>
	<p>
		<fmt:timeZone value="GMT+9">
			<fmt:formatDate value="${today }" type="time"/>	
		</fmt:timeZone>
	</p>
	<p>
		<fmt:timeZone value="GMT+14">
			<fmt:formatDate value="${today }" type="time"/>	
		</fmt:timeZone>
	</p>
		
	<p>
		<fmt:setLocale value="ja_JP"/>
		<fmt:formatDate value="${today }" type="both" dateStyle="full" timeStyle="full"/>
	</p>
	<p>
		<fmt:setLocale value="zh_CN"/>
		<fmt:formatDate value="${today }" type="both" dateStyle="full" timeStyle="full"/>
	</p>
	<p>
		<fmt:setLocale value="fr_FR"/>
		<fmt:formatDate value="${today }" type="both" dateStyle="full" timeStyle="full"/>
	</p>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>








