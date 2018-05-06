<%@ page  contentType="text/html;charset=utf-8" 
import="java.sql.*,mybean.db.*,javax.naming.*" %>
<%
//group.jsp에서 보낸 값들을 모두 변수로 받는다.
request.setCharacterEncoding("utf-8");
String mygroup = request.getParameter("searchbar");

try {
	AddressbookDB db = new AddressbookDB();
	db.insertGroup(mygroup);	// 사용자로부터 받은 값의 group 이름의 db record를 추가시킨다.
	db.close();

}catch(NamingException e) {	// forName 때문에
	out.print(e);
	return;
}catch(SQLException e) {	// connection, preparedStatement 등 sql문 때문에
	out.print(e);
	return;
}
response.sendRedirect("group.jsp");
%>