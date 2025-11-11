package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

import dao.GoodsDao;

@WebServlet("/customer/GoodsOne")
public class CustomerGoodsOneController extends HttpServlet {
	private GoodsDao goodsDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		goodsDao = new GoodsDao();
		int goodsCode = 0;
		try {
			goodsCode = Integer.parseInt(request.getParameter("goodsCode"));
		} catch (Exception e) {
			System.out.println(goodsCode + "여기에요");
			e.printStackTrace();			
		}								
		
		Map<String, Object> m = goodsDao.selectGoodsOne(goodsCode);
		
		request.setAttribute("goods", m);
		request.getRequestDispatcher("/WEB-INF/view/customer/goodsOne.jsp").forward(request, response);
		
	}

}
