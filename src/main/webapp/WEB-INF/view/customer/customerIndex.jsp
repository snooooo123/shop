<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
	    body {
	        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	        background-color: #fff; 
	        color: #333;
	        margin: 0;
	        padding: 0px;
	        display: flex;
	        justify-content: center; 
	    }
	    
	    h1 {
	        color: #2c3e50;
	        border-left: 6px solid #3498db;
	        padding-left: 10px;
	    }
	    
	    table {
		    width: 100%;
		    border-collapse: collapse;
		    margin-top: 15px;
		    background-color: #fff;
		    box-shadow: 0 0 5px rgba(0,0,0,0.1);
		}
		
		table tr:nth-child(odd) {
		    background-color: #f9f9f9;	    
		    text-align: center;
		}
		
		table th, table td {
		    padding: 10px;
		    text-align: center;
		    border: 1px solid #ddd;
		    font-size: 14px;
		}
		table th {
	        background-color: #ecf0f1; 
	        color: #34495e;
	        font-weight: bold;
	    }
		
		table tr:hover {
		    background-color: #e8f4f8;
		}
	
	   	a {
		    color: #3498db;
		    text-decoration: none;
		    font-weight: 600;
		}
		
		a:hover {
		    color: #1a73e8;
		    text-decoration: underline;
		}
	    .pagination {
	       text-align: center;
	       margin-top: 20px;
	       font-size: 15px;
	       color: #777;
	    }
	    
	    .pagination a {
	        color: #3498db;
	        text-decoration: none;
	        padding: 5px 10px;
	        font-weight: bold;
	        border: 1px solid #3498db;
	        border-radius: 4px;
	        margin: 0 5px;
	    }
	    .pagination a:hover {
	        background-color: #3498db;
	        color: #fff;
	    }
	    .pagination span.current-page {
	        padding: 5px 10px;
	        font-weight: bold;
	        color: #333;
	    }
    </style>
</head>
<body>
	<div>
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
						
						<div>
							<img src="${pageContext.request.contextPath}/upload/${b.filename}" style="width:100px">
						</div>
						<div>
							<a href="${pageContext.request.contextPath}/customer/GoodsOne?goodsCode=${b.goodsCode}">
								${b.goodsName}<br>
							</a>
							${b.goodsPrice}&#8361;<br>															
						</div>
					
				</td>		
			</c:forEach>
		</tr>
	</table>
	<hr>
	
	<h2>상품목록</h2>	
	<div>
		<table border="1" width="50%">
			<tr>
				<!-- c:foreach varStatus : index(0~), count(1~), first(t/f>, last(t/f> -->
				<c:forEach var="m" items="${goodsList}" varStatus="state">
						<td>
							
								<!-- image  -->
								<div>
									<img src="${pageContext.request.contextPath}/upload/${m.filename}" style="width:100px">
								</div>
								<!-- 이름, 가격 -->
								<div>
									<a href="${pageContext.request.contextPath}/customer/GoodsOne?goodsCode=${m.goodsCode}">
										${m.goodsName}<br>
									</a>
										${m.goodsPrice}&#8361;<br>		
											
								</div>
							
						</td>
						<c:if test="${state.last == false && state.count % 5 == 0 }">
							</tr><tr>
						</c:if>
				</c:forEach>
			</tr>
		</table>
	
	</div>
	<hr>
	<div class="pegination">
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
	</div>
	</div>
</body>
</html>