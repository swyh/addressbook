<%@ page contentType="text/html; charset=UTF-8"
import="java.sql.*, mybean.db.*, javax.naming.*" %>
<%@include file="menu.jsp"%>
<%
	String type = request.getParameter("type");
	type = Util.nullChk(type);	// tyoe이 null이면 blank로 반환
	Class.forName("com.mysql.jdbc.Driver");
	String DB_URL = "jdbc:mysql://localhost:3306/addressbook?useSSL=false";
	String DB_USER = "admin";
	String DB_PASSWORD = "1234";
	String group_idx = request.getParameter("group_idx");
	String keyword = request.getParameter("group");
	String key = request.getParameter("searchbar");
	
	try{
	AddressbookDB db = new AddressbookDB();
	ResultSet rs = db.groupList(type);
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
	<h1 id="name">그룹 목록</h1>
	<br>
	 
<%	// 체크박스에서 어떻게 정렬할지 선택하였을때 해당 정렬에 대한 링크로 간다(get방식을 통한 파라미터 전달)
	 String type_value[] = {"", "group_idx", "count"};
	 String type_view[] = {"이름순", "등록순", "인원순"};
			 
	 for(int i = 0; i < type_value.length; i++){
		 String html_txt = "<input type=\"radio\"";
		 
		 if(type.equals(type_value[i]))
			 html_txt += " checked";
		 
		 html_txt +=  " name=\"order\" value=\"" + type_value[i] +"\" onclick=\"location.href='group.jsp";
		
		 if(i == 0)
			 html_txt += "'\">";
		 else
			 html_txt += "?type=" + type_value[i] + "'\">";
		 
		 out.print(html_txt);
		 out.print(type_view[i]);
	 }
%>
	<form action="group_insert_do.jsp" method="post" id = "searchgroup">	<%-- 검색창 --%>
		<input type="text" name="searchbar" placeholder="Add group">
		<input type="submit" value="추가">
	</form>
	
	<table border="1">
		<tr>
		<th class="block2">번호</th>
		<th class="block4">그룹</th>
		<th class="block3">그룹 인원</th>
		<th class="block1">수정</th>
		<th class="block1">삭제</th>
		<th style="width:5px;background-color:white;"></th>
		</tr>
	</table>
		
	<section>
	<table border="1">
		<%
   		 while(rs.next()) {	// rs를 반복시켜 한 사람씩 정보를 읽어 출력한다.
		%><tr class = "list">
			<td class="block2"><%=rs.getInt(1)%></td>
			<td class='block4'><%=rs.getString(2)%></td>
			<td class="block3"><%=rs.getString(3)%></td>
			<td class="block1"><a href="#" onclick="window.open('./group_modify.jsp?group_idx=<%=rs.getInt(1)%>', 'insert', 'height=100px, width=250px')">수정</a></td>
			<td class="block1"><a href = "./group_delete_do.jsp?group_idx=<%=rs.getInt(1)%>">삭제</a></td>
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
