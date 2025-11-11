package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StatsDao {
	// 11 개  chart 메서드
	
	/*
	 *	특정년도의 월별 주문횟수(누적)
	 */
	public List<Map<String, Object>> selectOrderTotalCntByYM(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;			
		String sql = """
					SELECT t.ym	ym			
						   , SUM(t.cnt) OVER(order by t.ym ASC) totalOrder				    
				    FROM   
				    	(SELECT to_char(createdate, 'yyyy-mm') ym
				        		, count(*) cnt
				        FROM orders
				        WHERE createdate
				        BETWEEN to_date(?, 'yyyy-mm-dd')
				        AND to_date(?, 'yyyy-mm-dd')
				        GROUP BY to_char(createdate, 'yyyy-mm')) t
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				m.put("ym",rs.getString("ym"));
				m.put("totalOrder",rs.getString("totalOrder"));
				list.add(m);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
		return list;
	}
	/*
	 *	특정년도의 월별 주문금액(누적)
	 */
	public List<Map<String, Object>> selectOrderTotalPriceByYM(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;		
		String sql = """
					SELECT t.ym ym
						   , SUM(t.total) OVER(ORDER BY t.ym ASC) totalPrice 
						FROM
						(SELECT to_char(createdate, 'yyyy-mm') ym
							   , SUM(order_price) total 
						FROM orders
						WHERE createdate
						BETWEEN to_date(?, 'yyyy-mm-dd')
				        AND to_date(?, 'yyyy-mm-dd')
				        GROUP BY to_char(createdate, 'yyyy-mm')) t
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				m.put("ym",rs.getString("ym"));
				m.put("totalPrice",rs.getString("totalPrice"));
				list.add(m);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
		return list;		
	}
}
