<%@ page contentType="text/html; charset=UTF-8"
import="java.sql.*, mybean.db.*, javax.naming.*" %>
<%@include file="menu.jsp"%>
<%
request.setCharacterEncoding("UTF-8");
String group_idx = request.getParameter("group_idx");
String keyword = request.getParameter("group");
String key = request.getParameter("searchbar");
try{
	AddressbookDB db = new AddressbookDB();
	ResultSet rs;
	String mygroup;	//group_idx에 해당되는 그룹명을 저장하는 변수
	int group;	// group_idx에 해당되는 리스트를 출력하기 위한 변수로, 해당되는 group_idx를 저장하고 전체목록일 경우 0이다.
	
	if(group_idx == null){	// 전체 쿼리 실행
		group = 0;
		mygroup = "연락처 목록";
	}
	else{
		group = Integer.parseInt(group_idx);	// 그룹별 쿼리 실행
		mygroup = db.getGroup(Integer.parseInt(group_idx));
	}
	
	if(key == null){	// 검색한 값이 없을 경우
		rs = db.printList(group, "", "", "all");
	}
	else{	// 검색한 값이 있을 경우
		rs = db.printList(group, keyword, key, "all");
	}

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
	<h1 id="name"><%=mygroup %></h1>
	 
	 
	<a href="./insert.jsp" style="color:blue"><em><u>연락처 추가</u></em></a><br><br>
	
	<form action="index.jsp" method="get" id = "searchgroup">	<%-- 검색창 --%>
		<select name="group" style="height:30px;">
			<option value="mygroup">그룹명</option>
			<option value="name">이름</option>
			<option value="affiliation">소속</option>
		</select>	
		<input type="text" name="searchbar" placeholder="search">
		<input type="submit" value="검색">
	</form>
		<table border="1">
			<tr>
			<th class="block1">번호</th>
			<th class="block2">그룹</th>
			<th class="block2">이름</th>
			<th class="block4">전화번호</th>
			<th class="block4">이메일</th>
			<th class="block2">소속</th>
			<th class="block2">부서</th>
			<th class="block2">직책</th>
			<th class="block1">수정</th>
			<th class="block1">삭제</th>
			<th style="width:10px;background-color:white;"></th>
			</tr>
		</table>
		
	<section>
	<table border="1">
		<%
   		 while(rs.next()) {	// rs를 반복시켜 한 사람씩 정보를 읽어 출력한다.
		%><tr class = "list">
		
			<td class="block1"><%=rs.getInt(1)%></td>
			<td class="block2"><%=rs.getString(2)%></td>
			<td class="block2"><a href = "./list.jsp?idx=<%=rs.getInt(1)%>"><%=rs.getString(3)%></a></td>
			<td class="block4"><%=rs.getString(4)%></td>
			<td class="block4"><%=rs.getString(5)%></td>
			<td class="block2"><%=rs.getString(6)%></td>
			<td class="block2"><%=rs.getString(7)%></td>
			<td class="block2"><%=rs.getString(8)%></td>
			<td class="block1"><a href = "./modify.jsp?idx=<%=rs.getInt(1)%>">수정</a></td>
			<td class="block1"><a href = "./trash_do.jsp?idx=<%=rs.getInt(1)%>&state=trash">삭제</a></td>
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
