package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Emp;

public class EmpDao {
	// 로그인
	public Emp selectEmpByLogin(String empId, String empPw) throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select emp_code, emp_id, emp_pw, emp_name, active, createdate"
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
			emp.setActive(rs.getInt(5));
			emp.setCreatedate(rs.getString(6));
		}
		
		rs.close(); stmt.close(); conn.close();
						
		return emp;
	}

	// 사원목록 몇 줄씩
	public List<Emp> selectEmplistByPage(int beginRow, int rowPerPage) throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select emp_code, emp_id, emp_name, active, createdate
					from emp
					order by emp_code
					offset ? rows fetch next ? rows only
					""";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		List<Emp> list = new ArrayList<>();
		while(rs.next()) {
			Emp e = new Emp();
			e.setEmpCode(rs.getInt("emp_code"));
			e.setEmpId(rs.getString("emp_id"));
			e.setEmpName(rs.getString("emp_name"));
			e.setActive(rs.getInt("active"));
			e.setCreatedate(rs.getString("createdate"));
			list.add(e);
		}
		
		// offset 10 rows fetch next 10 rows only : 10행 다음부터 10개의 행을 가져옴
		
		rs.close(); stmt.close(); conn.close();
		return list;
	}
	// emp count
	public int countEmpList() throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from emp";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		int r = 0;
		if(rs.next()) {
			r = rs.getInt(1);
		}
		rs.close(); stmt.close(); conn.close();
		return r;
	}
	// emp active 활성/비활성
	public int activeChange(int empCode, int active) throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "update emp set active = ? where emp_code=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, active);
		stmt.setInt(2, empCode);
		row = stmt.executeUpdate();
		
		stmt.close(); conn.close();	
		return row;
	}
	// 사원 추가
	public int addEmp(Emp e) throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		String sql = """
					insert into emp(emp_code, emp_id, emp_pw, emp_name, active, createdate)
					values(seq_emp.nextval, ?, ?, ?, 1, sysdate);
				""";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, e.getEmpId());
		stmt.setString(2, e.getEmpPw());
		stmt.setString(3, e.getEmpName());
		int row = stmt.executeUpdate();
		
		stmt.close(); conn.close();
		return row;
	}
	// 아이디 중복 확인
	public boolean idCheck(String id) throws SQLException {
		Connection conn = DBConnection.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select t.id
					from 
						(select customer_id id from customer
						union all
						select emp_id id from emp
						union all
						select id from outid) t
					where t.id=?
				""";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		rs = stmt.executeQuery();	
		
		//System.out.println(id); // 디버깅
		
		boolean yn = true;
		if(rs.next()) {
			yn = false;
		}
		rs.close(); stmt.close(); conn.close();
		return yn;
	}
}
