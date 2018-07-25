package mybean.db;

import javax.naming.*;
import java.sql.*;
import javax.sql.DataSource;

public class DsCon {	// connection pool 동작
	public static Connection getConnection() throws NamingException, SQLException{
		Context initContext = new InitialContext();
		DataSource ds = (DataSource)initContext.lookup("java:/comp/env/jdbc/addressbookDB");
		
		return ds.getConnection();
	}
}
