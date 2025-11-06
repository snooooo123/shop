package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dao.OrdersDao;

@WebServlet("/emp/orderList")
public class OrderListController extends HttpServlet {
	private OrdersDao ordersDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;
		if(request.getParameter("currentPage")!=null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage = 10;
		int lastPage = 0;
		int beginRow = (currentPage-1)*rowPerPage;
		
		this.ordersDao = new OrdersDao();
						
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			list = ordersDao.selectOrderList(beginRow, rowPerPage);
			int cnt = ordersDao.countOrderList();
			if(cnt/rowPerPage==0 || cnt%rowPerPage!=0) {
				lastPage = cnt/rowPerPage + 1; 
			} else {
				lastPage = cnt/rowPerPage;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		//System.out.println(list);
		
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("orderList", list);
		request.getRequestDispatcher("/WEB-INF/view/emp/ordersList.jsp").forward(request, response);
	}
}
