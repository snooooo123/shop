<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.5.0"></script>
</head>
<body>
	<h1>stats</h1>
	<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
	<hr>
	
	<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
	
	<input type="text" id="fromYM" value="2025-01-01">
	~
	<input type="text" id="toYM" value="2025-12-31">
	<br>
	<!-- 완성 -->
	<button type="button" id="totalOrderBtn">특정년도의 월별 주문횟수(누적) : 선 차트</button>	
	<button type="button" id="totalPriceBtn">특정년도의 월별 주문금액(누적) : 선 차트</button>
	<button type="button" id="orderBtn">특정년도의 월별 주문수량 : 막대 차트</button>
	<button type="button" id="priceBtn">특정년도의 월별 주문금액 : 막대 차트</button>
	
	<button type="button" id="genderOrderBtn">성별 총주문 수량 : 파이 차트</button>
	<button type="button" id="genderPriceBtn">성별 총주문 금액 : 파이 차트</button>
	<!-- 미완성 -->
	
	<button type="button" id="cntTop10Btn">고객별 주문횟수 1 ~ 10위 : 막대 차트</button>
	<button type="button" id="priceTop10Btn">고객별 총금액 1 ~ 10위 : 막대 차트</button>
	<button type="button" id="goodsCntTop10Btn">상품별 주문횟수 1 ~ 10위 : 막대 차트</button>
	<button type="button" id="goodsPriceTop10Btn">상품별 주문금액 1 ~ 10위 : 막대 차트</button>
	<button type="button" id="">상품별 평균 리뷰평점 1 ~ 10위 : 막대 차트</button>
	
	
		
	<canvas id="myChart" style="width:100%;max-width:700px"></canvas>
	
	<script>

		let myChart = null;
		
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
					
					const barColors = ["red", "green","blue","orange","brown", "yellow"];

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
					
					const barColors = ["red", "green","blue","orange","brown", "yellow"];

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
					
					const barColors = ["red", "green","blue","orange","brown", "yellow"];

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
					        text: "주문량 TOP 10",
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
					
					const barColors = ["red", "green","blue","orange","brown", "yellow"];

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
					        text: "주문량 TOP 10",
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
					
					const barColors = ["red", "green","blue","orange","brown", "yellow"];

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
					        text: "2025-01-01 ~ 현재 월별 판매량",
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
					
					const barColors = ["red", "green","blue","orange","brown", "yellow"];

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
					        text: "2025-01-01 ~ 현재 월별 판매금액",
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
								label : $('#fromYM').val() + '~' + $('#toYM').val() + '주문량 추이(누적)',												
								data : y,
								borderColor : "red",
								fill : false
							}]
						},
						options : {
							legend : {
								display : false
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
								label: $('#fromYM').val() + '~' + $('#toYM').val() + '총판매금액 추이(누적)'
								, data: y
								, borderColor: '#0000FF'
								, fill: false
							}]
						}
						, option: {
							legend: {display : false}
						}
					});
				}
			})
		})
	</script>
</body>
</html>