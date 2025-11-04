package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import dao.EmpDao;

@WebServlet("/emp/modifyEmpActive")
public class EmpModifyActive extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int empCode = Integer.parseInt(request.getParameter("empCode"));
		
		int active = 1;
		if(request.getParameter("currentActive").equals("1")) {
			active = 0;
		}
						
		EmpDao empDao = new EmpDao();
		try {
			int r = empDao.activeChange(empCode, active);
			if(r == 0) {
				System.out.println("변경 실패");
			} else {
				System.out.println("변경 성공");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			response.sendRedirect(request.getContextPath()+"/emp/empList");
		}
	}
}
