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
		    max-width: 1000px;	
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
		
		form{
			display: flex; /* 자식 요소(테이블, 버튼)를 한 줄에 배치 */
			flex-wrap: wrap;
		    align-items: flex-end; /* 수직 정렬: 테이블 상단에 맞춤 */
		    gap: 20px;		    			
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
	        text-align: space-between;
	    }
	
		table td input[type="text"],
		table td textarea
		 {
		    width: 95%;
		    padding: 8px;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    font-size: 14px;
		}
	
		table tr:hover {
		    background-color: #eef7fc;
		}
		
		button[type="button"] {
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
		    display: block;
            
		}
		
		button[type="button"]:hover {
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
		<h1>addNotice</h1>
		<div class="header-container">	
			<!-- emp menu include -->
			<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>			
			<div class="emp-info">
				${loginEmp.empName}님 반갑습니다.
				<a href="${pageContext.request.contextPath}/out/logout">로그아웃</a>
			</div>
		</div>
		<form method="post" action="${pageContext.request.contextPath}/emp/addNotice">
			<input type="hidden" name="empCode" value="${loginEmp.empCode}">
			<table border="1">
				<tr>
					<th>제목</th>
					<td><input type="text" name="noticeTitle"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="15" cols="80" name="noticeContent"></textarea></td>
				</tr>
			</table>
		<button type="button" id="btn">등록</button>
		</form>		
	</div>
</body>
	<script>
	$('#btn').click(()=>{				
		$('form').submit();
	})	
	
	
	</script>
</html>