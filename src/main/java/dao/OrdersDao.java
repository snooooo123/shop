package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrdersDao {
	public List<Map<String, Object>> selectOrderList(int beginRow, int rowPerPage) throws Exception {
		List<Map<String,Object>> list = new ArrayList<>();
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """										
			select 
				o.order_code, o.goods_code, o.customer_code, o.address_code, o.order_quantity
		        , o.order_state, o.createdate, o.order_price
		        , g.goods_name, g.goods_price
		        , c.customer_name, c.customer_phone
		        , a.address
			from orders o inner join goods g
			on o.goods_code = g.goods_code
			    inner join customer c
			    on o.customer_code = c.customer_code
			        inner join address a
			        on o.address_code = a.address_code
			order by o.order_code desc
			offset ? rows fetch next ? rows only
		""";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Map<String, Object> m = new HashMap<>();
			m.put("orderCode", rs.getInt("order_code"));
			m.put("goodsCode", rs.getInt("goods_code"));
			m.put("customerCode", rs.getInt("customer_code"));
			m.put("addressCode", rs.getInt("address_code"));
			m.put("orderQuantity", rs.getInt("order_quantity"));
			m.put("orderState", rs.getString("order_state"));
			m.put("createdate", rs.getString("createdate"));
			m.put("orderPrice", rs.getInt("order_price"));;
			m.put("goodsName", rs.getString("goods_name"));
			m.put("goodsPrice", rs.getInt("goods_price"));
			m.put("customerName", rs.getString("customer_name"));
			m.put("customerPhone", rs.getString("customer_phone"));
			m.put("address", rs.getString("address"));
			list.add(m);
		}
		rs.close(); stmt.close(); conn.close();			
		return list;
	}
	
	public int countOrderList() throws SQLException {
		int cnt=0;
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select count(*) from orders
				""";		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("count(*)");
		}
		rs.close(); stmt.close(); conn.close();
		return cnt;
	}
}
