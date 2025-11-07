package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.NoticeDao;
import dto.Emp;
import dto.Notice;

@WebServlet("/emp/addNotice")
public class AddNoticeController extends HttpServlet {
	private NoticeDao noticeDao; 		
// 폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/emp/addNotice.jsp").forward(request, response);
		//System.out.println(((Emp)(request.getSession().getAttribute("loginEmp"))).getEmpCode());
	}
// 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		int empCode = Integer.parseInt(request.getParameter("empCode"));
		String noticeTitle = request.getParameter("noticeTitle");
		String noticeContent = request.getParameter("noticeContent");
		
		Notice n = new Notice();
		n.setEmpCode(empCode);
		n.setNoticeTitle(noticeTitle);
		n.setNoticeContent(noticeContent);
		
		noticeDao = new NoticeDao();
		int row = noticeDao.insertNotice(n);
		if(row != 1) {
			System.out.println("AddNoticeController 문제 발생");
			request.getRequestDispatcher("/WEB-INF/view/emp/addNotice.jsp").forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath()+"/emp/noticeList");
		}
	}

}
