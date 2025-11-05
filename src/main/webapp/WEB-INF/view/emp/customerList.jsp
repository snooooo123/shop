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
	<div>
		<h1>고객관리</h1>
			<!-- emp menu include -->
			<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
			<hr>
		<table border=1>
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>연락처</td>
				<td>포인트</td>
				<td>주문내역</td>
				<td>강퇴</td>
			</tr>
			<c:forEach var="c" items="${customerList}">
				<tr>
					<td>${c.customerId}</td>
					<td>${c.customerName}</td>
					<td>${c.customerPhone}</td>
					<td>${c.point}</td>
					<td><a href="">주문내역</a></td>
					<td><a href="${pageContext.request.contextPath}/emp/removeCustomer?customerId=${c.customerId}">강퇴</a></td>
				</tr>
			</c:forEach>
		</table>
<!-- 		<div>${customerList}</div>  -->
		<div>
			<c:if test="${currentPage>1}">
				<a href="${pageContextPath.request.contextPath}/emp/customerList?currentPage=${currentPage-1}">이전</a>
			</c:if>
			${currentPage}
			<c:if test="${currentPage<lastPage}">
				<a href="${pageContextPath.request.contextPath}/emp/customerList?currentPage=${currentPage+1}">다음</a>
			</c:if>
		</div>		
	</div>
</body>
</html>