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
	    padding: 0px;
	    display: flex;
	    justify-content: center; 
	}
	
	body > div {
		width: 100%;
		max-width: 1200px;
	}
	
	h1 {
	    color: #2c3e50;
	    border-left: 6px solid #ff3333;
	    padding-left: 10px;
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
	.customer-info {
		width: 350px; /* customer-info 영역의 너비를 지정하여 공간 확보 */
		flex-shrink: 0; /* 공간이 부족해도 축소되지 않도록 설정 */
		
		margin-bottom: 0px;
		padding: 10px;
		
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size: 15px;
	}
   	a {
	    color: #3498db;
	    text-decoration: none;
	    font-weight: 600;
	    transition: color 0.2s, text-decoration 0.2s;
	}
	
	a:hover {
	    color: #1a73e8;
	    text-decoration: underline;
	}

</style>
</head>
<body>
	<div>
		<h1>배송지조회</h1>
		<div class="header-container">
			<!-- customer menu -->
			<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
			
			<div class="customer-info">
				${loginCustomer.customerName}님 반갑습니다.
				(point : ${loginCustomer.point})
				<a href="${pageContext.request.contextPath}/out/logout">로그아웃</a>
			</div>
		</div>		
		<h2>주소조회</h2>
		<div>
			<form method="post" action="${pageContext.request.contextPath}/customer/addAddress">
				<div>
					<input type="text" name="address" id="sample4_postcode" placeholder="우편번호" readonly>
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" name="address" id="sample4_roadAddress" placeholder="도로명주소" readonly>
					<input type="text" name="address" id="sample4_jibunAddress" placeholder="지번주소" readonly>
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" name="address" id="sample4_detailAddress" placeholder="상세주소">
					<input type="text" name="address" id="sample4_extraAddress" placeholder="참고항목">
				</div>
				<button type="button" id="btn">배송지추가</button>
			</form>
		</div>
	</div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
    
    $('#btn').click(()=>{
		
    	
    	$('form').submit();
    })
</script>
</html>