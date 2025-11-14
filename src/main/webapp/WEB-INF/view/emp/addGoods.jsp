<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		/* ====== 상품 등록 페이지 스타일 ====== */
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
		    margin-bottom: 20px;		    
		}
		
		.wrap {
		    max-width: 1000px;
		    margin: 0 auto;
		    background-color: #fff;
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
		    width: 75%;
		    border-collapse: collapse;
		    background-color: #fff;
		    box-shadow: 0 0 5px rgba(0,0,0,0.05);
		    border-radius: 6px;
		    overflow: hidden;
		}
		
		table tr:nth-child(odd) {
		    background-color: #f9f9f9;
		}
		
		table th, table td {
		    padding: 12px;
		    text-align: left;
		    border: 1px solid #ddd;
		    font-size: 15px;
		}
		
		table th {
	        background-color: #ecf0f1;
	        color: #34495e;
	        font-weight: bold;
	        text-align: center;
	    }
	
		table td input[type="text"],
		table td input[type="number"],
		table td input[type="file"] {
		    width: 95%;
		    padding: 8px;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    font-size: 14px;
		}
	
		table tr:hover {
		    background-color: #eef7fc;
		}
		
		button[type="submit"] {
		    background-color: #3498db;
		    color: #fff;
		    border: none;
		    padding: 10px 20px;
		    border-radius: 5px;
		    font-size: 15px;
		    font-weight: bold;
		    cursor: pointer;
		    margin-top: 15px;
		    transition: background-color 0.2s ease;
		}
		
		button[type="submit"]:hover {
		    background-color: #1a73e8;
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
	</style>
</head>
<body>
	<div class="wrap">
		<h1>상품추가</h1>
			<!-- emp menu include -->
			<div class="header-container">	
			<!-- emp menu include -->
			<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>			
			<div class="emp-info">
				${loginEmp.empName}님 반갑습니다.
				<a href="${pageContext.request.contextPath}/out/logout">로그아웃</a>
			</div>
		</div>
		<hr>
		<form enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/emp/addGoods">
			<table border="1">
				<tr>
					<td>goodsName</td>
					<td><input type="text" name="goodsName"></td>
				</tr>
				<tr>
					<td>goodsPrice</td>
					<td><input type="number" name="goodsPrice"></td>
				</tr>
				<tr>
					<td>pointRate</td>
					<td><input type="text" name="pointRate"></td>
				</tr>
				<tr>
					<td>goodsImg(png / jpg / gif 확장자)</td>
					<td><input type="file" name="goodsImg"></td>
				</tr>
			</table>
			<button type="submit">상품등록</button>
		</form>
	</div>
</body>
</html>