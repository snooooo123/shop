package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import dao.NoticeDao;

@WebServlet("/emp/modifyNotice")
public class ModifyNoticeController extends HttpServlet {
	private NoticeDao noticeDao;
	// 폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int noticeCode = Integer.parseInt(request.getParameter("noticeCode"));
		
		Map<String, Object> m = new HashMap<>();
		noticeDao = new NoticeDao();
		m = noticeDao.selectNoticeOne(noticeCode);
		
		request.setAttribute("notice", m);
		request.getRequestDispatcher("/WEB-INF/view/emp/modifyNotice.jsp").forward(request, response);
	}
	// 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

	}

}
