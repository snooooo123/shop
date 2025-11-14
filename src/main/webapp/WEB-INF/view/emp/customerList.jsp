<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>shop</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
	/* ====== 고객관리 페이지 스타일 ====== */
	body {
	    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	    background-color: #fff;
	    color: #333;
	    margin: 0;
	    padding: 20px;
	    display: flex;
        justify-content: center; 
	}
	
	h1 {
	    color: #2c3e50;
	    border-left: 6px solid #3498db;
	    padding-left: 10px;
    	margin-bottom: 20px;
	}
	
	.wrap {
        width: 100%;
        max-width: 1015px;       
        border-radius: 8px;  
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
   	.emp-info {
        width: 350px; /* customer-info 영역의 너비를 지정하여 공간 확보 */
    	flex-shrink: 0; /* 공간이 부족해도 축소되지 않도록 설정 */
    	
        margin-bottom: 0px;
        padding: 10px;
  
        display: flex;
        gap: 30px;
        justify-content: flex-end;
        
        font-size: 15px;
   	}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 15px;
	    
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
	
	/* "강퇴" 링크는 빨간색 강조 */
	td a[href*="removeCustomer"] {
	    color: #e74c3c;
	}
	
	td a[href*="removeCustomer"]:hover {
	    color: #c0392b;
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
	<div class="wrap">
		<h1>고객관리</h1>
		<div class="header-container">	
			<!-- emp menu include -->
			<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>			
			<div class="emp-info">
				${loginEmp.empName}님 반갑습니다.
				<a href="${pageContext.request.contextPath}/out/logout">로그아웃</a>
			</div>
		</div>
		<table border=1>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>연락처</th>
				<th>포인트</th>
				<th>주문내역</th>
				<th>강퇴</th>
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
		<div class="pagination">
			<c:if test="${currentPage>1}">
				<a href="${pageContext.request.contextPath}/emp/customerList?currentPage=${currentPage-1}">이전</a>
			</c:if>
				<span class="current-page">${currentPage}</span>
			<c:if test="${currentPage<lastPage}">
				<a href="${pageContext.request.contextPath}/emp/customerList?currentPage=${currentPage+1}">다음</a>
			</c:if>
		</div>		
	</div>
</body>
</html>