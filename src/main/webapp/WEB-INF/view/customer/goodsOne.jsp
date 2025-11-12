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
    </style>
</head>
<body>
	<div>
		<h1>goodsOne</h1>
		<!-- customer menu -->
		<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
		<hr>

		<form id="myform">
			<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
			<input type="hidden" id="" value="">
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
						<select name="cart">
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
			$('#myForm').attr('action', $('#contextPath')+'/customer/insertCart');
			alert('cartBtn:' + $('#myForm').action); // cart action 요청
			$()
		})
		
		$('#orderBtn').click(function(){
			$('#myForm').attr('method', 'get');
			$('#myForm').attr('action', $('#contextPath')+'/customer/insertOrders');
			alert('orderBtn:' + $('#myForm').action); // cart 화면 요청
		})
		
	</script>
</html>