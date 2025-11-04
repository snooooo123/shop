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
	        font-family: Arial, sans-serif;
	        background-color: #f4f7f6;
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        min-height: 100vh; /* 뷰포트 높이의 최소값 */
	        margin: 0;
	    }
	
	    h1 {
	        color: #333;
	        text-align: center;
	        margin-bottom: 25px;
	    }
	
	    form {
	        background-color: #fff;
	        padding: 40px;
	        border-radius: 8px;
	        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	        width: 100%;
	        max-width: 400px; /* 폼의 최대 너비 제한 */
	        box-sizing: border-box; /* 패딩 포함 너비 */
	    }
	
	    form div {
	        margin-bottom: 18px; /* 각 입력 필드 사이 간격 */
	        display: flex; /* 라벨과 인풋을 한 줄에 정렬 */
	        align-items: center; /* 세로 중앙 정렬 */
	    }
	
	    form div label { /* 라벨이 있다면 */
	        flex: 1; /* 라벨이 차지하는 공간 */
	        color: #555;
	        font-weight: bold;
	        margin-right: 10px;
	    }
	    
	    form div span { /* 라벨 대신 텍스트로 직접 표시한 경우 */
	        flex: 1; /* 텍스트가 차지하는 공간 */
	        color: #555;
	        font-weight: bold;
	        margin-right: 10px;
	    }
	
	    form input[type="text"],
	    form input[type="password"] {
	        flex: 2; /* 인풋이 차지하는 공간 */
	        padding: 10px 12px;
	        border: 1px solid #ddd;
	        border-radius: 5px;
	        font-size: 16px;
	        width: 100%; /* flex 컨테이너 내에서 꽉 채움 */
	        box-sizing: border-box; /* 패딩 포함 너비 */
	    }
	
	    form input:focus {
	        border-color: #007bff;
	        outline: none;
	        box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
	    }
	
	    button#btn {
	        width: 100%;
	        padding: 12px;
	        background-color: #007bff;
	        color: white;
	        border: none;
	        border-radius: 5px;
	        font-size: 18px;
	        cursor: pointer;
	        transition: background-color 0.3s ease;
	        margin-top: 20px;
	    }
	
	    button#btn:hover {
	        background-color: #0056b3;
	    }
	</style>
</head>
<body>
	<h1>addEmp</h1>
	<form method="post" action="${pageContext.request.contextPath}/emp/addEmp">
		<div>
			<input type="text" class="id" name="id" id="id" placeholder="ID"> 
		</div>
		<div>
			<input type="password" class="pw" name="pw" id="pw" placeholder="PW"> 
		</div>
		<div>
			<input type="password" class="pw2" name="pw2" id="pw2" placeholder="PW 확인"> 
		</div>	
		<div>
			<input type="text" class="name" name="name" id="name" placeholder="name"> 
		</div>
		<button type="button" id="btn">가입</button>
	</form>
</body>
	<script>
		$('#btn').click(()=>{
			if($('#id').val()=='') {
				alert('id를 입력하세요')
			} else if($('#pw').val()!==$('#pw2').val()) {
				alert('pw가 다릅니다')
			} else if($('#name').val()=='') {
				alert('이름을 입력하세요')
			} else {			
				$('form').submit();
			}
		})
	</script>
</html>