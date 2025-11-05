package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dto.Outid;

@WebServlet("/emp/removeCustomer")
public class RemoveCustomerByEmpController extends HttpServlet {
	Outid oi = new Outid();
	CustomerDao customerDao = new CustomerDao();
	// 강제탈퇴 화면
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String customerId = request.getParameter("customerId");
		
		request.setAttribute("customerId", customerId);
		request.getRequestDispatcher("/WEB-INF/view/emp/removeCustomer.jsp").forward(request, response);
	}
	// 강제탈퇴 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String memo = request.getParameter("why");
		
		oi.setId(id);
		oi.setMemo(memo);
		
		customerDao.deleteCustomerByEmp(oi);
		
		response.sendRedirect(request.getContextPath()+"/emp/customerList");
	}

}
