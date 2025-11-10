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
	<h1>customerIndex</h1>
	<!-- customer menu -->
	<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
	
	<div>
		${loginCustomer.customerName}님 반갑습니다.
		(point : ${loginCustomer.point})
		<a href="${pageContext.request.contextPath}/customer/customerlogout"></a>
	</div>
		
	<h2>베스트 상품목록</h2>
	<!-- 베스트 : 가장 많이 주문(주문완료)된 상품 5개 -->	
	<table border="1">
		<tr>
			<c:forEach var="b" items="${bestList}">					
				<td>
					<a href="${pageContext.request.contextPath}/customer/customerGoodsOne?goodsCode=${b.goodsCode}">	
						<div>
							<img src="${pageContext.request.contextPath}/upload/${b.filename}" style="width:100px">
						</div>
						<div>
							${b.goodsName}<br>
							${b.goodsPrice}&#8361;<br>		
							${state.last}														
						</div>
					</a>
				</td>		
			</c:forEach>
		</tr>
	</table>
	<hr>
	
	<h2>상품목록</h2>
	<!-- 베스트 : 가장 많이 주문(주문완료)된 상품 5개 -->
	<div>
		<table border="1" width="50%">
			<tr>
				<!-- c:foreach varStatus : index(0~), count(1~), first(t/f>, last(t/f> -->
				<c:forEach var="m" items="${goodsList}" varStatus="state">
						<td>
							<a href="${pageContext.request.contextPath}/customer/customerGoodsOne?goodsCode=${b.goodsCode}">
								<!-- image  -->
								<div>
									<img src="${pageContext.request.contextPath}/upload/${m.filename}" style="width:100px">
								</div>
								<!-- 이름, 가격 -->
								<div>
									${m.goodsName}<br>
									${m.goodsPrice}&#8361;<br>		
									${state.last}														
								</div>
							</a>
						</td>
						<c:if test="${state.last == false && state.count % 5 == 0 }">
							</tr><tr>
						</c:if>
				</c:forEach>
			</tr>
		</table>
	</div>
	<hr>
	
	<c:if test="${P.startPage>1}">
		<a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${P.startPage-1}">이전</a>
	</c:if>
	<span>
		<c:forEach var="i" begin="${P.startPage}" end="${P.endPage}" step="1">
			<c:if test="${i!=currentPage}">		
				<a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${i}">${i}</a>
			</c:if>
			<c:if test="${i==currentPage}">		
				${i}
			</c:if>
		</c:forEach>
	</span>
	<c:if test="${P.endPage!=P.lastPage}">
		<a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${P.endPage+1}">다음</a>
	</c:if>
	
</body>
</html>