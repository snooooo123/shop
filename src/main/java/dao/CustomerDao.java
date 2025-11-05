package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import dto.Customer;	

public class CustomerDao {
	
	// 직원에 의해 강제탈퇴
	public void deleteCustomerByEmp(Outid oi) {
		Connection conn = null;
		PreparedStatement psmtCustomer = null;
		PreparedStatement psmtOutid = null;
		String sqlCustomer="""
					delete from customer where customer_id = ?
				""";
		String sqlOutid = """
					insert into outid(id, memo, createdate)
					values(?,?,?)
				""";
		
	// JDBC Connection의 기본 Commit 설정값 auto commit = true : false 변경 후 transaction 적용
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false); // 개발자가 commit / rollback 직접 구현 필요
			sqlCustomer = conn.prepareStatement(sqlCustomer);
			int row = psmtCustomer.executeUpdate();
			if(row == 1) {
				psmtOutid = conn.prepareStatement(sqlOutid);
				psmtOutid.executeUpdate(); // outid 입력
			} else {
				throw
			}
			
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				psmtOutid.close(); psmtCustomer.close(); conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}				
	}
	
	// 직원 로그인시 전체 고개 리스트 확인
	public List<Customer> selectCustomerList(int beginRow, int rowPerPage) throws SQLException {
		return null;
	}
	
	
	public Customer selectCustomerByLogin(String customerId, String customerPw) throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select customer_code, customer_id, customer_pw, customer_name, customer_phone, point, createdate"
					+ " from gdj95.customer"
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
	
	public int insertCustomer(Customer cstm) throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		
		String sql = """
					insert into customer(customer_code, customer_id, customer_pw, customer_name,
					customer_phone, point, createdate)
					values(seq_customer.nextval, ?, ?, ?, ?, 0, sysdate)
				""";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, cstm.getCustomerId());
		stmt.setString(2, cstm.getCustomerPw());
		stmt.setString(3, cstm.getCustomerName());
		stmt.setString(4, cstm.getCustomerPhone());
		int row = stmt.executeUpdate();
		
		stmt.close(); conn.close();
		return row;
	}
}
