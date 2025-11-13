package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dao.AddressDao;
import dao.CartDao;
import dao.GoodsDao;
import dto.Address;
import dto.Customer;

@WebServlet("/customer/addOrders")
public class AddOrderServlet extends HttpServlet {
	GoodsDao goodsDao;
	CartDao cartDao;
	AddressDao addressDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//cartList action
		String[] cartCodeList = request.getParameterValues("cartCodeList");
		System.out.println("cartCodeList: " + cartCodeList);
		
		//goodsOne action
		String goodsCode = request.getParameter("goodsCode");
		String cartQuantity = request.getParameter("cartQuantity");
		System.out.println("goodsCode: " + goodsCode);
		System.out.println("cartQuantity: " + cartQuantity);
				
		List<Map<String, Object>> list = new ArrayList<>();
		
		
		// Map : 상품정보 + 이미지정보 + 수량
		if(goodsCode != null) { // goodsOne action
			// list.size() -> 1
			// goodsCode를 사용하여 조인
			goodsDao = new GoodsDao();
			Map<String, Object> m = goodsDao.selectGoodsOne(Integer.parseInt(goodsCode));  
			m.put("cartQuantity", cartQuantity);
			list.add(m);
		} else { // cartList action
			// list.size() -> 1 이상
			// cartCodeList -> goods 정보 -> 조인
			cartDao = new CartDao();			
			for(String cc : cartCodeList) {
				int cartCode = Integer.parseInt(cc);
				Map<String, Object> m = cartDao.selectCartListByKey(cartCode);
				list.add(m);
			
				// cartDao.deleteCart(cc); 주문목록으로 이동 후 cart 에서는 삭제
			}			
		}		
		
		int orderPrice = 0;
		for(Map m : list) {
			orderPrice += (Integer)(m.get("goodsPrice"));
		}
		
		request.setAttribute("list", list);
		request.setAttribute("orderPrice", orderPrice);
		
		HttpSession session = request.getSession(); 
		Customer loginCustomer = (Customer)(session.getAttribute("loginCustomer"));
		addressDao = new AddressDao();
		List<Address> addressList = addressDao.selectAddressLsit(loginCustomer.getCustomerCode());
		request.setAttribute("addressList", addressList);
		
		request.getRequestDispatcher("/WEB-INF/view/customer/addOrders.jsp").forward(request, response);
	}
	// addOrders.jsp action
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// insert orders
		// insert point_history : 포인트 사용 -> 차감 & 적립 / 미사용 -> 적립
	}
}
