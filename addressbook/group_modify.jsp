<%@ page contentType="text/html; charset=UTF-8"
import="java.sql.*, mybean.db.*, javax.naming.*" %>
<%
	String group_idx = request.getParameter("group_idx");
%>
<!DOCTYPE html>
<html>
<head>
<meta  content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="./css.css">
<title>그룹명 변경</title>
</head>
<body>
변경할 이름을 적어주세요.
		<form action="group_modify_do.jsp" method="post">	<%-- 수정창 --%>
				<input type="hidden" name="group_idx" value="<%=group_idx%>">	<%--group_idx를 hidden으로 받아서 group_modify_do.jsp로 전달 --%>
				<input type="text" name="mygroup">
				<input type="submit" value="수정">
				</form>
</body>
</html>
