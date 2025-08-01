<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.web.board.model.dto.*,java.util.List" %>    
<% 
	Board b=(Board)request.getAttribute("board"); 	
	List<BoardComment> comments=b.comments();
%>    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<style>
  section#board-container{width:600px; margin:0 auto; text-align:center;}
  section#board-container h2{margin:10px 0;}
  table#tbl-board{width:500px; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }
  table#tbl-board th {width: 125px; border:1px solid; padding: 5px 0; text-align:center;} 
  table#tbl-board td {border:1px solid; padding: 5px 0 5px 10px; text-align:left;}
   div#comment-container button#btn-insert{width:60px;height:50px; color:white;
    background-color:#3300FF;position:relative;top:-20px;}
        /*댓글테이블*/
    table#tbl-comment{width:580px; margin:0 auto; border-collapse:collapse; clear:both; } 
    table#tbl-comment tr td{border-bottom:1px solid; border-top:1px solid; padding:5px; text-align:left; line-height:120%;}
    table#tbl-comment tr td:first-of-type{padding: 5px 5px 5px 50px;}
    table#tbl-comment tr td:last-of-type {text-align:right; width: 100px;}
    table#tbl-comment button.btn-reply{display:none;}
    table#tbl-comment button.btn-delete{display:none;}
    table#tbl-comment tr:hover {background:lightgray;}
    table#tbl-comment tr:hover button.btn-reply{display:inline;}
    table#tbl-comment tr:hover button.btn-delete{display:inline;}
    table#tbl-comment tr.level2 {color:gray; font-size: 14px;}
    table#tbl-comment sub.comment-writer {color:navy; font-size:14px}
    table#tbl-comment sub.comment-date {color:tomato; font-size:10px}
    table#tbl-comment tr.level2 td:first-of-type{padding-left:100px;}
    table#tbl-comment tr.level2 sub.comment-writer {color:#8e8eff; font-size:14px}
    table#tbl-comment tr.level2 sub.comment-date {color:#ff9c8a; font-size:10px}
    /*답글관련*/
    table#tbl-comment textarea{margin: 4px 0 0 0;}
    table#tbl-comment button.btn-insert2{width:60px; height:23px; color:white; background:#3300ff; position:relative; top:-5px; left:10px;}	
</style>
   
<section id="board-container">
	<h2>게시판</h2>
	<table id="tbl-board">
		<tr>
			<th>글번호</th>
			<td><%=b.boardNo() %></td>
		</tr>
		<tr>
			<th>제 목</th>
			<td><%=b.boardTitle() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=b.boardWriter() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=b.boardReadCount() %></td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
			 
			</td>
		</tr>
		<tr>
			<th>내 용</th>
			<td><%=b.boardContent() %></td>
		</tr>
		<%--글작성자/관리자인경우 수정삭제 가능 --%>
		
		<tr>
			<th colspan="2">
				수정하기, 삭제하기 버튼
			</th>
		</tr>		
	</table>
	<div id="comment-container">
		<div class="comment-editor">
			<form action="<%=request.getContextPath()%>/board/insertcomment"
			 method="post">
				<input type="hidden" name="writer" value="<%=loginMember!=null?loginMember.getUserId():""%>">
				<input type="hidden" name="level" value="1">
				<input type="hidden" name="boardRef" value="<%=b.boardNo()%>">
				<input type="hidden" name="boardCommentRef" value="0">
				<textarea name="content" cols="55" rows="3"></textarea>
				<button type="submit" id="btn-insert">등록</button>
			</form>
		</div> 
		<table id="tbl-comment">
			<%if(comments!=null&&comments.size()>0){
				for(BoardComment bc : comments){
					if(bc.boardCommentLevel()==1){%>
						<tr class="level1">
							<td>
								<!-- <span style=display:none></span> -->
								<sub class="comment-writer">
									<%=bc.boardCommentWriter() %>
								</sub>
								<sub class="comment-date">
									<%=bc.boardCommentDate() %>
								</sub><br>
								<%=bc.boardCommentContent() %>
							</td>
							<td>
								<button class="btn-insert2" value="<%=bc.boardCommentNo()%>">
								답글</button>
							</td>
						</tr>
					<%}else{ %>
						<tr class="level2">
							<td>
								<sub>
									<%=bc.boardCommentWriter() %>
								</sub>
								<sub>
									<%=bc.boardCommentDate() %>
								</sub><br>
								<P><%=bc.boardCommentContent() %></P>
							</td>
							<td>
							</td>
						</tr>
					<%} %>
				<%}
			}%>
		</table>
	</div>
  	<script>
  		$(".comment-editor textarea[name='content']").focus(e=>{
  			const loginCheck=<%=loginMember==null%>;
  			if(loginCheck){
  				alert('로그인 후 이용할 수 있습니다.!');
  				$("#userId").focus();
  			}
  		});
  		$(".btn-insert2").click(e=>{
  			const form=$(".comment-editor>form").clone();
  			form.find("textarea").attr({"cols":"50","rows":"1"});
  			form.find("button").removeAttr("id").addClass("btn-insert2");
  			form.find("input[name='level']").val('2');
  			form.find("input[name='boardCommentRef']").val($(e.target).val());
  			
  			const $parent=$(e.target).parents('tr');
  			const $tr=$("<tr>");
  			const $td=$("<td>").attr("colspan","2");
  			
  			$td.append(form);
  			$tr.append($td);
  			$parent.after($tr);
  			//이벤트 삭제
  			$(e.target).off("click");
  		});
  	</script>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>