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
		    max-width: 1000px;			    		    	   
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
		    padding: 10px 15px;
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
	    .addbtn {
	        display: flex;
	        justify-content: flex-end; 
	        align-items: center;
	        margin-bottom: 15px;
	        padding-top: 10px;
	    }
	
	    .addbtn a {
	        color: #fff;
	        background-color: #007bff; 
	        padding: 8px 15px;
	        text-decoration: none;
	        border-radius: 5px;
	        font-size: 14px;
	        transition: background-color 0.3s;
	    }
	    .addbtn a:hover {
	        background-color: #1a73e8;
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
		<h1>상품관리</h1>
		<div class="header-container">	
			<!-- emp menu include -->
			<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
			<hr>
			<div class="emp-info">
				${loginEmp.empName}님 반갑습니다.
				<a href="${pageContext.request.contextPath}/out/logout">로그아웃</a>
			</div>
		</div>
		<hr>
		
		<table border="1">
			<tr>
				<th>goodsCode</th>
				<th>goodsName</th>
				<th>goodsPrice</th>
				<th>pointRate</th>
				<th>empCode</th>
				<th>createDate</th>
				<th>soldout</th>
			</tr>
			<c:forEach var="g" items="${goodsList}">
				<tr>
					<td>${g.goodsCode}</td>
					<td>${g.goodsName}</td>
					<td>${g.goodsPrice}</td>
					<td>${g.pointRate}</td>
					<td>${g.empCode}</td>
					<td>${g.createdate}</td>
					<td>${g.soldout}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="addbtn">
			<a href="${pageContext.request.contextPath}/emp/addGoods">상품추가</a>
		</div>			
		<div class="pagination">
			<c:if test="${currentPage>1}">
				<a href="${pageContext.request.contextPath}/emp/goodsList?currentPage=${currentPage-1}">이전</a>
			</c:if>
				<span class="current-page">${currentPage}</span>
			<c:if test="${currentPage<lastPage}">
				<a href="${pageContext.request.contextPath}/emp/goodsList?currentPage=${currentPage+1}">다음</a>
			</c:if>
		</div>
	</div>			
</body>
</html>