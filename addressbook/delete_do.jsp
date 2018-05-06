<%@ page  contentType="text/html;charset=utf-8"
		import="java.sql.*, mybean.db.*, javax.naming.*" %>

<%
request.setCharacterEncoding("utf-8");

String idx = request.getParameter("idx");  // 사용자가 입력한 idx 정보를 가져온다. (해당 idx에 대한 연락처 삭제함)
try {
	AddressbookDB db = new AddressbookDB();

	db.deleteRecord(Integer.parseInt(idx));
	db.close();
}catch(NamingException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}

//만일, 저장이 안되면, 아래 코드 주석처리하여 오류 확인할 것.
	response.sendRedirect("trash_can.jsp");
%>