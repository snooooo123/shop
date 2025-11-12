package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Cart;

public class CartDao {
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
