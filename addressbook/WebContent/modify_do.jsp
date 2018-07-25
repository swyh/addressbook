<%@ page  contentType="text/html;charset=utf-8" 
import="mybean.db.*, java.sql.*, javax.naming.NamingException" import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
import="java.util.*, java.io.*"%>
<%
//modify.jsp에서 보낸 값들을 모두 변수로 받는다.

request.setCharacterEncoding("utf-8");

int maxsize = 5*1024*1024;
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");


try {
	MultipartRequest multi = new MultipartRequest(request, realFolder,maxsize, "utf-8",new DefaultFileRenamePolicy());

	String idx = multi.getParameter("idx"); 
	String group_idx = multi.getParameter("group_idx"); 
	String name = multi.getParameter("name");
	String image = multi.getFilesystemName("image");
	if(image==null)	// 이미지가 선택되지 않았을 경우 default.gif로 저장
		image="default.gif";
	String phone = multi.getParameter("phone");
	String email = multi.getParameter("email");
	String affiliation = multi.getParameter("affiliation");
	String department = multi.getParameter("department");
	String duty = multi.getParameter("duty");
	String birthday = multi.getParameter("birthday");
	String address = multi.getParameter("address");
	String homepage = multi.getParameter("homepage");
	String sns = multi.getParameter("sns");
	String id = multi.getParameter("id");
	String memo = multi.getParameter("memo");

	People people = new People();
	people.setIdx(Integer.parseInt(idx));
	people.setGroup_idx(Integer.parseInt(group_idx));
	people.setName(name);
	people.setImage(image);
	people.setPhone(phone);
	people.setEmail(email);
	people.setAffiliation(affiliation);
	people.setDepartment(department);
	people.setDuty(duty);
	people.setBirthday(birthday);
	people.setAddress(address);
	people.setHomepage(homepage);
	people.setSns(sns);
	people.setId(id);
	people.setMemo(memo);
	
	AddressbookDB db = new AddressbookDB();
	db.updateRecord(people);
	db.close();

}catch(NamingException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}catch(IOException e) {
	out.print(e);
	return;
}

response.sendRedirect("index.jsp");
%>