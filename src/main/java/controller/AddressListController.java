package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dao.AddressDao;
import dto.Address;
import dto.Customer;

@WebServlet("/customer/addressList")
public class AddressListController extends HttpServlet {
	AddressDao addressDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer customer = (Customer)(session.getAttribute("loginCustomer"));
		
		addressDao = new AddressDao();
		List<Address> list = addressDao.selectAddressList(customer.getCustomerCode());
		
		request.setAttribute("list", list);
		request.setAttribute("customerCode", customer.getCustomerCode());
		request.getRequestDispatcher("/WEB-INF/view/customer/addressList.jsp").forward(request, response);			
	}
}
