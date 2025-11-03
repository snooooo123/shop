package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import dao.CustomerDao;
import dao.EmpDao;
import dto.Customer;
import dto.Emp;


@WebServlet("/out/login")
public class LoginController extends HttpServlet {
	// form
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
		
	}
	// action
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String customerOrEmpSel = request.getParameter("customerOrEmpSel");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		try {
			if(customerOrEmpSel.equals("customer")) {

				CustomerDao cstmDao = new CustomerDao();
				Customer loginCustomer = cstmDao.selectCustomerByLogin(id, pw);
				
				if(loginCustomer != null) {
					HttpSession session = request.getSession();
					session.setAttribute("loginCustomer", loginCustomer);
					System.out.println("로그인 성공!");
					request.getRequestDispatcher("/WEB-INF/view/customer/customerIndex.jsp").forward(request, response);
				} else {
					System.out.println("로그인 실패!");
					request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
				}
			} else if(customerOrEmpSel.equals("emp")) {
				
				EmpDao empDao = new EmpDao();
				Emp loginEmp = empDao.selectEmpByLogin(id, pw);
				
				if(loginEmp != null) {
					HttpSession session = request.getSession();
					session.setAttribute("loginEmp", loginEmp);
					System.out.println("로그인 성공!");
					request.getRequestDispatcher("/WEB-INF/view/emp/empIndex.jsp").forward(request, response);
				} else {
					System.out.println("로그인 실패!");
					request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
				}		
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
