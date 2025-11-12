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
 *	상품 수익 top10 - 막대차트
 */
		public List<Map<String, Object>> selectOrderPriceByGoods(String fromYM, String toYM) {
			List<Map<String, Object>> list = new ArrayList<>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;			
			String sql = """
						SELECT goods_code codes, sum(order_price) total
						FROM orders
						WHERE createdate
						BETWEEN to_date(?, 'yyyy-mm-dd')
						AND to_date(?, 'yyyy-mm-dd')
						GROUP BY goods_code
						ORDER BY total desc
						OFFSET 0 rows fetch next 10 rows only
					""";
			try {
				conn = DBConnection.getConn();
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, fromYM);
				stmt.setString(2, toYM);
				rs = stmt.executeQuery();
				while(rs.next()) {
					Map<String, Object> m = new HashMap<>();
					m.put("codes",rs.getString("codes"));
					m.put("total",rs.getInt("total"));
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
 *	상품 주문금액 top10 - 막대차트
 */
		public List<Map<String, Object>> selectOrderCntByGoods(String fromYM, String toYM) {
			List<Map<String, Object>> list = new ArrayList<>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;			
			String sql = """
						SELECT t.cnt cnt
							   , listagg(t.goods_code,',') within group (order by t.goods_code) codes
						FROM    
						    (SELECT goods_code, count(*) cnt					     
						    FROM orders
						    WHERE createdate
						    BETWEEN to_date(?, 'yyyy-mm-dd')
						    AND to_date(?, 'yyyy-mm-dd')
						    GROUP BY goods_code) t
						GROUP BY cnt
						ORDER BY cnt DESC
						offset 0 rows fetch next 10 rows only
					""";
			try {
				conn = DBConnection.getConn();
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, fromYM);
				stmt.setString(2, toYM);
				rs = stmt.executeQuery();
				while(rs.next()) {
					Map<String, Object> m = new HashMap<>();
					m.put("codes",rs.getString("codes"));
					m.put("cnt",rs.getInt("cnt"));
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
 *	주문금액 top10 - 막대차트
 */
		public List<Map<String, Object>> selectOrderPriceByCustomer(String fromYM, String toYM) {
			List<Map<String, Object>> list = new ArrayList<>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;			
			String sql = """
						SELECT customer_code codes, sum(order_price) total
						FROM orders
						WHERE createdate
						BETWEEN to_date(?, 'yyyy-mm-dd')
						AND to_date(?, 'yyyy-mm-dd')
						GROUP BY customer_code
						ORDER BY total desc
						OFFSET 0 rows fetch next 10 rows only
					""";
			try {
				conn = DBConnection.getConn();
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, fromYM);
				stmt.setString(2, toYM);
				rs = stmt.executeQuery();
				while(rs.next()) {
					Map<String, Object> m = new HashMap<>();
					m.put("codes",rs.getString("codes"));
					m.put("total",rs.getInt("total"));
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
 *	주문량 top10 - 막대차트
 */
		public List<Map<String, Object>> selectOrderCntByCustomer(String fromYM, String toYM) {
			List<Map<String, Object>> list = new ArrayList<>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;			
			String sql = """
						SELECT t.cnt cnt
							   , listagg(t.customer_code,',') within group (order by t.customer_code) codes
						FROM    
						    (SELECT customer_code, count(*) cnt					     
						    FROM orders
						    WHERE createdate
						    BETWEEN to_date(?, 'yyyy-mm-dd')
						    AND to_date(?, 'yyyy-mm-dd')
						    GROUP BY customer_code) t
						GROUP BY cnt
						ORDER BY cnt DESC
						offset 0 rows fetch next 10 rows only
					""";
			try {
				conn = DBConnection.getConn();
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, fromYM);
				stmt.setString(2, toYM);
				rs = stmt.executeQuery();
				while(rs.next()) {
					Map<String, Object> m = new HashMap<>();
					m.put("codes",rs.getString("codes"));
					m.put("cnt",rs.getInt("cnt"));
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
 *	성별 주문량 - 파이 차트
 */
		public List<Map<String, Object>> selectOrderPriceByGender() {
			List<Map<String, Object>> list = new ArrayList<>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;		
			String sql = """
						SELECT t.g, SUM(order_price) total
						FROM
							(SELECT c.gender g
									, o.order_price 
							FROM customer c
							INNER JOIN orders o
							ON c.customer_code = o.customer_code) t
						GROUP BY t.g
						ORDER BY total ASC
					""";
			try {
				conn = DBConnection.getConn();
				stmt = conn.prepareStatement(sql);
				rs = stmt.executeQuery();
				while(rs.next()) {
					Map<String, Object> m = new HashMap<>();
					m.put("gender",rs.getString("g"));
					m.put("total",rs.getString("total"));
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
 *	성별 주문량 - 파이 차트
 */
	public List<Map<String, Object>> selectOrderCntByGender() {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;		
		String sql = """
					SELECT t.g, count(*) cnt
					FROM
						(SELECT c.gender g, o.order_code
						FROM customer c
						INNER JOIN orders o
						ON c.customer_code = o.customer_code) t
					GROUP BY t.g
					ORDER BY cnt ASC
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				m.put("gender",rs.getString("g"));
				m.put("count",rs.getString("cnt"));
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
 *	월 판매금액 - 막대차트
 */
	public List<Map<String, Object>> selectOrderPriceByYM(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;		
		String sql = """
					SELECT to_char(createdate, 'yyyy-mm') ym
							   , SUM(order_price) total 
						FROM orders
						WHERE createdate
						BETWEEN to_date(?, 'yyyy-mm-dd')
				        AND to_date(?, 'yyyy-mm-dd')
				        GROUP BY to_char(createdate, 'yyyy-mm')
				        ORDER BY ym
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
				m.put("total",rs.getString("total"));
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
 *	월 주문량 - 막대차트
 */
	public List<Map<String, Object>> selectOrderCntByYM(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;			
		String sql = """
					SELECT to_char(createdate, 'yyyy-mm') ym
				        		, count(*) cnt
				        FROM orders
				        WHERE createdate
				        BETWEEN to_date(?, 'yyyy-mm-dd')
				        AND to_date(?, 'yyyy-mm-dd')
				        GROUP BY to_char(createdate, 'yyyy-mm')
				        ORDER BY ym ASC
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
				m.put("cnt",rs.getInt("cnt"));
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
