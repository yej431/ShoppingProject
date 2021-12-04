<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="../mainHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쇼핑is - 매출관리</title>
<!-- google font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<!-- boxicons -->
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<!-- google chart -->
<script src="../js/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart1);
google.charts.setOnLoadCallback(drawChart2);
google.charts.setOnLoadCallback(drawChart3);
		
function drawChart1() {
	var jsonData = $.ajax({
		url: "productSales.jsp",
		dataType: "json",
		async: false
	}).responseText;
			
	var data = new google.visualization.DataTable(jsonData);
	var options = {
		legend: 'none',
		pieSliceText: 'label',
		title: '상품별 판매지수(%) TOP5',
		pieStartAngle: 100,
		fontSize: 15
	};

	var chart = new google.visualization.PieChart(document.getElementById('top5Chart'));
		chart.draw(data, options);
}

function drawChart2() {
	var jsonData = $.ajax({
		url: "dailySales.jsp",
		dataType: "json",
		async: false
	}).responseText;
			
	var data2 = new google.visualization.DataTable(jsonData);

	var options2 = {
		legend: {position: 'none'},
      chart: {
        title: '일별 총 매출',
        subtitle: '최근 7일간 매출',
      },
      bars: 'horizontal',
      hAxis: {format: '#,###'},
      height: 400,
      colors: ['#7570b3'],
      fontSize: 15
    };

    var chart2 = new google.charts.Bar(document.getElementById('dailyChart'));
    chart2.draw(data2, google.charts.Bar.convertOptions(options2));
}

function drawChart3() {
	var jsonData = $.ajax({
		url: "yearlySales.jsp",
		dataType: "json",
		async: false
	}).responseText;
	
	var data3 = new google.visualization.DataTable(jsonData);

  var options3 = {
	legend: {position: 'none'},
    title: '월별 총 매출',
    curveType: 'function',
    fontSize: 15
  };

  var chart3 = new google.visualization.LineChart(document.getElementById('yearlyChart'));
  chart3.draw(data3, options3);
}
</script>
</head>
<body>
<div class="wrap clearfix">
<div style="margin-top:40px" class="clearfix">
<div class="clearfix">
	<div id="top5Chart" style="width:600px; height:400px;float:left;"></div>
	<div id="dailyChart" style="width:700px; height:300px;float:left;margin-top:40px;"></div>
</div>
<div class="clearfix" id="yearlyChart" style="width:100%; height:500px;margin:80px 0 40px 0;"></div>
</div>
</div>
</body>
</html>