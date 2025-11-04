package ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import dao.EmpDao;

// id 중복체크
@WebServlet("/ajax/idCheck")
public class IdcheckEmp extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();

		// CustomerDao.selectMemberIdCheck()
				
		EmpDao empDao = new EmpDao();		
		Map<String, Object> m = new HashMap<>();
		
		try {
			boolean yn = empDao.idCheck(id);
			m.put("check", yn);		
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		Gson gson = new Gson();
		String jsonStr = gson.toJson(m);
		out.write(jsonStr); 
		out.flush(); 
		out.close(); 		
	}
}
