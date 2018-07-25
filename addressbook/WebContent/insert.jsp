<%@ page language="java" contentType="text/html; charset=UTF-8"
import="java.sql.*, mybean.db.*, javax.naming.*" %>
<%@include file="menu.jsp"%>
<%
	try{
		
		AddressbookDB db = new AddressbookDB();
		ResultSet rs = db.printGroup();	// 쿼리 실행

%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="./css.css">
<meta charset="UTF-8">
<title>주소록 추가</title>

<script>
function check(){
	// 이름은 1~9개의 문자, 전화번호는 12개의 숫자로 이뤄져있는지 판별
	var exp_name = /^.{1,9}$/;
	var obj_name = document.getElementById("name");
	
	var exp_phone = /^[0-9]{3}?[0-9]{4}?[0-9]{4}$/;
	var obj_phone = document.getElementById("phone");
	
	if(!obj_name.value.match(exp_name)){
		alert("이름을 1-9글자 이내로 입력해주세요.");
		obj_name.focus();
		return false;
	}
	
	if(!obj_phone.value.match(exp_phone)){
		alert("전화번호를 올바르게 입력해주세요(-없이)");
		obj_phone.focus();
		return false;
	}
	
	insertAlert();
}
</script>

</head>
<body>
	<article>
		<form action="./insert_do.jsp" method="post" onsubmit="return check()" enctype="multipart/form-data">
		<table border="1" id="insert"><%--정보를 받기위한 테이블 --%>
			<caption style="font-size:150%;padding-bottom:10px;">전화번호 등록</caption>
			<tr>
			<th>그룹</th>
			<td><select id="group_idx" name ="group_idx">
			<%
	   		 while(rs.next()) {
			%>
			<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option><!-- 모든 그룹명을 출력하고, value 값은 group_idx로 쓴다. -->
			<%
			}%>
			</select></td>
			</tr> 
			<tr><th>이름</th><td><input type="text" name="name" id="name"></td></tr>
			<tr><th>사진</th><td><input type="file" accept="image/jpg, image/gif" name="image" id="file"></td></tr>
			<tr><th>전화번호</th><td><input type="tel" name="phone" id="phone"></td></tr>
			<tr><th>이메일</th><td><input type="email" name="email" id="email"></td></tr>
			<tr><th>소속</th><td><input type="text" name="affiliation" id="affiliation"></td></tr>
			<tr><th>부서명</th><td><input type="text" name="department" id="department"></td></tr>
			<tr><th>직책</th><td><input type="text" name="duty" id="duty"></td>	</tr>
			<tr><th>생년월일</th><td><input type="date" name="birthday" id="birthday"></td></tr>
			<tr><th>주소</th><td><input type="text" name="address" id="address"></td></tr>
			<tr><th>홈페이지</th><td><input type="url" name="homepage" id="homepage"></td></tr>
			<tr><th>SNS</th><td><input type="text" name="sns" id="sns"></td></tr>
			<tr><th>ID</th><td><input type="text" name="id" id="id"></td></tr>
			<tr><th>메모</th><td><textarea name="memo" id="memo"></textarea>	</tr>
		</table>
		<div id="decision">
			<input type="submit" value="전송"><%-- 전송시 insert_do.jsp를 통해 DB에 저장되고 index.jsp로 간다. --%>
			<input type="button" value="취소" onclick="location.replace('./index.jsp')"><%-- 취소시 홈페이지로 복귀 --%>
		</div>
		</form>
	</article>

</body>
</html>
		<%

		db.close(); 

	}catch(NamingException e) {	// 각 함수의 throws가 던져줌
		out.print(e);
		return;
	} catch (SQLException e) {
      out.println("error : "+e.toString());
      return;
} 
%>