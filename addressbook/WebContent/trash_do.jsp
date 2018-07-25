<%@ page  contentType="text/html;charset=utf-8"
		import="java.sql.*, mybean.db.*, javax.naming.*" %>

<%
request.setCharacterEncoding("utf-8");

String idx = request.getParameter("idx");  // 사용자가 입력한 idx 정보를 가져온다.
String state = request.getParameter("state"); // 사용자가 삭제하는지 복구하는지 알아냄
try {
	AddressbookDB db = new AddressbookDB();

	db.trashRecord(Integer.parseInt(idx), state);	//trashRecord 함수를 통해 해당 idx의 연락처가 휴지통 또는 복원하도록 함.
	db.close();
}catch(NamingException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}

//만일, 저장이 안되면, 아래 코드 주석처리하여 오류 확인할 것.
if(state.equals("trash"))
	response.sendRedirect("index.jsp");
else if(state.equals("restore"))
	response.sendRedirect("trash_can.jsp");
%>