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

    .content-wrap {
        width: 100%;
        max-width: 900px; 
        background-color: #fff;
        padding: 30px;
        border-radius: 8px;
        
    }
    
    h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
        margin-bottom: 30px;
        font-size: 28px;
    }
    
    .menu-bar { /* c:import로 가져온 메뉴 바를 위한 스타일 */
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid #eee;
    }

    .section-header {
        display: flex;
        justify-content: space-between; /* "사원추가" 버튼을 오른쪽에 배치 */
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
        background-color: #218838;
    }

    /* 테이블 스타일 */
    .emp-list {
        width: 100%;
        border-collapse: collapse; 
        margin-bottom: 25px;
        font-size: 14px;
    }
    
    .emp-list th, 
    .emp-list td {
        border: 1px solid #ddd;
        padding: 12px 15px;
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
        <h1>empList</h1>
        
        <div class="menu-bar">
            <c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
        </div>
        
        <div class="section-header">
            <h3 style="margin:0; font-weight: normal;">사원 목록</h3>
            <a href="${pageContext.request.contextPath}/emp/addEmp">사원 추가</a>
        </div>
        
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
                <a href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage-1}">[이전]</a>
            </c:if>
            
            <span class="current-page">${currentPage}</span>
            
            <c:if test="${currentPage < lastPage}">
                <a href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage+1}">[다음]</a>
            </c:if>
        </div>			
    </div>
</body>
</html>