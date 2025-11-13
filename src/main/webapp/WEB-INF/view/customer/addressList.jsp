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
	 
	    body > div {
	        width: 100%;
	        max-width: 1200px;
    	}
	    
	    h1 {
	        color: #2c3e50;
	        border-left: 6px solid #ff3333;
	        padding-left: 10px;
	    }
    	.header-container {
		    display: flex; /* Flexbox 활성화 */
		    justify-content: space-between; /* 양쪽 끝으로 요소 분리 */
		    align-items: center; /* 수직 중앙 정렬 */
		    margin-bottom: 20px; /* 아래쪽 여백 추가 */
		    
		    background-color: #f0f8ff; 
		    border-radius: 5px;
		    border: 1px solid #e0f0ff;
		    padding: 10px; /* 내부 요소와 테두리 사이에 패딩 추가 */
		}
    	.customer-info {
	        width: 350px; /* customer-info 영역의 너비를 지정하여 공간 확보 */
	    	flex-shrink: 0; /* 공간이 부족해도 축소되지 않도록 설정 */
	    	
	        margin-bottom: 0px;
	        padding: 10px;
	  
	        display: flex;
	        justify-content: space-between;
	        align-items: center;
	        font-size: 15px;
    	}
    	a {
		    color: #3498db;
		    text-decoration: none;
		    font-weight: 600;
		    transition: color 0.2s, text-decoration 0.2s;
		}
		
		a:hover {
		    color: #1a73e8;
		    text-decoration: underline;
		}
   	</style>
</head>
<body>
	<div>
		<h1>addressList</h1>
		<div class="header-container">
			<!-- customer menu -->
			<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
			<div class="customer-info">
				${loginCustomer.customerName}님 반갑습니다.
				(point : ${loginCustomer.point})
				<a href="${pageContext.request.contextPath}/customer/customerlogout">로그아웃</a>
			</div>
		</div>
		<hr>
		<table border="1">
			<tr>
				<th>No.</th>
				<th>address</th>
				<th>삭제</th>				
			</tr>
			<c:forEach var="i" begin="1" end="${list.size()}">
				<tr>
					<td>${i}</td>
					<td>${list[i-1].address}</td>
					<td><a href="${pageContext.request.contextPath}/customer/removeAddress?customerCode=${customerCode}&addressCode=${list[i-1].addressCode}">삭제</a></td>
				</tr>			
			</c:forEach>
		</table>
		<div>
			<a href="${pageContext.request.contextPath}/customer/addAddress">[배송지추가]</a> <!-- 배송지 최대 5개: 6번째 입력시 가장 오래된 데이터 삭제 후 입력(트랜잭션)-->
		</div>
	</div>
</body>
</html>