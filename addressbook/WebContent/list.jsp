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

<title>주소록 보기</title>
</head>
<body>
	<article>
		<input type="hidden" name="idx" id="idx" value="<%=idx%>">
		<table border="1" id="insert">
			<caption style="font-size:150%;padding-bottom:10px;">전화번호 등록</caption>
			<tr>
			<th>그룹</th>
			<td><select id="group_idx" name ="group_idx">
			<%
	   		 while(rs.next()) {
			%>
			<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option> <!-- 모든 그룹명을 출력하고, value 값은 group_idx로 쓴다. -->
			<%
			}%>
			</select></td>
			</tr> <%-- 해당되는 idx의 people 테이블의 레코드의 정보를 각 input type에 넣어 출력함--%>
			<tr><th>이름</th><td><%=people.getName()%></tr>
			<tr><th>사진</th><td><IMG src="<%= "upload/"+people.getImage()%>" width="75" height="100"></tr>
			<tr><th>전화번호</th><td><%=people.getPhone()%></td></tr>
			<tr><th>이메일</th><td><%=people.getEmail()%></td></tr>
			<tr><th>소속</th><td><%=people.getAffiliation()%></td></tr>
			<tr><th>부서명</th><td><%=people.getDepartment()%></td></tr>
			<tr><th>직책</th><td><%=people.getDuty()%></td>	</tr>
			<tr><th>생년월일</th><td><%=people.getBirthday()%></td></tr>
			<tr><th>주소</th><td><%=people.getAddress()%></td></tr>
			<tr><th>홈페이지</th><td><%=people.getHomepage()%></td></tr>
			<tr><th>SNS</th><td><%=people.getSns()%></td></tr>
			<tr><th>ID</th><td><%=people.getId()%></td></tr>
			<tr><th>메모</th><td><%=people.getMemo()%></td></tr>
		</table>
		<div id="decision">
			<input type="button" value="뒤로" onclick="location.replace('./index.jsp')"> <%-- 취소시 홈페이지로 복귀 --%>
		</div>
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