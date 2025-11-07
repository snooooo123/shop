package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import dao.NoticeDao;
import dto.Notice;


@WebServlet("/emp/noticeList")
public class NoticeListController extends HttpServlet {
	private NoticeDao noticeDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;
		if(request.getParameter("currentPage")!=null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));			
		}
		int rowPerPage = 10;
		int beginRow = (currentPage-1) * rowPerPage;
				
		noticeDao = new NoticeDao(); // DI(객체의존성 주입)
		List<Map<String, Object>> list = noticeDao.selectNoticeList(beginRow, rowPerPage);
		int count = noticeDao.selectCount();
		int lastPage = count + rowPerPage - 1 / rowPerPage;
		
		// 페이징
		/*
			CP		SP		EP
		  	1~10	1		10
		  	2		1		10
		  	11~20	11		20
		 */
		int startPage = ((currentPage-1)/10)*10 + 1;
		int endPage = ((currentPage-1)/10)*10 + 10;;
		if(lastPage < endPage) {
			endPage = lastPage;
		}
		
		
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);		
		
		request.setAttribute("list", list);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		
		request.getRequestDispatcher("/WEB-INF/view/emp/noticeList.jsp").forward(request, response);
	}
}
