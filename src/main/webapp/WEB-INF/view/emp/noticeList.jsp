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
	        background-color: #27ae60; 
	        padding: 8px 15px;
	        text-decoration: none;
	        border-radius: 5px;
	        font-size: 14px;
	        transition: background-color 0.3s;
	    }
	    .addbtn a:hover {
	        background-color: #1e8449;
		}
		
		.pagination { 
		   text-align: center;
		   margin-top: 30px;
		   margin-bottom: 20px;
		   font-size: 15px;
		}
		
		/* 페이지 링크 <a> 태그 스타일 */
		.pagination a {
		    color: #3498db;
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
		    background-color: #3498db;
		    color: #fff;
		    text-decoration: none;
		}
		
		/* 현재 페이지 <span> 태그 스타일 */
		.pagination span.current-page {
		    padding: 8px 14px;
		    font-weight: bold;
		    color: #fff;
		    background-color: #3498db;
		    border-radius: 4px;
		    
			margin: 0 3px;
		    
		    display: inline-block;
		    border: none;
		}

</style>
</head>
<body>
	<div class="wrap">
		<h1>공지관리</h1>
		<!-- empMenu -->		
		<div class="header-container">	
			<!-- emp menu include -->
			<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>			
			<div class="emp-info">
				${loginEmp.empName}님 반갑습니다.
				<a href="${pageContext.request.contextPath}/out/logout">로그아웃</a>
			</div>
		</div>
		
		<table border="1">
			<tr>
				<th>noticeCode</th>
				<th>noticeTitle</th>
				<th>게시자</th>
				<th>createdate</th>
			</tr>
			<c:forEach var="n" items="${list}">
				<tr>
					<td>${n.noticeCode}</td>
					<td><a href="${pageContext.request.contextPath}/emp/noticeOne?noticeCode=${n.noticeCode}">${n.noticeTitle}</a></td>
					<td>${n.empId}</td>
					<td>${n.createdate}</td>
				</tr>
			</c:forEach>
		</table>
		
		<div class="addbtn">
			<a href="${pageContext.request.contextPath}/emp/addNotice">공지추가</a>	
		</div>
		
		<div class="pagination">
			<!-- [이전] 1 2 3 4 5 6 7 8 9 10 [다음] -->
			
			<c:if test="${startPage>1}">
				<a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${startPage-10}">이전</a>
			</c:if>
			<span>
				<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
					<c:if test="${currentPage == i}">
						<span class="current-page">${i}</span>
					</c:if>
					<c:if test="${currentPage != i}">
						<a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${i}">${i}</a>
					</c:if>	
				</c:forEach>
			</span>
			
			<c:if test="${endPage!=lastPage}">
				<a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${startPage+10}">다음</a>
			</c:if>
		</div>
	</div>
</body>
</html>