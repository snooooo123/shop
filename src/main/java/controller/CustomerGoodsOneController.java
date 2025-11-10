package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

import dao.GoodsDao;

@WebServlet("/customer/customerGoodsOne")
public class CustomerGoodsOneController extends HttpServlet {
	private GoodsDao goodsDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		int goodsCode = Integer.parseInt(request.getParameter("goodsCode"));		
		
		System.out.println(goodsCode);
		
		Map<String, Object> m = goodsDao.goodsOne(goodsCode);
		
		request.setAttribute("goods", m);
		request.getRequestDispatcher("/WEB-INF/view/customer/goodsOne.jsp").forward(request, response);
		
	}

}
