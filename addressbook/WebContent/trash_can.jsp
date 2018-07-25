<%@ page contentType="text/html; charset=UTF-8"
import="java.sql.*, mybean.db.*, javax.naming.*" %>
<%@include file="menu.jsp"%>
<%
Class.forName("com.mysql.jdbc.Driver");
String DB_URL = "jdbc:mysql://localhost:3306/addressbook?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD = "1234";

request.setCharacterEncoding("UTF-8");
String group_idx = request.getParameter("group_idx");
String keyword = request.getParameter("group");
String key = request.getParameter("searchbar");
try{
	AddressbookDB db = new AddressbookDB();
	ResultSet rs;
	int group;
	if(group_idx == null){	// 전체 쿼리 실행
		group = 0;
	}
	else{
		 group = Integer.parseInt(group_idx);	// 그룹별 쿼리 실행
	}
	
	if(key == null){	// 검색한 값이 없을 경우
		rs = db.printList(group, "", "", "trash");
	}
	else{	// 검색한 값이 있을 경우
		rs = db.printList(group, keyword, key, "trash");
	}
	
	

%>
<!DOCTYPE html>
<html>
<head>
<meta  content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="./css.css">
<title>주소록 관리 프로그램</title>
</head>
<body>
	<article>
	<h1 id="name">휴지통 목록</h1>
	 
	<br><br>
	
	<form action="trash_can.jsp" method="get" id = "searchgroup">	<%-- 검색창 --%>
		<select name="group" style="height:30px;">
			<option value="mygroup">그룹명</option>
			<option value="name">이름</option>
			<option value="affiliation">소속</option>
		</select>	
		<input type="text" name="searchbar" placeholder="search">
		<input type="submit" value="검색">
	</form>
		<table border="1">
			<tr>
			<th class="block1">번호</th>
			<th class="block2">그룹</th>
			<th class="block2">이름</th>
			<th class="block4">전화번호</th>
			<th class="block4">이메일</th>
			<th class="block2">소속</th>
			<th class="block2">부서</th>
			<th class="block1">직책</th>
			<th class="block1">복구</th>
			<th class="block2">영구삭제</th>
			<th style="width:10.5px;background-color:white;"></th>
			</tr>
		</table>
		
	<section>
	<table border="1">
		<%
   		 while(rs.next()) {	// rs를 반복시켜 한 사람씩 정보를 읽어 출력한다.
		%><tr class = "list">
		
			<td class="block1"><%=rs.getInt(1)%></td>
			<td class="block2"><%=rs.getString(2)%></td>
			<td class="block2"><%=rs.getString(3)%></td>
			<td class="block4"><%=rs.getString(4)%></td>
			<td class="block4"><%=rs.getString(5)%></td>
			<td class="block2"><%=rs.getString(6)%></td>
			<td class="block2"><%=rs.getString(7)%></td>
			<td class="block1"><%=rs.getString(8)%></td>
			<td class="block1"><a href = "./trash_do.jsp?idx=<%=rs.getInt(1)%>&state=restore">복구</a></td>
			<td class="block2"><a href = "./delete_do.jsp?idx=<%=rs.getInt(1)%>">영구삭제</a></td>
		</tr>
		<%
    }
%>
	</table>
	</section>
	<%

	db.close();	
	
}catch(NamingException e) {	// 각 함수의 throws가 던져줌
	out.print(e);
	return;
} catch (SQLException e) {	// SQL문 예외처리
      out.println("error : "+e.toString());
      return;
} 
%>
	</article>
	</body>
</html>
