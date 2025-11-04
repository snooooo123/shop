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
	        min-height: 100vh;
	        margin: 0;
	    }
	    .add-wrap {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
            max-width: 400px;
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
	        max-width: 400px;
	        box-sizing: border-box;
	    }
	
	    /* 모든 입력 필드 그룹 */
	    form div {
	        margin-bottom: 18px;
	        display: flex;
	        align-items: center;
	        gap: 10px; /* 요소 간 기본 간격 */
	    }
        
        /* ------------------------------------------- */
        /* ⭐⭐ 추가된 CSS: ID 입력 필드와 버튼 정렬 ⭐⭐ */
        /* ------------------------------------------- */
        
        /* ID 입력 필드 (첫 번째 div) */
        .add-wrap form div:first-child {
            /* flex: 1; 이나 flex: 2; 같은 고정 비율 대신, 
               버튼 크기를 확보하고 나머지를 인풋이 차지하게 합니다. */
            display: flex; 
            align-items: center;
            gap: 10px;
        }
        
        /* ID 입력 필드 */
	    .add-wrap form div:first-child input[type="text"] {
	        flex-grow: 1; /* 남은 공간을 모두 차지 */
	        /* flex: 2; 대신 flex-grow를 사용 */
	        flex-shrink: 1;
	        flex-basis: auto;
	    }
	
        /* 중복확인 버튼 스타일 */
        .add-wrap form button.check {
            flex-shrink: 0; /* 공간이 부족해도 줄어들지 않음 */
            padding: 10px 15px; 
            background-color: #6c757d; 
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .add-wrap form button.check:hover {
            background-color: #5a6268;
        }
        
        /* ------------------------------------------- */
        
        /* 기존 일반 입력 필드 스타일 재조정 */
        /* 레이블이 없으므로 flex: 1 (라벨)과 flex: 2 (인풋) 비율을 제거합니다. 
           모든 인풋이 div 내에서 flex-grow: 1 로 최대한 커지도록 설정 */
	    form input[type="text"],
	    form input[type="password"] {
            flex-grow: 1; /* 남은 공간을 모두 채움 */
	        padding: 10px 12px;
	        border: 1px solid #ddd;
	        border-radius: 5px;
	        font-size: 16px;
	        width: 100%; 
	        box-sizing: border-box;
	    }
        
        /* 라벨/span 관련 CSS는 현재 HTML 구조에 없으므로 제거했습니다. */
	
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
	<div class="add-wrap">
	<h1>사원추가</h1>
		<form method="post" action="${pageContext.request.contextPath}/emp/addEmp">
			<div>
				<input type="text" class="id" name="id" id="id" placeholder="ID"> 
				<button type="button" class="check" name="check" id="check">중복확인</button> 
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
			<button type="button" id="btn">추가</button>
		</form>
	</div>
</body>
	<script>
	
		let isIdChecked = false;
		
		$('#id').on('input', ()=>{
			isIdChecked = false;
		});
		
		$('#check').click(()=>{
			if($('#id').val()=='') {
				alert('아이디를 입력하세요');
				return;
			} 
			
			$.ajax({
				url:'/shop/ajax/idCheck'
				, data: {'id':$('#id').val()}
				, success: (response) => {										
					if(response.check === true) {
						isIdChecked = true;
						alert('사용 가능한 아이디입니다.');
					} else {
						isIdChecked = false;
						alert('사용 불가능한 아이디입니다.');
					}					
				}
			});		
		});
			
		$('#btn').click(()=>{
			if($('#id').val()==''){
				alert('아이디를 입력하세요')
				return;
			}
			
			if(isIdChecked==false) {
				alert('아이디 중복확인을 해주세요')
				return;
			} 
			if($('#pw').val()=='') {
				alert('비밀번호를 입력하세요')
				return;
			}
			if($('#pw').val()!==$('#pw2').val()) {
				alert('pw가 다릅니다')
				return;
			}
			if($('#name').val()=='') {
				alert('이름을 입력하세요')
				return;
			}			
			$('form').submit();
		});						
	</script>
</html>