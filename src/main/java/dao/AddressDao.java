package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Address;

public class AddressDao {
	public int deleteAddressByCustomer(int customerCode) {
		Connection conn = null;
		PreparedStatement stmt = null;		
		String sql = """
					DELETE 
				""";
		
		int row=0;
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, customerCode);
			
			
							
			
			
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
		
		return 0;
	}
	public List<Address> selectAddressList(int customerCode) {
		List<Address> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					Select address_code, address
					FROM address WHERE customer_code = ?
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, customerCode);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Address address = new Address();
				address.setAddress(rs.getString(2));
				address.setAddressCode(rs.getInt(1));
				list.add(address);				
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

	public void insertAddress(Address address) {
		Connection conn = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		ResultSet rs1 = null;
		String sql1="""
					select count(*) from address where customer_code=?
				""";
		String sql2="""
					delete from address
					where address_code = (select min(address_code) from address
					where customer_code = ?)
				""";
		String sql3="""
					insert into address(address_code, customer_code, address, createdate)
					values(seq_address.nextval,?,?,sysdate)
				""";
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false);
			stmt1 = conn.prepareStatement(sql1);
			stmt1.setInt(1, address.getCustomerCode());
			rs1 = stmt1.executeQuery();
			
			rs1.next();
			int cnt = rs1.getInt(1);
			if(cnt>4) { // 5개면 가장오래된 주소 삭제 후 입력
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setInt(1, address.getCustomerCode());
				stmt2.executeUpdate();
			}
			
			stmt3 = conn.prepareStatement(sql3);
			stmt3.setInt(1, address.getCustomerCode());
			stmt3.setString(2, address.getAddress());
			int row = stmt3.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { // finally 자원해지 null 유무 확인 후 해지
			try {
				if(stmt1 != null) {stmt1.close();}
				if(stmt1 != null) {stmt1.close();}
				if(stmt2 != null) {stmt2.close();}
				if(stmt3 != null) {stmt3.close();}
				if(conn != null) {conn.close();}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
	}
}
