<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Member m=(Member)request.getAttribute("loginMember");
	String[] hobby=m.getHobby();
	String[] hobbyCheck=new String[]{"","","","",""};
	for(String h : hobby){
		switch(h){
			case "운동" :hobbyCheck[0]="checked";break;
			case "등산" :hobbyCheck[1]="checked";break;
			case "독서" :hobbyCheck[2]="checked";break;
			case "게임" :hobbyCheck[3]="checked";break;
			case "여행" :hobbyCheck[4]="checked";break;
		}
	}
	
	List<String> hobbyList=Arrays.asList(m.getHobby());
	
%>
<section id=enroll-container>
       <h2>회원 정보</h2>
       <form action="" 
       	method="post" onsubmit="return fn_validate()" >
       <table>
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" placeholder="4글자이상" name="userId" id="userId_" 
				value="<%=m.getUserId()%>" readonly>
			</td>
		</tr>
		<%-- <tr>
			<th>패스워드</th>
			<td>
				<input type="password" name="password" id="password_" 
				value="<%=m.getPassword()%>"><br>
			</td>
		</tr>
		<tr>
			<th>패스워드확인</th>
			<td>	
				<input type="password" id="password_2" ><br>
			</td>
		</tr>   --%>
		<tr>
			<th>이름</th>
			<td>	
			<input type="text"  name="userName" id="userName" 
			value="<%=m.getUserName()%>"><br>
			</td>
		</tr>
		<tr>
			<th>나이</th>
			<td>	
			<input type="number" name="age" id="age" value="<%=m.getAge()%>"><br>
			</td>
		</tr> 
		<tr>
			<th>이메일</th>
			<td>	
				<input type="email" placeholder="abc@xyz.com" name="email" id="email"
				value="<%=m.getEmail()%>"><br>
			</td>
		</tr>
		<tr>
			<th>휴대폰</th>
			<td>	
				<input type="tel" placeholder="(-없이)01012345678" name="phone" 
				id="phone" maxlength="11" required
				value="<%=m.getPhone()%>"><br>
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>	
				<input type="text" placeholder="상세주소" name="address" id="address"
				value="<%=m.getAddress()%>"><br>
			</td>
		</tr>
		<tr>
			<th>성별 </th>
			<td>
				<input type="radio" name="gender" id="gender0" value="M"
						<%=m.getGender().equals("M")?"checked":""%>>
				<label for="gender0">남</label>
				<input type="radio" name="gender" id="gender1" value="F"
					<%=m.getGender().equals("F")?"checked":""%>>
				<label for="gender1">여</label>
				
				<%-- <%if(m.getGender().equals("M")){ %>
					<input type="radio" name="gender" id="gender0" value="M"
					checked>
					<label for="gender0">남</label>
					<input type="radio" name="gender" id="gender1" value="F">
					<label for="gender1">여</label>
				<%}else{ %>
					<input type="radio" name="gender" id="gender0" value="M"
					>
					<label for="gender0">남</label>
					<input type="radio" name="gender" id="gender1" value="F" checked>
					<label for="gender1">여</label>
				<%} %> --%>
			</td>
		</tr>
		<tr>
			<th>취미 </th>
			<td>
				<input type="checkbox" name="hobby" id="hobby0" value="운동"
				<%=hobbyCheck[0] %>><label for="hobby0">운동</label>
				<input type="checkbox" name="hobby" id="hobby1" value="등산"
				<%=hobbyCheck[1] %>><label for="hobby1">등산</label>
				<input type="checkbox" name="hobby" id="hobby2" value="독서"
				<%=hobbyCheck[2] %>><label for="hobby2">독서</label><br />
				<input type="checkbox" name="hobby" id="hobby3" value="게임"
				<%=hobbyCheck[3] %>><label for="hobby3">게임</label>
				<input type="checkbox" name="hobby" id="hobby4" value="여행"
				<%=hobbyCheck[4] %>><label for="hobby4">여행</label><br />
			</td>
		</tr>
	</table>
	<input type="submit" value="수정" >
	<input type="button" value="비밀번호수정">
	<input type="reset" value="취소">
  </form>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>