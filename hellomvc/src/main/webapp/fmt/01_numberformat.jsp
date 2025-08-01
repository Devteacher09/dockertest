<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <%@ include file="/WEB-INF/views/common/header.jsp"%> --%>
<section>
	<h3>숫자데이터 문자열로 출력하기</h3>
	<p>
		fmt:formatNumber태그를 이용
	</p>
	<c:set var="number" value="123456012"/>
	<c:set var="number1" value="19883000"/>
	<c:set var="number2" value="1"/>
	<c:set var="number3" value="1234.567"/>
	
	<h3>숫자출력하기</h3>
	<p>일반출력 : <c:out value="${number }"/></p>
	<p>fmt이용출력 : <fmt:formatNumber value="${number }"/></p>
	<p>fmt이용출력 : <fmt:formatNumber value="${number }" groupingUsed="true"/></p>
	<p>fmt이용출력 : <fmt:formatNumber value="${number }" groupingUsed="false"/></p>
	
	<h3>화폐단위를 표시하기</h3>
	<p>
		서버에 설정된 locale를 기준으로 자동설정
	</p>
	<p>
		서버설정 locale : ${pageContext.request.locale }
	</p>
	<p>
		<fmt:formatNumber value="${number1 }" type="currency" />
	</p>
	<p>
		<fmt:setLocale value="ja_JP"/>
		<fmt:formatNumber value="${number1 }" type="currency" />
	</p>
	<p>
		<fmt:setLocale value="en_US"/>
		<fmt:formatNumber value="${number1 }" type="currency" />
	</p>
	<p>
		<fmt:setLocale value="fr_FR"/>
		<fmt:formatNumber value="${number1 }" type="currency" />
	</p>
	<fmt:setLocale value="ko_KR"/>
	<h3>퍼센트표시</h3>
	<p>
		type="percent" value="0 ~ 1" -> 0% ~ 100%
	</p>
	<p>
		<fmt:formatNumber value="${number2 }" type="percent"/>
	</p>
	<p>
		<fmt:formatNumber value="0.2" type="percent"/>
	</p>
	<p>
		<fmt:formatNumber value="0.025" type="percent"/>
	</p>
	
	<h3>숫자를 패턴으로 표시하기</h3>
	<p>
		pattern속성을 사용<br>
		0 : 지정된 자리에 숫자가 있으면 숫자를 표시, 없으면 0을 표시<br>
		# : 지정된 자리에 숫자가 있으면 숫자를 표시, 없으면 생략<br>
	</p>
	<p>
		0 : ${number3 } ->  <fmt:formatNumber value="${number3 }" 
								pattern="000,000,000"/>
	</p>
	<p>
		# : ${number3 } ->  <fmt:formatNumber value="${number3 }" 
								pattern="###,###,###"/>
	</p>
	<p>
		#+0 : ${number3 } ->  <fmt:formatNumber value="${number3 }" 
								pattern="###,###,###.0000"/>
	</p>
	<%-- <p>
		#+0 : ${number3 } ->  <fmt:formatNumber value="${number3 }" 
								pattern="000,000,###.00##"/>
	</p> --%>
	<p>
		#+0 : ${number3 } ->  <fmt:formatNumber value="${number3 }" 
								pattern="#########.0000"/>
	</p>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>







