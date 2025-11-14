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
    .content-wrap {
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
 

   	a {
	    color: #3498db;
	    text-decoration: none;
	    font-weight: 600;
	}
	
	a:hover {
	    color: #1a73e8;
	    text-decoration: underline;
	}

    .section-header {
        display: flex;
        justify-content: flex-end; /* "사원추가" 버튼을 오른쪽에 배치 */
        align-items: center;
        margin-bottom: 15px;
        padding-top: 10px;
    }

    .section-header a {
        color: #fff;
        background-color: #007bff; /* 파랑 버튼 스타일 */
        padding: 8px 15px;
        text-decoration: none;
        border-radius: 5px;
        font-size: 14px;
        transition: background-color 0.3s;
    }
    .section-header a:hover {
        background-color: #1a73e8;
    }

    /* 테이블 스타일 */
    .emp-list {
        width: 100%;
        border-collapse: collapse; 
        margin-top: 15px;
        font-size: 14px;
        box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }
    
    .emp-list th, 
    .emp-list td {
        border: 1px solid #ddd;
        padding: 10px 15px;
        text-align: center;
    }

    .emp-list th {
        background-color: #ecf0f1; 
        color: #34495e;
        font-weight: bold;
    }

    .emp-list tr:nth-child(even) {
        background-color: #f9f9f9; 
    }

    .emp-list tr:hover {
        background-color: #e8f4f8; 
    }

    /* 활성화/비활성화 링크 스타일 */
    .active-link {
        text-decoration: none;
        font-weight: 600;
        padding: 4px 8px;
        border-radius: 3px;
    }

    .active-0 { /* 비활성화 상태 */
        color: #dc3545; /* 빨간색 */
        border: 1px solid #dc3545;
    }
    .active-1 { /* 활성화 상태 */
        color: #007bff; /* 파란색 */
        border: 1px solid #007bff;
    }
    .active-link:hover {
        opacity: 0.8;
    }


    /* 페이징 스타일 */
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
    <div class="content-wrap">
        <h1>사원관리</h1>
        
        
        <div class="header-container">	
			<!-- emp menu include -->
			<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
		
			<div class="emp-info">
				${loginEmp.empName}님 반갑습니다.
				<a href="${pageContext.request.contextPath}/out/logout">로그아웃</a>
			</div>
		</div>
        <hr>
        <table class="emp-list">
            <thead>
                <tr>
                    <th>empCode</th>
                    <th>empId</th>
                    <th>empName</th>
                    <th>createdate</th>
                    <th>활성화/비활성화</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="e" items="${empList}">
                    <tr>
                        <td>${e.empCode}</td>
                        <td>${e.empId}</td>
                        <td>${e.empName}</td>
                        <td>${e.createdate}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/emp/modifyEmpActive?empCode=${e.empCode}&currentActive=${e.active}"
                               class="active-link active-${e.active}">
                                ${e.active == 0 ? '비활성화' : '활성화'}
                            </a>
                        </td>
                    </tr>
                </c:forEach>	
            </tbody>
        </table>
        
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage-1}">이전</a>
            </c:if>
            
            <span class="current-page">${currentPage}</span>
            
            <c:if test="${currentPage < lastPage}">
                <a href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage+1}">다음</a>
            </c:if>
        </div>			
    </div>
</body>
</html>