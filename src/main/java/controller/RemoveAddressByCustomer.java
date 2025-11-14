package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.AddressDao;

@WebServlet("/customer/removeAddress")
public class RemoveAddressByCustomer extends HttpServlet {
	AddressDao addressDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int customerCode = Integer.parseInt(request.getParameter("customerCode"));
		int addressCode = Integer.parseInt(request.getParameter("addressCode"));
		
//		System.out.println(customerCode);
//		System.out.println(addressCode);
		
		addressDao = new AddressDao();
		int row = addressDao.deleteAddressByCustomer(customerCode, addressCode);
		
		if(row == 0) {
			System.out.println("배송지 삭제 실패");			
		}
		
		response.sendRedirect(request.getContextPath()+"/customer/addressList");
	}
}
