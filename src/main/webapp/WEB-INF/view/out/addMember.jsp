<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>회원가입</h1>
	
	<form method="post" action="${pageContext.request.contextPath}/addMember">
		<div>
			<div>
				아이디 <input type="text" class="id" name="id" id="id">
				<button type="button">중복확인</button>			
			</div>
			<div>
				비밀번호 <input type="password" class="pw" name="pw" id="pw">
			</div>
			<div>
				비밀번호 확인 <input type="password" class="pw2" name="pw2" id="pw2">
			</div>
			<div>
				이름 <input type="text" class="name" name="name" id="name">
			</div>
			<div>
				핸드폰 번호 <input type="text" class="phone" name="phone" id="phone">
			</div>
		</div>
		<button type="button" id="btn">가입</button>
	</form>
</body>
	<script>
		$('#btn').click(()=>{
			if($('#pw').val() !== $('#pw2').val()){
				alert('비밀번호가 다릅니다')
			}
		})
	
	
	</script>
</html>