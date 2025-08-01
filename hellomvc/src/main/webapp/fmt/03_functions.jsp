<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section>
	<c:set var="data" value="How Are You? i am Fine Thank you"/>
	<h4><c:out value="${data }"/></h4>
	<h4><c:out value="${fn:toUpperCase(data)}"/></h4>
	<h4><c:out value="${fn:toLowerCase(data)}"/></h4>
	<h4><c:out value="${fn:replace(data,'Fine','Tired')}"/></h4>
	<h4><c:out value="${fn:contains(data,'Fine')?'기분좋아!':'피곤해'}"/></h4>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>