package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dto.Emp;

@WebServlet("/emp/addNotice")
public class AddNoticeController extends HttpServlet {
// 폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/emp/addNotice.jsp").forward(request, response);
		//System.out.println(((Emp)(request.getSession().getAttribute("loginEmp"))).getEmpCode());
	}
// 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
