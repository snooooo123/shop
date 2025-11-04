package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dto.Customer;


@WebServlet("/customer/addCustomer")
public class AddMemberController extends HttpServlet {
	// 폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// addMember.jsp
		request.getRequestDispatcher("/WEB-INF/view/out/addMember.jsp").forward(request, response);
	}
	// 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		System.out.println(id);
		System.out.println(pw);
		System.out.println(name);
		System.out.println(phone);
		
		
		Customer cstm = new Customer();
		cstm.setCustomerId(id);
		cstm.setCustomerPw(pw);
		cstm.setCustomerName(name);
		cstm.setCustomerPhone(phone);

		CustomerDao cstmDao = new CustomerDao();
		int row = cstmDao.insertCustomer(cstm);
		if(row!=0) {
			System.out.println("가입성공");
		}
		
		response.sendRedirect(request.getContextPath()+"");
	}

}
