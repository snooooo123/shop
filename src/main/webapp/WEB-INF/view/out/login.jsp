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
	        padding: 40px;
	        background-color: #fff;
	    }
	
		form {
		    display: flex;
		    flex-direction: column; /* 자식 요소들을 세로로 배열 */
		    width: fit-content;
		}
	    /* 폼 전체를 감싸는 컨테이너 스타일 */
	    .login-container {
	        /* 이미지가 캡처된 영역에만 집중 */
	        width: fit-content; 
	        padding: 20px;
	    }
	
	    /* 로그인 폼 영역: 입력 필드 그룹(왼쪽)과 버튼 그룹(오른쪽)을 나란히 배치 */
	    form > div {
	        display: flex;
	        align-items: flex-start; /* 아이디/비번 영역과 버튼 영역의 상단을 맞춤 */
	        gap: 15px; /* 입력 필드와 버튼 사이 간격 */
	    }
	
	    /* 1. 입력 필드 (아이디/비번) 그룹 */
	    .input-fields-group {
	        display: flex;
	        flex-direction: column;
	        width: 300px; /* 입력 필드의 너비 지정 */
	    }
	
	    /* 레이블 (아이디, 비번) 스타일 */
	    .input-fields-group label {
	        display: block;
	        font-size: 18px;
	        font-weight: 500;
	        margin-bottom: 5px;
	        margin-top: 15px; /* 첫 번째 레이블을 제외하고 간격 주기 */
	    }
	    /* 첫 번째 레이블 (아이디)는 위쪽 마진을 없애서 시작점을 맞춤 */
	    .input-fields-group label:first-of-type {
	        margin-top: 0;
	    }
	    
	    /* 2. 입력 필드 스타일 (이미지의 밝은 회색 박스) */
	    input[type="text"], input[type="password"] {
	        width: 100%;
	        height: 50px; /* 이미지와 유사하게 높이 증가 */
	        padding: 6px 10px;
	        font-size: 16px;
	        border: none; /* 테두리 제거 */
	        background-color: #e0e0e0; /* 밝은 회색 배경 */
	        box-sizing: border-box;
	    }
	
	    /* 3. 버튼 그룹 (로그인, 회원가입) */
	    .buttons-group {
	        display: flex;
	        flex-direction: column;
	        width: 120px; /* 버튼 영역의 너비 */
	        margin-top: 31px;
	    }
	
	    /* 4. 로그인 버튼 (#btn) - 두 입력 필드의 높이와 동일하게 설정 */
	    #btn {
	        width: 100%;
	        /* ID 레이블/입력칸, PW 레이블/입력칸 사이 간격 등을 고려하여 높이 설정 */
	        /* (50px+5px) + (50px+5px) + (15px) + @ */
	        height: 105px; /* 이미지와 유사하도록 높이 조정 */
	        
	        font-size: 20px;
	        font-weight: 700;
	        color: white;
	        background-color: #ff3333; /* 중간 회색 배경 */
	        border: none;
	        cursor: pointer;
	        transition: background-color 0.3s;
	        margin-top: 0; /* 상단 정렬 */
	        align-self: flex-start;
	        box-sizing: border-box;
	    }
	    
	    #btn:hover {
	        background-color: #FF6666;
	        color: white;
	    }
	
	    /* 라디오 버튼 및 회원가입 링크 영역 (기존 HTML 구조에서 사용하지 않음) */
	    /* 이 영역은 이미지의 버튼 영역에 통합되어야 함 */
	
	    /* 5. 회원가입 버튼 (기존 <a> 태그를 버튼처럼 스타일링) */
	    a {
	        width: 100%;
	        height: 35px; /* 작은 버튼 높이 지정 */
	        line-height: 35px; /* 텍스트를 수직 중앙 정렬 */
	        text-align: center;
	        
	        font-size: 14px;
	        color: #333;
	        text-decoration: none;
	        border: none;
	        background-color: #e0e0e0; /* 밝은 회색 배경 */
	        margin-top: 5px; /* 로그인 버튼과의 간격 */
	        box-sizing: border-box;
	    }
	    
	    a:hover {
	        background-color: #bbb;
	        color: #222;
	    }
	
	    /* 기존에 있던 라디오 버튼 스타일은 제거하고, 이 구조에서는 사용하지 않습니다. */
	    .radio-selection-area {
		    display: flex;
		    justify-content: flex-start; /* 수평 중앙 정렬 */
		    gap: 20px; /* 라디오 버튼 사이 간격 */
		    width: 100%;
		    margin-top: 15px; /* 로그인/회원가입 영역과의 간격 */
		    padding-left: 10px;
		}
		
		/* 라디오 버튼 자체의 크기 조정 */
		.customerOrEmpSel {
		    transform: scale(1.2); /* 라디오 버튼 자체를 약간 크게 */
		}
		    
	</style>
</head>
<body>
	<div class="login-container">
		<h1>login</h1>
		<form method="post" action="${pageContext.request.contextPath}/out/login">
			
			<div class="login-main-area">
				<div class="input-fields-group">
						<label for="id">아이디</label>
						<input type="text" name="id" id="id" value="customer1">

						<label for="pw">비밀번호</label>
						<input type="password" name="pw" id="pw" value="1234">
				</div>
				<div class="buttons-group">
					<button type="button" id="btn">로그인</button>
					<a href="${pageContext.request.contextPath}/out/addMember">회원가입</a>
				</div>
			</div>	
			<div class="radio-selection-area">
				<input type="radio" name="customerOrEmpSel" class="customerOrEmpSel" value="customer" checked>customer
				<input type="radio" name="customerOrEmpSel" class="customerOrEmpSel" value="emp">emp
			</div>
						
		</form>		
	</div>
</body>
	<script>
	$(document).ready(function() {
		
	    // ⭐ [수정된 jQuery 로직] ⭐
	    $('input[name="customerOrEmpSel"]').on('change', function() {
	    	
	        // 1. name 속성을 이용해 '현재 선택된' 라디오 버튼의 value를 가져옵니다.
	        //    (change 이벤트가 발생한 요소의 value는 이미 this.value로도 접근 가능)
	        const selectedValue = $('input[name="customerOrEmpSel"]:checked').val();
	        
	        // 2. 값을 'emp'와 비교합니다.
	        $('#btn').css('background-color',
	                selectedValue === 'emp' ? '#007bff' : '#ff3333'
	            );
	    });
		$('#btn').click(()=>{
			if($('#id').val() == ''){
				alert('id를 입력하세요');
				return;
			}
			if($('#pw').val() == ''){
				alert('pw를 입력하세요');
				return;
			} 
			$('form').submit();											
		});
		
		$('input[name="customerOrEmpSel"]').trigger('change');
	});
	</script>
</html>