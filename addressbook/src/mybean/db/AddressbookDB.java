package mybean.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.NamingException;

public class AddressbookDB {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public AddressbookDB() throws NamingException, SQLException{	// connection pool로 동작하게 하기 위한 함수
		conn = DsCon.getConnection();
	}
	
	public void setPstmt(People people) throws SQLException{
		//pstmt에 사용자에게 입력받은 값을 넣음
		pstmt.setInt(1, people.getGroup_idx());
		pstmt.setString(2, people.getName());
		pstmt.setString(3, people.getImage());
		pstmt.setString(4, people.getPhone());
		pstmt.setString(5, people.getEmail());
		pstmt.setString(6, people.getAffiliation());
		pstmt.setString(7, people.getDepartment());
		pstmt.setString(8, people.getDuty());
		pstmt.setString(9, people.getBirthday());
		pstmt.setString(10, people.getAddress());
		pstmt.setString(11, people.getHomepage());
		pstmt.setString(12, people.getSns());
		pstmt.setString(13, people.getId());
		pstmt.setString(14, people.getMemo());
	}
	
	public void insertRecord(People people) throws SQLException{
		//people 테이블에서 해당되는 idx의 레코드에서 값을 삽입하기 위한 쿼리문
		String sql = "INSERT INTO people(group_idx,name,image,phone,email,affiliation,department,duty,birthday,address,homepage,SNS,ID,memo) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		pstmt = conn.prepareStatement(sql); 
		setPstmt(people);
		
		pstmt.executeUpdate();
	}
	
	public void insertGroup(String mygroup) throws SQLException{	// DB의 allgroup table에 group을 추가시켜주는 함수
		String sql = "INSERT INTO allgroup(mygroup) VALUES(?)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mygroup);

		pstmt.executeUpdate();
	}
	
	public void updateRecord(People people) throws SQLException{	// people의 정보를 update 시켜주는 함수 (연락처 수정) 
		String sql = "UPDATE people SET group_idx=?,name=?,image=?,phone=?,email=?,affiliation=?,department=?,duty=?,birthday=?,address=?,homepage=?,SNS=?,ID=?,memo=? WHERE idx = ?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(15, people.getIdx());
		setPstmt(people);
		
		pstmt.executeUpdate();
	}
	
	public void updateGroup(int group_idx, String mygroup) throws SQLException{	// group name을 수정하는 함수
		String sql = "UPDATE allgroup SET mygroup = ? WHERE group_idx = ?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mygroup);
		pstmt.setInt(2, group_idx);
		pstmt.executeUpdate();
	}
	
	public void trashRecord(int idx, String state) throws SQLException{	// 상태(state)에 따라 쓰레기통으로 보내거나 되돌리는 함수
		String sql = "UPDATE people SET trash=";
		
		if(state.equals("trash")) //연락처를 쓰레기통으로 보냄
			sql += "1";
		else if(state.equals("restore"))	// 연락처를 복구시킴
			sql += "0";
		
		sql += " WHERE idx = ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, idx);
		
		pstmt.executeUpdate();
	}
	
	public void deleteRecord(int idx) throws SQLException{ // people 테이블에서 해당되는 idx를 가진 주소록을 삭제하는 함수(연락처 삭제)
		String sql = "delete from people where idx=?"; 
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, idx);
		
		pstmt.executeUpdate();
	}
	
	public void deleteGroup(int group_idx) throws SQLException{ // allgroup 테이블에서 해당되는 group_idx를 가진 그룹 삭제하고 연관된 연락처 모두 삭제
		String sql = "delete from people where group_idx=?"; 

		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, group_idx);
		pstmt.executeUpdate();	// 그룹 내 연락처 삭제
		
		sql = "delete from allgroup where group_idx=?"; 
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, group_idx);
		pstmt.executeUpdate();	// 그룹 삭제
	}
	
	public People getRecord(int idx) throws SQLException{	// 모든 레코드를 설정하여 객체로 반환
		String sql = "SELECT * FROM people WHERE idx=?"; // people 테이블에서 idx에 해당하는 정보를 가져오기 위한 쿼리문
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,  idx);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		People people = new People();
		
		people.setIdx(idx);
		people.setGroup_idx(rs.getInt("group_idx"));
		people.setName(rs.getString("name"));
		people.setImage(rs.getString("image"));
		people.setPhone(rs.getString("phone"));
		people.setEmail(rs.getString("Email"));
		people.setAffiliation(rs.getString("Affiliation"));
		people.setDepartment(rs.getString("Department"));
		people.setDuty(rs.getString("Duty"));
		people.setBirthday(rs.getString("birthday"));
		people.setAddress(rs.getString("address"));
		people.setHomepage(rs.getString("homepage"));
		people.setSns(rs.getString("sns"));
		people.setId(rs.getString("id"));
		people.setMemo(rs.getString("memo"));
		
		return people;
	}
	
	public String getGroup(int group_idx) throws SQLException{	// 해당되는 그룹의 index의 그룹명을 찾아 리턴
		String sql = "SELECT mygroup FROM allgroup WHERE group_idx=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, group_idx);
		rs = pstmt.executeQuery();
		rs.next();
		
		return rs.getString("mygroup"); 
	}
	
	public ResultSet printGroup() throws SQLException{	// 모든 그룹이 들어잇는 resultset을 리턴
		String sql = "SELECT group_idx, mygroup FROM allgroup"; // 모든 group을 찾는다.
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		return rs;
	}
	
	public ResultSet printList(int group_idx, String keyward, String key, String location) throws SQLException{	// 해당 그룹 인덱스 번호에 대한 연락처들의 resultSet을 반환
		String sql = "SELECT idx,mygroup,name,phone,email,affiliation,department,duty FROM people, allgroup WHERE people.group_idx = allgroup.group_idx";
		if(group_idx != 0)	//group을 선택했을 때, 해당되는 group index를 찾아 조건을 줘서 찾는다.
			sql += " AND people.group_idx = " + group_idx;
		 
		if(keyward != "")	// search를 하였을 경우 keyward(그룹, 이름, 소속 등)에 대한 key이 존재하는지 찾아준다.
			sql += " AND " + keyward + " LIKE " + "'%" +key + "%'";
		
		if(location == "trash")	// 검색한 위치가 휴지통인 경우, 휴지통의 목록만 나타낸다.
			sql +=  " AND trash = 1";
		else
			sql += " AND trash = 0";
		
		sql += " GROUP BY idx";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery(sql);
		
		return rs;
	}
	
	public ResultSet groupList(String type) throws SQLException{	// 모든 그룹과 그룹에 속한 연락처가 몇 개인지 찾아서 resultSet으로 반환
		String sql = "select group_idx, mygroup, count(idx) FROM allgroup LEFT JOIN (select * from people where trash = 0) a USING (group_idx) GROUP BY mygroup";
		if(type != null){
			if(type.equals("group_idx"))	// group_idx 오름차순으로 정렬한다.
				sql += " ORDER BY group_idx";
			else if(type.equals("count"))	// 인원순으로 정렬한다.
			sql += " ORDER BY count(idx) DESC";
		}
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery(sql);
		return rs;
	}
	
	
	public void close() throws SQLException {	// 종료 함수
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
}
