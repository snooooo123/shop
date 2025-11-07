package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Notice;

public class NoticeDao {
	// /emp/insertNotice
	public List<Map<String, Object>> selectNoticeList(int beginRow, int rowPerPage) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					SELECT
						n.notice_code noticeCode
						, n.notice_title noticeTitle
						, e.emp_id empId
						, n.createdate								
					FROM notice n INNER JOIN Emp e
					ON n.emp_code = e.emp_code
					ORDER BY n.notice_code DESC
					OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) { 
				Map<String, Object> m = new HashMap<>();
				m.put("noticeCode", rs.getInt("noticeCode"));
				m.put("noticeTitle", rs.getString("noticeTitle"));
				m.put("empId", rs.getString("empId"));
				m.put("createdate",rs.getString("createdate"));
				list.add(m);
			}
			
		} catch (Exception e1) {
			// conn.rollback
			e1.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return list;
	}
	public int selectCount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select count(*) from notice
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			rs.next();
			count = rs.getInt("count(*)"); 
			
		} catch (Exception e1) {
			// conn.rollback
			e1.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return count;
	}
	
	// /emp/insertNotice
	public int insertNotice(Notice n) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = """
				
				""";
		try {
			
		} catch (Exception e1) {
			// conn.rollback
			e1.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return row;
	}
	// /emp/noticeList
	
	// /emp/noticeOne
	public Notice selectNoticeOne(int noticeCode) {
		Notice resultNotice = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
				
				""";
		try {
			
		} catch (Exception e1) {
			// conn.rollback
			e1.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return resultNotice;
	}
	// /emp/removeNotice
	public int deleteNotice(Notice n) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = """
				
				""";
		try {
			
		} catch (Exception e1) {
			// conn.rollback
			e1.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return row;
	}
	// /emp/modifyNotice
	public int updateNotice(Notice n) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = """
				
				""";
		try {
			
		} catch (Exception e1) {
			// conn.rollback
			e1.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return row;
	}
}
