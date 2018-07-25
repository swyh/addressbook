<%@ page  contentType="text/html;charset=utf-8" 
import="mybean.db.*, java.sql.*, javax.naming.NamingException"%>
<%
//modify.jsp에서 보낸 값들을 모두 변수로 받는다.
request.setCharacterEncoding("utf-8");
String group_idx = request.getParameter("group_idx"); 
String mygroup = request.getParameter("mygroup");

try {
	AddressbookDB db = new AddressbookDB();
	db.updateGroup(Integer.parseInt(group_idx), mygroup);	// group_idx에 대한 그룹의 이름을 mygroup으로 수정한다.
	db.close();

}catch(NamingException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}

%>

<script>
self.close();
opener.location.reload();	// 자신을 오픈한 opener를 새로고침한다.
</script>