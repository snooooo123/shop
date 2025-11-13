package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Cart;

public class CartDao {
	// 장바구니->결제
	public Map<String, Object> selectCartListByKey(int cartCode) {
		Connection conn = null;
		PreparedStatement stmt = null;		
		ResultSet rs = null;
		String sql = """
					SELECT gi.filename					    
					    , g.goods_code
					    , g.goods_name
					    , g.goods_price    
					    , g.point_rate
					    , c.cart_quantity
					FROM cart c
					INNER JOIN goods g
					ON c.goods_code = g.goods_code
					    INNER JOIN goods_img gi
					    ON c.goods_code = gi.goods_code
					WHERE cart_code = ?
				""";
		Map<String, Object> m = new HashMap<>();
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cartCode);
			rs = stmt.executeQuery();
			if(rs.next()) {
				m.put("filename", rs.getString(1));
				m.put("goodsCode", rs.getInt(2));
				m.put("goodsName", rs.getString(3));
				m.put("goodsPrice", rs.getInt(4));
				m.put("pointRate", rs.getDouble(5));								
				m.put("cartQuantity", rs.getInt(6));				
			};
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		
		return m;
		
	}	
	// 장바구니 목록
	public List<Map<String, Object>> selectCartList(int customerCode) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;		
		ResultSet rs = null;
		String sql = """
					SELECT c.cart_code
						   , c.cart_quantity
						   , g.goods_name
						   , g.goods_price
						   , g.soldout
						   , g.goods_price * c.cart_quantity totalprice
					FROM cart c INNER JOIN goods g
					ON c.goods_code = g.goods_code
					WHERE customer_code = ?
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, customerCode);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				m.put("cartCode", rs.getInt("cart_code"));
				m.put("cartQuantity", rs.getInt("cart_quantity"));
				m.put("goodsName", rs.getString("goods_name"));
				m.put("goodsPrice", rs.getInt("goods_price"));
				m.put("soldout", rs.getString("soldout"));
				m.put("totalPrice", rs.getInt("totalprice"));				
				list.add(m);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	// 장바구니 추가
	public int insertCart(Cart c) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;				
		String sql = """
					INSERT INTO cart()
					VALUES (?,?,?,?,?,?)
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			
			
			
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
}
