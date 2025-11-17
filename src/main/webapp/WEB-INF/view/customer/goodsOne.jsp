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
		}
		
		h1 {
		    color: #2c3e50;
		    border-left: 6px solid #ff3333;
		    padding-left: 10px;
		}
		
		.wrap {
		    max-width: 1000px;
		    margin: 0 auto;
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
		
		.tableImg {
	    	background-color: #fff;
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
	<div class="wrap">
		<h1>goodsOne</h1>
		<!-- customer menu -->
		<div class="header-container">
			<!-- customer menu -->
			<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
			<div class="customer-info">
				${loginCustomer.customerName}님 반갑습니다.
				(point : ${loginCustomer.point})
				<a href="${pageContext.request.contextPath}/out/logout">로그아웃</a>
			</div>
		</div>

		<form id="myForm">
			<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
			<input type="hidden" name="goodsCode" value="${goods.goodsCode}">
			<table border="1">		
				<tr>
					<th colspan="2" class="tableImg">
						<img src="${pageContext.request.contextPath}/upload/${goods.filename}" style="width:500px">					
					</th>
				</tr>				
				<tr>
					<th>이름</th>
					<td>${goods.goodsName}</td>
				</tr>
				<tr>
					<th>가격</th>
					<td>${goods.goodsPrice}</td>
				</tr>
				<tr>
					<th>적립률</th>
					<td>${goods.pointRate}</td>
				</tr>
				<tr>
					<th>soldout</th>
					<td>${goods.soldout}</td>
				</tr>
				<tr>
					<th>수량</th>
					<td>
						<select name="cartQuantity">
							<c:forEach var="i" begin="1" end="10">
								<option value="${i}">${i}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>
			<button id="cartBtn" type="button">장바구니</button> <!-- insert cart -->
			<button id="orderBtn" type="button">바로주문</button> <!-- 결제화면 controller - insert order -->
		</form>
	</div>
</body>
	<script>
		
		$('#cartBtn').click(function(){
			$('#myForm').attr('method', 'post');
			$('#myForm').attr('action', $('#contextPath').val()+'/customer/addCart');
			// alert('cartBtn:' + $('#myForm').attr('method') + ',' + $('#myForm').attr('action')); // cart action 요청
			$('#myForm').submit();
		})
		
		$('#orderBtn').click(function(){
			$('#myForm').attr('method', 'get');
			$('#myForm').attr('action', $('#contextPath').val()+'/customer/insertOrders');
			//alert('orderBtn:' + $('#myForm').action); // cart 화면 요청
			$('#myForm').submit();
		})
		
	</script>
</html>