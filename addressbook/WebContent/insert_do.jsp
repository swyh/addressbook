<%@ page  contentType="text/html;charset=utf-8" 
import="java.sql.*,mybean.db.*,javax.naming.*" import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
import="java.util.*, java.io.*"%>

<%
request.setCharacterEncoding("utf-8");

int maxsize = 5*1024*1024;
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");	// 파일의 저장 경로를 알아냄

try {
	
	MultipartRequest multi = new MultipartRequest(request, realFolder,maxsize, "utf-8",new DefaultFileRenamePolicy());
	
	//insert.jsp에서 보낸 값들을 모두 변수로 받는다.
	String group_idx = multi.getParameter("group_idx");
	String name = multi.getParameter("name");
	
	String image = multi.getFilesystemName("image");
	if(image==null)	//image가 없을 경우 default.gif 사진으로 표시하도록함
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
	db.insertRecord(people);
	db.close();

}catch(NamingException e) {	// forName 때문에
	out.print(e);
	return;
}catch(SQLException e) {	// connection, preparedStatement 등 sql문 때문에
	out.print(e);
	return;
}catch(IOException e) {
	out.print(e);
	return;
}
response.sendRedirect("index.jsp");
%>