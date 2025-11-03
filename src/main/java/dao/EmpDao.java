package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Emp;

public class EmpDao {
	// 로그인
	public Emp selectEmpByLogin(String empId, String empPw) throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select emp_code, emp_id, emp_pw, emp_name, emp_active, createdate"
					+ " from emp"
					+ " where emp_id = ? and emp_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		rs = stmt.executeQuery();
		
		Emp emp = null;
		if(rs.next()) {
			emp = new Emp();
			emp.setEmpId(rs.getString(2));
			emp.setEmpPw(rs.getString(3));
			emp.setEmpName(rs.getString(4));
			emp.setActive(rs.getString(5));
			emp.setCreatedate(rs.getString(6));
		}
		
		rs.close(); stmt.close(); conn.close();
						
		return emp;
	}
}
