package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.CustomerDao;
import dto.Customer;

@WebServlet("/emp/customerList")
public class CustomerListController extends HttpServlet {
	private CustomerDao customerDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.customerDao = new CustomerDao();
		int currentPage = 1;
		if(request.getParameter("currentPage")!=null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}		
		int rowPerPage = 10;
		int beginRow = (currentPage-1)*rowPerPage;
		int lastPage = 0;
		int cnt; 
		List<Customer> customerList = null; 

		try {
			customerList = customerDao.selectCustomerList(beginRow, rowPerPage);
			cnt = customerDao.countCustomerList();
			if(cnt/rowPerPage == 0 || cnt%rowPerPage != 0 ) {
				lastPage = cnt/rowPerPage + 1;
			} else {
				lastPage = cnt/rowPerPage;
			}		
			//System.out.println(cnt);
			//System.out.println(lastPage);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// System.out.println(customerList); // 디버깅
		
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("customerList", customerList);
		
		request.getRequestDispatcher("/WEB-INF/view/emp/customerList.jsp").forward(request, response);
	}
}
