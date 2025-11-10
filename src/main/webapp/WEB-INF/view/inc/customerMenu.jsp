<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
	<!-- 메인 메뉴 -->
	<a href="${pageContext.request.contextPath}/customer/customerIndex">[상품목록]</a>
	<!-- 상품목록 / 상세보기 / 주문 / -->
	
	<a href="${pageContext.request.contextPath}/customer/addressInfo">[개인정보]</a>
	<!-- 개인정보열람 / 비밀번호수정 / 회원탈퇴 / 폰번호수정 / -->
	<a href="${pageContext.request.contextPath}/customer/addressList">[배송지관리]</a>
	<!-- 배송지목록 / 배송지추가(최대 5개) / 삭제 -->
	
	<a href="${pageContext.request.contextPath}/customer/cartList">[장바구니]</a>
</div>