package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.OutidDao;
import dto.Outid;

@WebServlet("/emp/outidList")
public class OutidListController extends HttpServlet {
	OutidDao outidDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		outidDao = new OutidDao();
		
		
		int currentPage = 1;
		int rowPerPage = 20;
		if(request.getParameter("currentPage")!=null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int startRow = (currentPage-1)*rowPerPage+1;
		
		List<Outid> list = outidDao.selectOutidList(startRow);
		int total = outidDao.selectOutidCount();
		//System.out.println(total);				
		int lastPage = (total + rowPerPage -1)/rowPerPage;
		int beginPage = ((currentPage -1)/10)*10 + 1;
		int endPage = ((currentPage -1)/10)*10 + 10;
		if(endPage>lastPage) endPage=lastPage;
		
		
		request.setAttribute("list", list);
		//System.out.println(list);		
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("beginPage", beginPage);
		request.setAttribute("endPage", endPage);
		
		request.getRequestDispatcher("/WEB-INF/view/emp/outidList.jsp").forward(request, response);
	}
}
