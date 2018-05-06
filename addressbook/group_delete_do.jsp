<%@ page  contentType="text/html;charset=utf-8"
		import="java.sql.*, mybean.db.*, javax.naming.*" %>

<%
request.setCharacterEncoding("utf-8");

String group_idx = request.getParameter("group_idx");  // group_idx 정보를 가져온다.

try {
	AddressbookDB db = new AddressbookDB();

	db.deleteGroup(Integer.parseInt(group_idx));	//group_idx에 대한 그룹을 삭제
	db.close();
}catch(NamingException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}

//만일, 저장이 안되면, 아래 코드 주석처리하여 오류 확인할 것.
	response.sendRedirect("group.jsp");
%>