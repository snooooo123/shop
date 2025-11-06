package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.GoodsDao;
import dto.Goods;

@WebServlet("/emp/goodsList")
public class GoodsListController extends HttpServlet {
	private GoodsDao goodsDao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
		    currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage = 10;
		int lastPage = 0;		
		int beginRow = (currentPage-1)*rowPerPage;
		int cnt;
		List<Goods> list = new ArrayList<>();
		goodsDao = new GoodsDao();
		try {
			list = goodsDao.selectGoodsListByEmp(beginRow, rowPerPage);
			cnt = goodsDao.countGoodsList();
			lastPage = (cnt + rowPerPage - 1) / rowPerPage;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("goodsList", list);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		request.getRequestDispatcher("/WEB-INF/view/emp/goodsList.jsp").forward(request, response);
		
	}

}
