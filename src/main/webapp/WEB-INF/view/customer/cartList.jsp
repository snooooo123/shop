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
	table {
		    width: 100%;
		    border-collapse: collapse;
		    margin-top: 10px;
		    background-color: #ffffff;
		    border-radius: 8px;
		    overflow: hidden;
		    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
		    font-size: 15px;
	}
	
	table th {
	    background-color: #3498db;
	    color: white;
	    padding: 12px;
	    text-align: center;
	    font-weight: 600;
	}
	
	table td {
	    padding: 10px;
	    border-bottom: 1px solid #eaeaea;
	    text-align: center;
	}
	
	/* 홀수, 짝수 줄 색상 */
	table tr:nth-child(even) {
	    background-color: #f8faff;
	}
	
	/* hover 시 강조 */
	table tr:hover {
	    background-color: #e7f2ff;
	    transition: 0.2s;
	}
	button[type="button"] {
    background-color: #e74c3c;   /* 빨간색 배경 */
    color: white;                /* 글자 색상 */
    border: none;                /* 테두리 제거 */
    padding: 12px 20px;          /* 여백 */
    font-size: 16px;             /* 글자 크기 */
    font-weight: 600;            /* 글자 두께 */
    border-radius: 6px;          /* 둥근 모서리 */
    cursor: pointer;             /* 클릭 가능한 손가락 커서 */
    margin-top: 20px;            /* 위쪽 여백 */
    box-shadow: 0 3px 6px rgba(0,0,0,0.15); /* 기본 그림자 */
    transition: background-color 0.2s, box-shadow 0.2s;
	}
	
	button[type="button"]:hover {
	    background-color: #c0392b;   /* hover 시 어두운 빨강 */
	    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
	}
</style>
</head>
<body>
	<div>
		<h1>cartList</h1>
		<div class="header-container">
			<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
			<hr>
			<div class="customer-info">
					${loginCustomer.customerName}님 반갑습니다.
					(point : ${loginCustomer.point})
					<a href="${pageContext.request.contextPath}/customer/customerlogout">로그아웃</a>
			</div>
		</div>
		<form action="${pageContext.request.contextPath}/customer/addOrders">
		
			<table border="1">
				<tr>
					<th>선택</th>
					<th>goodsName</th>
					<th>goodsPrice</th>
					<th>cartQuantity</th>
					<th>totalPrice</th>						
				</tr>	
				<c:forEach var="m" items="${list}">
					<tr>
						<td>
							<c:if test="${m.soldout == 'soldout'}">
								soldout
							</c:if>
							<c:if test="${m.soldout != 'soldout'}">
								<input type="checkbox" name="cartCodeList" value="${m.cartCode}">
							</c:if>
						</td>
						<td>${m.goodsName}</td>
						<td>${m.goodsPrice}</td>
						<td>${m.cartQuantity}</td>
						<td>${m.totalPrice}</td>
					</tr>					
				</c:forEach>
			</table>
			<button type="button" id="btn">주문하기</button>
			
		</form>
	</div>
</body>
<script>
	$('#btn').click(function() {
		
		if($('input[name="cartCodeList"]:checked').length==0) {
			alert("상품을 선택해 주세요")
			return;
		}
		
		$('form').submit();
	})
</script>
</html>