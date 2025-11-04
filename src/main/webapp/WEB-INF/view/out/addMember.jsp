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
        background-color: #f8f9fa; /* 밝은 배경 */
        display: flex; /* 중앙 정렬을 위한 Flexbox 사용 */
        justify-content: center; /* 가로 중앙 정렬 */
        align-items: center; /* 세로 중앙 정렬 */
        min-height: 100vh; /* 뷰포트 전체 높이 사용 */
        margin: 0;
    }

    /* h1과 form을 감싸는 컨테이너 */
    .register-wrap {
        display: flex;
        flex-direction: column; /* h1과 form을 세로로 정렬 */
        align-items: center; /* 내부 요소(h1, form) 가로 중앙 정렬 */
        width: 100%;
        max-width: 450px; /* 전체 폼 블록의 최대 너비 제한 */
    }

    h1 {
        color: #2c3e50;
        margin-bottom: 25px;
        font-size: 28px;
    }

    form {
        background-color: #fff;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        width: 100%;
        box-sizing: border-box;
    }

    /* 입력 필드 전체를 감싸는 내부 div (form > div) */
    form > div:first-of-type {
        /* 이 Div는 입력 필드 그룹입니다. */
    }

    /* 각 입력 필드 행 */
    form > div > div {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        gap: 10px; /* 레이블, 입력창, 버튼 사이 간격 */
    }
    
    /* 레이블 (아이디, 비밀번호 등) 영역 */
    form > div > div:not(:last-child) {
        /* 핸드폰 번호를 제외한 나머지 행 */
        justify-content: space-between;
    }

    /* 입력 필드 스타일 */
    input[type="text"],
    input[type="password"] {
        flex-grow: 1; /* 남은 공간을 최대한 채움 */
        padding: 10px 12px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 16px;
        box-sizing: border-box;
    }

    input:focus {
        border-color: #007bff;
        outline: none;
        box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
    }
    
    /* 중복확인 버튼 */
    form button[type="button"] {
        padding: 10px 15px;
        background-color: #6c757d; /* 회색 버튼 */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }
    
    form button[type="button"]:hover {
        background-color: #5a6268;
    }
    
    /* 가입 버튼 (#btn) */
    #btn {
        width: 100%;
        padding: 12px;
        background-color: #ff3333; 
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 18px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-top: 25px;
        font-weight: bold;
    }

    #btn:hover {
        background-color: #FF6666;
    }
    
    /* 필드 레이블 (아이디, 비밀번호, 이름 등)의 최소 너비를 설정하여 정렬 */
    form > div > div > span:first-child,
    form > div > div:not(:has(button)) > input[type="text"]:first-child,
    form > div > div:not(:has(button)) > input[type="password"]:first-child {
        min-width: 80px;
        text-align: left;
    }
    
</style>
</head>
<body>
    <div class="register-wrap">
        <h1>회원가입</h1>
        
        <form method="post" action="${pageContext.request.contextPath}/out/addMember">
            <div>
                <div>
                    <input type="text" class="id" name="id" id="id" placeholder="ID">
                    <button type="button" id="idCheckBtn">중복확인</button>			
                </div>
                <div>
                    <input type="password" class="pw" name="pw" id="pw" placeholder="PW">
                </div>
                <div>
                    <input type="password" class="pw2" name="pw2" id="pw2" placeholder="PW 확인">
                </div>
                <div>
                    <input type="text" class="name" name="name" id="name" placeholder="이름">
                </div>
                <div>
                    <input type="text" class="phone" name="phone" id="phone" placeholder="핸드폰 번호">
                </div>
            </div>
            <button type="button" id="btn">가입</button>
        </form>
    </div>
</body>
	<script>
		let isIdChecked = false;
		
		$('#id').on('input', ()=>{
			isIdChecked = false;
		});
		
		$('#idCheckBtn').click(()=>{
			if($('#id').val()=='') {
				alert('아이디를 입력하세요');
				return;
			} 	

			$.ajax({
				url: '${pageContext.request.contextPath}/ajax/idCheck'
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
			})						
		})
		$('#btn').click(()=>{
			if($('#id').val()==''){
				alert('아이디를 입력하세요')
				return;
			}
			if(isIdChecked==false) {
				alert('아이디 중복확인을 해주세요')
				return;
			} 
			if($('#pw').val()==''){
				alert('비밀번호를 입력하세요')
				return;
			}
			if($('#pw').val() !== $('#pw2').val()){
				alert('비밀번호가 다릅니다')
				return;
			}
			if($('#name').val()==''){
				alert('이름을 입력하세요')
				return;
			}
			if($('#phone').val()==''){
				alert('핸드폰 번호를 입력하세요')
				return;
			}
			$('form').submit();
		});
	</script>
</html>