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
	<h1>강제탈퇴</h1>
	<form method = "post" action="${pageContext.request.contextPath}/emp/removeCustomer">
		<div>
			회원 ID: <input type="text" name="id" value="${customerId}" readonly>			
		</div>
		<div>
			사유: <textarea rows="5" cols="80" name="why" id="why"></textarea>
		</div>
		<button type="button" id="btn">확인</button>
	</form>
</body>
	<script>
		$('#btn').click(()=>{
			if($('#why').val().length<1){
				alert('사유를 적으세요');
				return;
			}						
			$('form').submit();
		});
	</script>
</html>