<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<style>
   section#notice-container{width:600px; margin:0 auto; text-align:center;}
   section#notice-container h2{margin:10px 0;}
   table#tbl-notice{width:500px; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }
   table#tbl-notice th {width: 125px; border:1px solid; padding: 5px 0; text-align:center;} 
   table#tbl-notice td {border:1px solid; padding: 5px 0 5px 10px; text-align:left;}
</style>
<section id="content">
	<div id="notice-container">
		<h2>공지사항 작성</h2>
	    <form action="<%=request.getContextPath() %>/notice/noticewriteend.do"
	     method="post" enctype="multipart/form-data">
	        <table id="tbl-notice">
	        <tr>
	            <th>제 목</th>
	            <td>
					<input type="text" id="title" name="title" required>
				</td>
	        </tr>
	        <tr>
	            <th>작성자</th>
	            <td><input type="text" id="writer" name="writer" readonly
	            value="<%=loginMember!=null?loginMember.getUserId():""%>"></td>
	        </tr>
	        <tr>
	            <th>첨부파일</th>
	            <td><input type="file" id="upfile" name="upfile"></td>
	        </tr>
	        <tr>
	            <th>내 용</th>
	            <td><textarea rows="5" cols="40" name="content" style="resize:none"></textarea></td>
	        </tr>
	        <tr>
	            <th colspan="2">
	                <input type="submit" value="등록하기" onclick="">
	            </th>
	        </tr>
	    </table>
	  </form>
    </div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>