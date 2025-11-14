<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		:root {
        /* Color Palette */
        --primary-color: #3498db; /* Blue */
        --secondary-color: #2c3e50; /* Dark Blue/Heading */
        --light-bg: #fff;
        --off-white-bg: #f9f9f9;
        --border-color: #ddd;
        --hover-bg: #e8f4f8;
        --shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    	}
    	
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
	    
	    h2 {
	    /* 배경색 및 텍스트 색상 추가/변경 */
	    background-color: #e74c3c; /* 빨간색 배경 */
	    color: white; /* 흰색 글자색으로 변경하여 가독성 확보 */
	    font-size: 18px; /* 글자 크기 조정 */
	    font-weight: 600; 
	
	    /* 상하좌우 패딩 추가 */
	    padding: 10px 15px; 
	    
	    /* 기존 스타일 제거/수정 */
	    border-bottom: none; /* 기존 border-bottom 제거 */
	    margin-top: 30px;
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
	    
	   table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
        background-color: var(--light-bg);
	    }
	    
	    table th, table td {
	        padding: 12px 10px;
	        text-align: center;
	        border: 1px solid var(--border-color);
	        font-size: 14px;
	    }
	    
	    table th {
	        background-color: #ecf0f1; 
	        color: var(--secondary-color);
	        font-weight: 600;
	    }
	
	    /* Product List Table Specifics (Removes standard table borders for a cleaner look) */
	    .product-list-table {
	        border: none;
	        box-shadow: none;
	    }
	    .product-list-table td {
	        border: 1px solid #eee; /* Light border for cells */
	        width: 20%; /* 5 items per row */
	        padding: 15px;
	    }
	    .product-list-table tr:hover {
	        background-color: transparent; /* Disable row hover */
	    }
	    .product-list-table td:hover {
	        background-color: var(--hover-bg);
	        cursor: pointer;
	        transition: background-color 0.2s;
	    }
	
	    /* Product card layout within table cells */
	    .product-list-table td > div {
	        padding: 5px;
	    }
	    .product-list-table img {
	        display: block;
	        margin: 0 auto 10px auto;
	        width: 100px;
	        max-width: 100%;
	        height: auto;
	        border-radius: 3px;
	    }
	    .product-list-table a {
	        display: block;
	        font-size: 15px;
	        margin-bottom: 5px;
	    }
	    .product-list-table .price {
	        color: #e74c3c; /* Red color for price */
	        font-weight: 700;
	        font-size: 16px;
	    }
	    
	    /* Link Styling */
	   	a {
		    color: var(--primary-color);
		    text-decoration: none;
		    font-weight: 600;
		    transition: color 0.2s, text-decoration 0.2s;
		}
		
		a:hover {
		    color: #1a73e8;
		    text-decoration: underline;
		}
	
	    /* Pagination Styling */
	    /* Pagination Styling */
		.pagination { 
		   text-align: center;
		   margin-top: 30px;
		   margin-bottom: 20px;
		   font-size: 15px;
		}
		
		/* 페이지 링크 <a> 태그 스타일 */
		.pagination a {
		    color: #2c3e50;
		    text-decoration: none;
		    padding: 8px 14px;
		    font-weight: bold;
		    border: none;
		    border-radius: 4px;
		    
		    margin: 0 3px;
		    
		    display: inline-block;
		    transition: background-color 0.2s, color 0.2s;
		}
		
		/* 호버 시 배경색은 유지 */
		.pagination a:hover {
		    background-color: #e74c3c;
		    color: var(--light-bg);
		    text-decoration: none;
		}
		
		/* 현재 페이지 <span> 태그 스타일 */
		.pagination span.current-page {
		    padding: 8px 14px;
		    font-weight: bold;
		    color: var(--light-bg);
		    background-color: #e74c3c;
		    border-radius: 4px;
		    
			margin: 0 3px;
		    
		    display: inline-block;
		    border: none;
		}		
			    
	    hr {
	        border: 0;
	        height: 1px;
	        background: #f0f0f0;
	        margin: 40px 0;
	    }
    </style>
</head>
<body>
	<div>
	<h1>customerIndex</h1>
	<div class="header-container">
		<!-- customer menu -->
		<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
		
		<div class="customer-info">
			${loginCustomer.customerName}님 반갑습니다.
			(point : ${loginCustomer.point})
			<a href="${pageContext.request.contextPath}/out/logout">로그아웃</a>
		</div>
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
		<table class="product-list-table">
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
	<div class="pagination">
		<c:if test="${P.startPage>1}">
			<a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${P.startPage-1}">이전</a>
		</c:if>
		<span>
			<c:forEach var="i" begin="${P.startPage}" end="${P.endPage}" step="1">
				<c:if test="${i!=currentPage}">		
					<a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${i}">${i}</a>
				</c:if>
				<c:if test="${i==currentPage}">		
					<span class="current-page">${i}</span>
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