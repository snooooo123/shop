package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import dao.EmpDao;
import dto.Emp;

@WebServlet("/emp/addEmp")
public class AddEmpController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String empId = request.getParameter("id");
		String empPw = request.getParameter("pw");
		String empName = request.getParameter("name");
		
		Emp emp = new Emp();
		emp.setEmpId(empId);
		emp.setEmpPw(empPw);
		emp.setEmpName(empName);
		
		EmpDao empDao = new EmpDao();
		try {
			int row = empDao.addEmp(emp);
			if(row==0) {
				System.out.println("emp추가 실패");
			} else {
				System.out.println("emp추가 성공");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}				
	}
}
