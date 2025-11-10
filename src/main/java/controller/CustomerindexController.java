package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.GoodsDao;

@WebServlet("/customer/customerIndex")
public class CustomerindexController extends HttpServlet {
	private GoodsDao goodsDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;
		if(request.getParameter("currentPage")!=null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int rowPerPage = 20;
		int beginRow = (currentPage-1) * rowPerPage;
		
		goodsDao = new GoodsDao();
		request.setAttribute("goodsList", goodsDao.selectGoodsList(beginRow, rowPerPage));
		request.setAttribute("currentPage", currentPage);
		
		request.setAttribute("goodsList", goodsDao.selectGoodsList(beginRow, rowPerPage));
		
		int totalTd = 20;
		// 만약에 페이지(첫 or 막) 에 출력할 상품이 7개 -> totalTd = 10
		request.setAttribute("totalTd", totalTd);
		
		request.getRequestDispatcher("/WEB-INF/view/customer/customerIndex.jsp").forward(request, response);		
	}

}
