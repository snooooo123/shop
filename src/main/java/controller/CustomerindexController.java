package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

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
		
		int best=1, to=5;
		
		goodsDao = new GoodsDao();
		request.setAttribute("bestList", goodsDao.selectBestGoodsList(best, to));
		request.setAttribute("goodsList", goodsDao.selectGoodsList(beginRow, rowPerPage));
		request.setAttribute("currentPage", currentPage);
		
		//System.out.println(goodsDao.selectGoodsList(beginRow, rowPerPage));
		
		int totalTd = 20;
		// 만약에 페이지(첫 or 막) 에 출력할 상품이 7개 -> totalTd = 10
		int startPage=1, endPage=1, goodsTotal=0, lastPage=0;
		
		Map<String, Object> m = new HashMap<>();
		try {
			goodsTotal = goodsDao.countGoodsList();
			lastPage = (goodsTotal+totalTd-1)/totalTd;
			startPage = ((currentPage-1)/10)*10+1;
			endPage = startPage+9;
			
			if(endPage>lastPage) {
				endPage = lastPage;
			}			
			
			m.put("goodsTotal", goodsTotal);
			m.put("lastPage", lastPage);
			m.put("startPage", startPage);
			m.put("endPage", endPage);
			

			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		
		

		
		
		request.setAttribute("P", m);
		request.setAttribute("totalTd", totalTd);
		
		request.getRequestDispatcher("/WEB-INF/view/customer/customerIndex.jsp").forward(request, response);		
	}

}
