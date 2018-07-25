<%@ page contentType="text/html; charset=UTF-8" 
import="java.sql.*, mybean.db.*, javax.naming.*" %>

<%
	try{
		AddressbookDB db = new AddressbookDB();
		ResultSet rs = db.printGroup();	// 쿼리 실행
%>
<!DOCTYPE html>
<html>
<head>
<meta  content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="./css.css">
</head>
<body>
	<header>
	<h1>주소록 관리 프로그램</h1>
	</header>
	<nav id="menu">	<%-- 상단메뉴 --%>
		<ul>
			<li><a href="./index.jsp">전체 연락처 보기</a></li>
			<li><a href="./group.jsp">그룹 관리</a></li>
			<li><a href="./trash_can.jsp">휴지통 관리</a></li>
		</ul>
	</nav>
	<nav id="side_menu">
		<ul>
			<li><a href="./index.jsp">전체 연락처 보기</a></li>
			<%
	   		 while(rs.next()) {
			%>
			<li><a href="./index.jsp?group_idx=<%=rs.getInt(1)%>"><%=rs.getString(2)%></a></li>
			<%-- 그룹을 누르면 해당 group_idx를 get 방식으로 전달한다. 리스트 형식으로 사이드 메뉴에 각 그룹명을 표시 --%>
			<%
			}
			%>
		</ul>
	</nav>
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
</body>
</html>