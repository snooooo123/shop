package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.Outid;

public class OutidDao {
	
	public int selectOutidCount() {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					SELECT count(*)
					FROM outid
				""";
		
		int total = 0;
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			total = rs.getInt("count(*)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}		
		return total;
	}
	
	
	
	// outid 리스트 20행
	public List<Outid> selectOutidList(int startRow) {
		List<Outid> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					SELECT id, memo, createdate
					FROM outid
					offset ? rows fetch next 20 rows only 
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Outid oi = new Outid();
				oi.setId(rs.getString(1));
				oi.setMemo(rs.getString(2));
				oi.setCreatedate(rs.getString(3));
				list.add(oi);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	} 
}
