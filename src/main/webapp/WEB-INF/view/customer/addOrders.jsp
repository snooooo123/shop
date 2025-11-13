<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>addOrders</h1>
	<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
	<hr>
	
	<div>
		<form action="">
			<table border="1">
				<tr>
					<th></th>
					<th>goodsName</th>
					<th>goodsPrice</th>
					<th>pointRate</th>	
					<th>cartQuantity</th>
				</tr>
				<c:forEach var="m" items="${list}">
					<tr>
						<td><img src="${pageContext.request.contextPath}/upload/${m.filename}" style="width:200px; height:auto"></td>
						<td>${m.goodsName}</td>
						<td>${m.goodsPrice}</td>
						<td>${m.pointRate}</td>
						<td>${m.cartQuantity}</td>											
					</tr>
				</c:forEach>
			</table>
							
			<div>
				<!-- 배송지 -->
				<input type="text" name="addressCode">
			</div>
			<div>
				<!-- 결제금액, 포인트 사용 -->
				<div>
					포인트 사용:
					<input type="number" name="usePoint" value="0">
					(myPoint : ${loginCustomer.point})
					<button type="button">포인트사용</button>
				</div>
				
				<div>
					결제금액 : 
					<input type="number" name="orderPrice" value="${orderPrice}" readonly>
				</div>
			</div>
			<div>
				<button type="submit">결제하기(주문완료)</button>
				<!-- addOrders, updateCustomer(-point), insertPointHistory(+/-) -->
			</div>
		</form>
		<hr>
		
		
	
		<div>
			<button type="button" id="addressBtn">배송지 선택</button>
			<select id="addressList" size="5">							
				<c:forEach var="addr" items="${addressList}">
					<option value="${addr.addressCode}">${addr.address}</option>
				</c:forEach>
			</select>
		</div>
	</div>
</body>
</html>