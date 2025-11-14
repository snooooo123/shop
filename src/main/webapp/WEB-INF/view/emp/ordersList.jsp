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
	    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	    background-color: #fff;
	    color: #333;
	    margin: 0;
	    padding: 20px;
	}
	
	h1 {
	    color: #2c3e50;
	    border-left: 6px solid #3498db;
	    padding-left: 10px;
	}
	
	div {
	    max-width: 1000px;
	    margin: 0 auto;
	}
	
	hr {
	    border: 0;
	    height: 1px;
	    background: #ccc;
	    margin: 20px 0;
	}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 15px;
	    background-color: #fff;
	    box-shadow: 0 0 5px rgba(0,0,0,0.1);
	    table-layout: fixed;
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
        white-space: normal; /* 줄바꿈 허용 */
	    word-wrap: break-word; /* 긴 단어 줄바꿈 */
	    word-break: break-word; /* 줄바꿈 보조 */
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
	<h1>주문관리</h1>
	<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
	<hr>	
	<table border="1">
	  <colgroup>
	    <col style="width: 5%;">  
	    <col style="width: 10%;"> 
	    <col style="width: 10%;"> 
	    <col style="width: 10%;"> 
	    <col style="width: 20%;">  
	    <col style="width: 12%;"> 
	    <col style="width: 8%;"> 
	    <col style="width: 10%;"> 
	  </colgroup>
		<tr>
			<th>orderCode</th>
			<th>goods</th>
			<th>Price</th>
			<th>customer</th>			
			<th>address</th>
			<th>customerPhone</th>
			<th>orderState</th>
			<th>createdate</th>
		</tr>
		<c:forEach var="o" items="${orderList}">
			<tr>
				<td>${o.orderCode}</td>
				<td>
					${o.goodsCode}. ${o.goodsName}
				</td>
				<td>
					${o.goodsPrice} X ${o.orderQuantity}<br>
					= ${o.orderPrice}
				</td>				
				<td>
					${o.customerCode}#${o.customerName}					
				</td>
				<td>${o.address}</td>
				<td>${o.customerPhone}</td>
				<td>${o.orderState}</td>
				<td>${o.createdate}</td>						
			</tr>
		</c:forEach>				
	</table>
</div>
	<div class="pagination">
		<c:if test="${currentPage>1}">
			<a href="${pageContext.request.contextPath}/emp/orderList?currentPage=${currentPage-1}">이전</a>
		</c:if>
			<span class="current-page">${currentPage}</span>
		<c:if test="${currentPage<lastPage}">
			<a href="${pageContext.request.contextPath}/emp/orderList?currentPage=${currentPage+1}">다음</a>
		</c:if>
	</div>		
		
</body>
</html>