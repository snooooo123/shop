package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Customer;
import dto.Outid;	

public class CustomerDao {
/*
 *	직원에 의해 강제탈퇴
 */
	public void deleteCustomerByEmp(Outid oi) {
		Connection conn = null;
		PreparedStatement psmtCustomer = null;
		PreparedStatement psmtOutid = null;
		String sqlCustomer="""
					delete from customer where customer_id = ?
				""";
		String sqlOutid = """
					insert into outid(id, memo, createdate)
					values(?,?,sysdate)
				""";
		
	// JDBC Connection의 기본 Commit 설정값 auto commit = true : false 변경 후 transaction 적용
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false); // 개발자가 commit / rollback 직접 구현 필요
			psmtCustomer = conn.prepareStatement(sqlCustomer);
			psmtCustomer.setString(1, oi.getId());
			int row = psmtCustomer.executeUpdate(); // customer 삭제
			if(row == 1) {
				psmtOutid = conn.prepareStatement(sqlOutid);
				psmtOutid.setString(1,oi.getId());
				psmtOutid.setString(2,oi.getMemo());
				psmtOutid.executeUpdate(); // outid 입력
			} else {
				throw new SQLException();
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
/*
 *	직원 로그인시 전체 고개 리스트 확인
 */
	public List<Customer> selectCustomerList(int beginRow, int rowPerPage) throws SQLException {		
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select customer_id, customer_name, customer_phone, point
					from customer
					offset ? rows fetch next ? rows only
				""";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		List<Customer> list = new ArrayList<>();
		
		while(rs.next()) {		
			Customer customer = new Customer();
			customer.setCustomerId(rs.getString("customer_id"));
			customer.setCustomerName(rs.getString("customer_name"));
			customer.setCustomerPhone(rs.getString("customer_phone"));
			customer.setPoint(rs.getInt("point"));	
			list.add(customer);
		}
		
		rs.close(); stmt.close(); conn.close();
		return list;
	}
/*
 *	고객 count
 */
	public int countCustomerList() throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select count(*) from customer
				""";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		int cnt = 0;
		if(rs.next()) {
			cnt = rs.getInt("count(*)"); 
		}
		
		rs.close(); stmt.close(); conn.close();
		return cnt;
	}
/*
 *	고객 로그인
 */	
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
/*
 *	고객 회원가입	
 */
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
