package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Customer;

public class CustomerDao {
	public Customer selectCustomerByLogin(String customerId, String customerPw) throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select customer_code, customer_id, customer_pw, customer_name, customer_phone, point, createdate"
					+ " from customer"
					+ " where customer_id = ? and customer_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setString(2, customerPw);
		rs = stmt.executeQuery();
		
		Customer cstm = null;
		if(rs.next()) {
			cstm = new Customer();
			cstm.setCustomerId(rs.getString(2));
			cstm.setCustomerPw(rs.getString(3));
			cstm.setCustomerName(rs.getString(4));
			cstm.setCustomerPhone(rs.getString(5));
			cstm.setPoint(rs.getInt(6));
			cstm.setCreatedate(rs.getString(7));
		}
		
		rs.close(); stmt.close(); conn.close();
		
		return cstm;
	}
}
