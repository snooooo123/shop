package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.NoticeDao;

@WebServlet("/emp/removeNotice")
public class RemoveNoticeController extends HttpServlet {
	private NoticeDao noticeDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//System.out.println(request.getParameter("noticeCode")); // form 에 내용이 없으면 안넘어온다 a 써서 넘기자
		
		int noticeCode = Integer.parseInt(request.getParameter("noticeCode"));
		
		
		noticeDao = new NoticeDao();
		int row = noticeDao.deleteNotice(noticeCode);
		if(row != 1) {
			request.getRequestDispatcher("/WEB-INF/view/emp/noticeOne.jsp").forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath()+"/emp/noticeList");
		}
		
	}

}
