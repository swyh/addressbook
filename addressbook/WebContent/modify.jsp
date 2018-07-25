<%@ page contentType="text/html; charset=UTF-8" 
import="java.sql.*,mybean.db.*, javax.naming.*"%>
<%@include file="menu.jsp"%>
<%

request.setCharacterEncoding("utf-8");
String idx = request.getParameter("idx"); // 사용자가 전달한 idx값 알아낸다.


try {
	AddressbookDB db = new AddressbookDB();
	People people = db.getRecord(Integer.parseInt(idx));	  //idx에 해당하는 연락처 레코드 가져오기

	ResultSet rs = db.printGroup();	// 쿼리 실행

%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="./css.css">
<meta content=charset="UTF-8">

<title>주소록 수정</title>
</head>
<body>
	<article>
		<form action="./modify_do.jsp" method="post" onsubmit="return check()" enctype="multipart/form-data">
		<input type="hidden" name="idx" id="idx" value="<%=idx%>">
		<table border="1" id="insert">
			<caption style="font-size:150%;padding-bottom:10px;">전화번호 등록</caption>
			<tr>
			<th>그룹</th>
			<td><select id="group_idx" name ="group_idx">
			<%
	   		 while(rs.next()) {		// 그룹에 대한 목록을 나타낸다
	   			 String html_text = "<option value=" + rs.getInt(1);
	   			 if(rs.getInt(1) == people.getGroup_idx())	//수정하고자하는 연락처의 본 그룹에 대해 selected을 하여 나타냄
	   			 	html_text += " selected ";
	   			 html_text += ">" + rs.getString(2) + "</option>";
	   			 
	   			 out.print(html_text);
			}%>
			</select></td>
			</tr> <%-- 해당되는 idx의 people 테이블의 레코드의 정보를 각 input type에 넣어 출력함--%>
			<tr><th>이름</th><td><input type="text" name="name" id="name" value="<%=people.getName()%>"></td></tr>
			<tr><th>사진</th><td><input type="file" accept="image/jpg, image/gif" name="image" id="file" value="<%=people.getImage()%>"></td></tr>
			<tr><th>전화번호</th><td><input type="tel" name="phone" id="phone" value="<%=people.getPhone()%>"></td></tr>
			<tr><th>이메일</th><td><input type="email" name="email" id="email" value="<%=people.getEmail()%>"></td></tr>
			<tr><th>소속</th><td><input type="text" name="affiliation" id="affiliation" value="<%=people.getAffiliation()%>"></td></tr>
			<tr><th>부서명</th><td><input type="text" name="department" id="department" value="<%=people.getDepartment()%>"></td></tr>
			<tr><th>직책</th><td><input type="text" name="duty" id="duty" value="<%=people.getDuty()%>"></td>	</tr>
			<tr><th>생년월일</th><td><input type="date" name="birthday" id="birthday" value="<%=people.getBirthday()%>"></td></tr>
			<tr><th>주소</th><td><input type="text" name="address" id="address" value="<%=people.getAddress()%>"></td></tr>
			<tr><th>홈페이지</th><td><input type="url" name="homepage" id="homepage" value="<%=people.getHomepage()%>"></td></tr>
			<tr><th>SNS</th><td><input type="text" name="sns" id="sns" value="<%=people.getSns()%>"></td></tr>
			<tr><th>ID</th><td><input type="text" name="id" id="id" value="<%=people.getId()%>"></td></tr>
			<tr><th>메모</th><td><textarea name="memo" id="memo"><%=people.getMemo()%></textarea>	</tr>
		</table>
		<div id="decision">
			<input type="submit" value="전송"><%-- 전송시 modify_do.jsp를 통해 DB에 수정되고 index.jsp로 간다. --%>
			<input type="button" value="취소" onclick="location.replace('./index.jsp')"> <%-- 취소시 홈페이지로 복귀 --%>
		</div>
		</form>
	</article>

</body>
</html>
<%
	db.close();

}catch(SQLException e) {
	out.print(e);
	return;
}catch(NamingException e) {
	out.print(e);
	return;
}
%>