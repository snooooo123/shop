<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.5.0"></script>
<style>
/* ====== 통계 페이지 스타일 ====== */
	body {
	    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
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
	
	.wrap {
	    width: 100%;
	    max-width: 1015px;			    		    	   
	    border-radius: 8px;		    
	}
	
	/* Input and Button Styles */
	#fromYM, #toYM {
		padding: 5px;
		margin-right: 5px;
		border: 1px solid #ccc;
		border-radius: 4px;
	}
	
	button {
		padding: 8px 12px;
		margin: 5px 5px 15px 0;
		border: none;
		border-radius: 5px;
		background-color: #3498db;
		color: white;
		cursor: pointer;
		transition: background-color 0.3s;
		font-size: 14px;
	}
	button:hover {
		background-color: #2980b9;
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
	
	/* 캔버스 스타일 */
	#myChart {
		margin-top: 20px;
		border: 1px solid #eee;
		border-radius: 5px;
		padding: 10px;
		background-color: #fcfcfc;
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
	</style>
</head>
<body>
	<div class="wrap">
		<h1>stats</h1>
		<div class="header-container">	
			<!-- emp menu include -->
			<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
			<hr>
			<div class="emp-info">
				${loginEmp.empName}님 반갑습니다.
				<a href="${pageContext.request.contextPath}/out/logout">로그아웃</a>
			</div>
		</div>
		
		<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
		
		<input type="text" id="fromYM" value="2025-01-01">
		~
		<input type="text" id="toYM" value="2025-12-31">
		<br>
		
		<button type="button" id="totalOrderBtn">특정년도의 월별 주문횟수(누적) : 선 차트</button>	
		<button type="button" id="totalPriceBtn">특정년도의 월별 주문금액(누적) : 선 차트</button>
		
		<button type="button" id="orderBtn">특정년도의 월별 주문수량 : 막대 차트</button>
		<button type="button" id="priceBtn">특정년도의 월별 주문금액 : 막대 차트</button>			
		
		<button type="button" id="cntTop10Btn">고객별 주문횟수 1 ~ 10위 : 막대 차트</button>
		<button type="button" id="priceTop10Btn">고객별 총금액 1 ~ 10위 : 막대 차트</button>
		<button type="button" id="goodsCntTop10Btn">상품별 주문횟수 1 ~ 10위 : 막대 차트</button>
		<button type="button" id="goodsPriceTop10Btn">상품별 주문금액 1 ~ 10위 : 막대 차트</button>
		<button type="button" id="reviewTop10Btn">상품별 평균 리뷰평점 1 ~ 10위 : 막대 차트</button>
		
		<button type="button" id="genderOrderBtn">성별 총주문 수량 : 파이 차트</button>
		<button type="button" id="genderPriceBtn">성별 총주문 금액 : 파이 차트</button>
			
		<canvas id="myChart" style="width:100%;max-width:700px"></canvas>
		
		<script>
	
			let myChart = null;
			
			// 미완성 버튼에 임시 ID 부여: 상품별 평균 리뷰평점 1 ~ 10위
			$('#reviewTop10Btn').click(function() {
				// alert('상품별 평균 리뷰평점 1~10위 차트 요청');
				// 여기에 AJAX 및 Chart.js 코드를 추가하세요.
			});
			
			// 상품 수익 top10
			$('#goodsPriceTop10Btn').click(function() {
				$.ajax({
					url: $('#contextPath').val() + '/emp/goodsPrice'
					, type: 'get'
					, data: { fromYM : $('#fromYM').val(), toYM : $('#toYM').val() }
					, success: function(result) {
						
						console.log(result)
						
						let xValues = [];
						let yValues = [];
						
						result.forEach(function (m) {
							xValues.push(m.codes);
							yValues.push(m.total);
						});
						
						const barColors = ["red", "green","blue","orange","brown", "yellow", "purple", "cyan", "magenta", "lime"];
	
						const ctx = document.getElementById('myChart');					
						
						if(myChart != null) {
							myChart.destroy();
						}
						
						myChart = new Chart(ctx, {
						  type: "bar",
						  data: {
						    labels: xValues,
						    datasets: [{
						      backgroundColor: barColors,
						      data: yValues
						    }]
						  },
						  options: {
						    plugins: {
						      legend: {display: false},
						      title: {
						        display: true,
						        text: "상품 수익 TOP 10",
						        font: {size: 16}
						      }
						    }
						  }
						});
					}
				});
			});
				
			// 상품 판매량 top10
			$('#goodsCntTop10Btn').click(function() {
				$.ajax({
					url: $('#contextPath').val() + '/emp/goodsCnt'
					, type: 'get'
					, data: { fromYM : $('#fromYM').val(), toYM : $('#toYM').val() }
					, success: function(result) {
						
						console.log(result)
						
						let xValues = [];
						let yValues = [];
						
						result.forEach(function (m) {
							xValues.push(m.codes);
							yValues.push(m.cnt);
						});
						
						const barColors = ["red", "green","blue","orange","brown", "yellow", "purple", "cyan", "magenta", "lime"];
	
						const ctx = document.getElementById('myChart');					
						
						if(myChart != null) {
							myChart.destroy();
						}
						
						myChart = new Chart(ctx, {
						  type: "bar",
						  data: {
						    labels: xValues,
						    datasets: [{
						      backgroundColor: barColors,
						      data: yValues
						    }]
						  },
						  options: {
						    plugins: {
						      legend: {display: false},
						      title: {
						        display: true,
						        text: "판매량 TOP 10",
						        font: {size: 16}
						      }
						    }
						  }
						});
					}
				});
			});
			// 주문금액 top10
			$('#priceTop10Btn').click(function() {
				$.ajax({
					url: $('#contextPath').val() + '/emp/customerPrice'
					, type: 'get'
					, data: { fromYM : $('#fromYM').val(), toYM : $('#toYM').val() }
					, success: function(result) {
						
						console.log(result)
						
						let xValues = [];
						let yValues = [];
						
						result.forEach(function (m) {
							xValues.push(m.codes);
							yValues.push(m.total);
						});
						
						const barColors = ["red", "green","blue","orange","brown", "yellow", "purple", "cyan", "magenta", "lime"];
	
						const ctx = document.getElementById('myChart');					
						
						if(myChart != null) {
							myChart.destroy();
						}
						
						myChart = new Chart(ctx, {
						  type: "bar",
						  data: {
						    labels: xValues,
						    datasets: [{
						      backgroundColor: barColors,
						      data: yValues
						    }]
						  },
						  options: {
						    plugins: {
						      legend: {display: false},
						      title: {
						        display: true,
						        text: "고객별 주문금액 TOP 10", // 텍스트 수정
						        font: {size: 16}
						      }
						    }
						  }
						});
					}
				});
			});
			
			// 주문량 top10
			$('#cntTop10Btn').click(function() {
				$.ajax({
					url: $('#contextPath').val() + '/emp/customerOrder'
					, type: 'get'
					, data: { fromYM : $('#fromYM').val(), toYM : $('#toYM').val() }
					, success: function(result) {
						
						console.log(result)
						
						let xValues = [];
						let yValues = [];
						
						result.forEach(function (m) {
							xValues.push(m.codes);
							yValues.push(m.cnt);
						});
						
						const barColors = ["red", "green","blue","orange","brown", "yellow", "purple", "cyan", "magenta", "lime"];
	
						const ctx = document.getElementById('myChart');					
						
						if(myChart != null) {
							myChart.destroy();
						}
						
						myChart = new Chart(ctx, {
						  type: "bar",
						  data: {
						    labels: xValues,
						    datasets: [{
						      backgroundColor: barColors,
						      data: yValues
						    }]
						  },
						  options: {
						    plugins: {
						      legend: {display: false},
						      title: {
						        display: true,
						        text: "고객별 주문횟수 TOP 10", // 텍스트 수정
						        font: {size: 16}
						      }
						    }
						  }
						});
					}
				});
			});
			
			// 성별 주문량
			$('#genderOrderBtn').click(function(){
				$.ajax({
					url: $('#contextPath').val() + '/emp/genderOrder'
					, type: 'get'
					//, data: { fromYM : $('#fromYM').val(), toYM : $('#toYM').val() }
					, success: function(result){
						
						console.log(result)
						
						let xValues = [];
						let yValues = [];
						
						result.forEach(function(m) {
							xValues.push(m.gender);
							yValues.push(m.count);
						});
						
						const barColors = [ "#e8c3b9", "#1e7145" ];
	
						if(myChart) {
							myChart.destroy();
						}
						
						const ctx = document.getElementById('myChart');
	
						myChart = new Chart(ctx, {
						  type: "pie",
						  data: {
						    labels: xValues,
						    datasets: [{
						      backgroundColor: barColors,
						      data: yValues
						    }]
						  },
						  options: {
						    plugins: {
						      legend: {display:true},
						      title: {
						        display: true,
						        text: "남/여 전체 주문량",
						        font: {size:16}
						      }
						    }
						  }
						});
					}			
				});
			});
			
			// 성별 주문금액
			$('#genderPriceBtn').click(function(){
				$.ajax({
					url: $('#contextPath').val() + '/emp/genderPrice'
					, type: 'get'
					//, data: { fromYM : $('#fromYM').val(), toYM : $('#toYM').val() }
					, success: function(result){
						
						console.log(result)
						
						let xValues = [];
						let yValues = [];
						
						result.forEach(function(m) {
							xValues.push(m.gender);
							yValues.push(m.total);
						});
						
						const barColors = [ "#e8c3b9", "#1e7145" ];
	
						if(myChart) {
							myChart.destroy();
						}
						
						const ctx = document.getElementById('myChart');
	
						myChart = new Chart(ctx, {
						  type: "pie",
						  data: {
						    labels: xValues,
						    datasets: [{
						      backgroundColor: barColors,
						      data: yValues
						    }]
						  },
						  options: {
						    plugins: {
						      legend: {display:true},
						      title: {
						        display: true,
						        text: "남/여 전체 주문금액",
						        font: {size:16}
						      }
						    }
						  }
						});
					}			
				});
			});
			
			// 월별 판매량
			$('#orderBtn').click(function() {
				$.ajax({
					url: $('#contextPath').val() + '/emp/order'
					, type: 'get'
					, data: { fromYM : $('#fromYM').val(), toYM : $('#toYM').val() }
					, success: function(result) {
						
						//console.log(result)
						
						let xValues = [];
						let yValues = [];
						
						result.forEach(function (m) {
							xValues.push(m.ym);
							yValues.push(m.cnt);
						});
						
						const barColors = ["#8BC34A", "#4CAF50", "#00BCD4", "#2196F3", "#3F51B5", "#673AB7", "#9C27B0", "#E91E63", "#F44336", "#FF9800", "#FFC107", "#FFEB3B"];
	
						const ctx = document.getElementById('myChart');					
						
						if(myChart != null) {
							myChart.destroy();
						}
						
						myChart = new Chart(ctx, {
						  type: "bar",
						  data: {
						    labels: xValues,
						    datasets: [{
						      backgroundColor: barColors.slice(0, xValues.length), // 데이터 수에 맞게 색상 적용
						      data: yValues
						    }]
						  },
						  options: {
						    plugins: {
						      legend: {display: false},
						      title: {
						        display: true,
						        text: $('#fromYM').val() + ' ~ ' + $('#toYM').val() + ' 월별 주문수량',
						        font: {size: 16}
						      }
						    }
						  }
						});
					}
				});
			});
			
			// 월별 판매금액
			$('#priceBtn').click(function() {
				$.ajax({
					url: $('#contextPath').val() + '/emp/price'
					, type: 'get'
					, data: { fromYM : $('#fromYM').val(), toYM : $('#toYM').val() }
					, success: function(result) {
						
						//console.log(result)
						
						let xValues = [];
						let yValues = [];
						
						result.forEach(function (m) {
							xValues.push(m.ym);
							yValues.push(m.total);
						});
						
						const barColors = ["#8BC34A", "#4CAF50", "#00BCD4", "#2196F3", "#3F51B5", "#673AB7", "#9C27B0", "#E91E63", "#F44336", "#FF9800", "#FFC107", "#FFEB3B"];
	
						const ctx = document.getElementById('myChart');					
						
						if(myChart != null) {
							myChart.destroy();
						}
						
						myChart = new Chart(ctx, {
						  type: "bar",
						  data: {
						    labels: xValues,
						    datasets: [{
						      backgroundColor: barColors.slice(0, xValues.length), // 데이터 수에 맞게 색상 적용
						      data: yValues
						    }]
						  },
						  options: {
						    plugins: {
						      legend: {display: false},
						      title: {
						        display: true,
						        text: $('#fromYM').val() + ' ~ ' + $('#toYM').val() + ' 월별 주문금액',
						        font: {size: 16}
						      }
						    }
						  }
						});
					}
				});
			});
			
			// 월별 누적 주문량
			$('#totalOrderBtn').click(function() {
				// alert('orderAndPrice 클릭');
				$.ajax({
					url : $('#contextPath').val() + '/emp/totalOrder',
					type : 'get',
					data : {
						fromYM : $('#fromYM').val()
						, toYM : $('#toYM').val()
					}
					, success : function(result) {
						//console.log(result);
	
						let x = [];
						let y = [];
						
						//console.log(x, x)
						//console.log(y, x)
	
						result.forEach(function(m) {
							x.push(m.ym);
							y.push(m.totalOrder)
						});
	
						if (myChart != null) {
							myChart.destroy();
						}
	
						myChart = new Chart("myChart", {
							type : "line",
							data : {
								labels : x,
								datasets : [{
									label : $('#fromYM').val() + '~' + $('#toYM').val() + ' 주문량 추이(누적)', // 레이블 수정											
									data : y,
									borderColor : "red",
									fill : false
								}]
							},
							options : {
								plugins: { // title 추가
								      title: {
								        display: true,
								        text: $('#fromYM').val() + ' ~ ' + $('#toYM').val() + ' 월별 주문횟수 (누적)',
								        font: {size: 16}
								      },
								      legend : {
										display : false
									}
								}
							}
						});
					}
				});
			});
					
			// 월별 누적 판매량
			$('#totalPriceBtn').click(function(){
				$.ajax({
					url: $('#contextPath').val()+'/emp/totalPrice'
					, type: 'get'
					, data: { fromYM:$('#fromYM').val(), toYM:$('#toYM').val()}
					, success: function(result) {
						//console.log(result);
					
						let x = [];
						let y = [];
						
						//console.log(x, x)
						//console.log(y, x)
						
						result.forEach(function(m){
							x.push(m.ym);
							y.push(m.totalPrice);
						});
						
						if(myChart != null) {
							myChart.destroy();
						}
						
						myChart = new Chart('myChart',{
							type: 'line'
							, data: {
								labels: x
								, datasets: [{
									label: $('#fromYM').val() + '~' + $('#toYM').val() + ' 총판매금액 추이(누적)'
									, data: y
									, borderColor: '#0000FF'
									, fill: false
								}]
							}
							, options: { // options 오타 수정 및 title 추가
								plugins: { 
									title: {
								        display: true,
								        text: $('#fromYM').val() + ' ~ ' + $('#toYM').val() + ' 월별 주문금액 (누적)',
								        font: {size: 16}
								    },
									legend: {display : false}
								}
							}
						});
					}
				})
			})
		</script>
	</div>
</body>
</html>