<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.web.board.model.dto.Board" %>    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<% 
	List<Board> boards=(List<Board>)request.getAttribute("boards");
%>
<style>
	section#board-container{width:600px; margin:0 auto; text-align:center;}
	section#board-container h2{margin:10px 0;}
	table#tbl-board{width:100%; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }
	table#tbl-board th, table#tbl-board td {border:1px solid; padding: 5px 0; text-align:center;} 
	/*글쓰기버튼*/
	input#btn-add{float:right; margin: 0 0 15px;}
	/*페이지바*/
	div#pageBar{margin-top:10px; text-align:center; background-color:rgba(0, 188, 212, 0.3);}
	div#pageBar span.cPage{color: #0066ff;}
	</style>
	<section id="board-container">
		<h2>게시판 </h2>
		<table id="tbl-board">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>첨부파일</th>
				<th>조회수</th>
			</tr>
			<%if(boards.size()>0){ 
				for(Board b : boards){%>
				<tr>
					<td><%=b.boardNo() %></td>
					<td>
						<a href="<%=request.getContextPath()%>/board/boardview.do?no=<%=b.boardNo()%>">
							<%=b.boardTitle() %>
						</a>
					</td>
					<td><%=b.boardWriter() %></td>
					<td><%=b.boardDate() %></td>
					<td>
						<%if(b.originalFilename()!=null){%>
							<img src="<%=request.getContextPath()%>/resources/images/file.png"
							width="20">
						<%} %>
					</td>
					<td><%=b.boardReadCount() %></td>
				</tr>
			<%}
			}else{ %>
				
			<%} %>
		</table>

		<div id="pagebar">
			<%=request.getAttribute("pageBar") %>
		</div>
	</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>