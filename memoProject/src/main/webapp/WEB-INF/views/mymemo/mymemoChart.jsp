<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMOZZANG 나의메모모아보기 - 차트로 모아보기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script src="https://rawgit.com/jasondavies/d3-cloud/master/build/d3.layout.cloud.js" type="text/JavaScript"></script>

<link rel="stylesheet" href=https://gitcdn.xyz/repo/octoshrimpy/blokkfont/master/blokkfont.css type="text/css">
<link rel="stylesheet" href="../resources/css/mymemoDefaultAll.css" type="text/css">
<style>
#div4 {
	position: relative;
    top: 200px;
    left: 150px;
    width: 1200px;
}
#div5{
	position: relative;
    top: -200px;
    left: 800px;
    background: aliceblue;
    width: 600px;
    height: 400px;
}
.wordcloud {
	position: relative;
    top: -370px;
}

/* 말풍선 */
.box2 {
  width: 300px;
  margin: 50px auto;
  border: 4px solid #00bfb6;
  padding: 20px;
  text-align: center;
  font-weight: 900;
  color: #00bfb6;
  font-family: arial;
  position: relative;
  background-color: rgba( 255, 255, 255, 0.5 );
}


/* speech bubble 9 */

.sb9:before {
  content: "";
  width: 0px;
  height: 0px;
  position: absolute;
  border-left: 10px solid transparent;
  border-right: 10px solid transparent;
  border-top: 10px solid #00bfb6;
  border-bottom: 10px solid transparent;
  right: 50%;
  bottom: -23px;
}

.sb9:after {
  content: "";
  width: 0px;
  height: 0px;
  position: absolute;
  border-left: 10px solid transparent;
  border-right: 10px solid transparent;
  border-top: 10px solid #fff;
  border-bottom: 10px solid transparent;
  right: 50%;
  bottom: -18px;
}

#div4_1 {
	position: absolute;
    top: 280px;
    left: 280px;
}
#div5_1 {
	position: absolute;
    top: 280px;
    left: 920px;
}

</style>
</head>

<body>

<div id="div1">
	<div id="div2">
		<div class='dropdown'>
  			<label>그래프로 모아보기</label>
  			<ul>
			    <li onClick='close_pop("/mymemo/mymemoDefaultAll");'>한눈에 모아보기</li>
			    <li onClick='close_pop("/mymemo/mymemoCalendar");'>달력으로 모아보기</li> 
			    <li onClick='close_pop("/mymemo/mymemoChart");'>그래프로 모아보기</li>
			    <li onClick='close_pop("/mymemo/mymemoBookmark");'>북마크로 모아보기</li>
			</ul>
		</div>
	</div>
</div><!-- div1 of end -->


<!--Div that will hold the pie chart-->

<div id="div4_1">
	<div class="box2 sb9">날짜별 그래프</div>
</div>
<div id="div5_1">
	<div class="box2 sb9">가장 많이 쓴 키워드는?</div>
</div>
<div id="div4">
	<div id="chart_div" style="width: 600px; height: 400px;"></div>
</div>
<div id="div5">
	<!-- <div id="wordtree_basic" style="width: 600px; height: 400px;"></div> -->
	<div id="wordcloud"></div>
</div>

<form name="formMod" method="post" action="">
<input type="hidden" name="memo_contents" />
<input type="hidden" name="mem_no" id="mem_no" value="${login.mem_no}">
<input type="hidden" name="username" value="${username}">
<input type="hidden" name="memo_name" id="memo_name" value="${login.mem_name}">
<input type="hidden" name="memo_no" id="memo_no" value="${list.memo_no}">
</form>



<script>
//팝업 Close 기능
function close_pop(url) {
	window.location.href = url;
};
</script>
<script>
	// 드롭다운
	var dropdown = document.querySelector('.dropdown'),
    dropdown_ul = dropdown.querySelector('ul');

	dropdown.addEventListener('click', function() {
	  if(dropdown_ul.offsetLeft < 0) {
	    dropdown_ul.style.left = '0';
	    dropdown_ul.style.right = '0';
	    dropdown_ul.stle.display = 'static';
	  } else {
	    dropdown_ul.style.left = '-9999px';
	    dropdown_ul.style.right = '';
	    dropdown_ul.stle.display = 'absolute';
	  }
	});
	
	
	$('.dropdown li').each(function() {
	  $(this).click(function() {
	    $('.dropdown label').text($(this).text());
	  });
	});
	 
</script>
<script>
 $(document).ready(function(){
}); /* end of script */
	
</script>
<script>
var mem_no = $('#mem_no').val();
console.log("mem_no?: "+mem_no);

// 구글 차트
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	var jsonData = $.ajax({
		url : "/mymemo/dayChart",
		dataType : "json",
		data: {
			mem_no : mem_no
		},
		async : false
		}).responseText;
	console.log(jsonData);
	
	//json 데이터를 데이터 테이블로 변환
	var data = new google.visualization.DataTable(jsonData);
	
/*   var data = google.visualization.arrayToDataTable([
    ['Age', 'Weight'],
    [ 8,      12],
    [ 4,      5.5],
    [ 11,     14],
    [ 4,      5],
    [ 3,      3.5],
    [ 6.5,    7]
  ]); */

  var options = {
    title: '날짜별 그래프',
    hAxis: {title: 'Day', minValue: 0, maxValue: 15},
    vAxis: {title: 'write count', minValue: 0, maxValue: 15},
    legend: 'none'
  };

  var chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));

  chart.draw(data, options);
}


    
</script>
<script>
/* var mem_no = $('#mem_no').val();
console.log("mem_no?: "+mem_no);

google.charts.load('current', {packages:['wordtree']});
google.charts.setOnLoadCallback(drawChart); 

function drawChart() {*/
	/* var jsonData = $.ajax({
		url : "/mymemo/contentChart",
		dataType : "json",
		data: {
			mem_no : mem_no
		},
		async : false
		}).responseText;
	console.log(jsonData); */
	
	/*   var data = google.visualization.arrayToDataTable(
    [ ['Phrases'],
      ['cats are better than dogs'],
      ['cats eat kibble'],
      ['cats are better than hamsters'],
      ['cats are awesome'],
      ['cats are people too'],
      ['cats eat mice'],
      ['cats meowing'],
      ['cats in the cradle'],
      ['cats eat mice'],
      ['cats in the cradle lyrics'],
      ['cats eat kibble'],
      ['cats for adoption'],
      ['cats are family'],
      ['cats eat mice'],
      ['cats are better than kittens'],
      ['cats are evil'],
      ['cats are weird'],
      ['cats eat mice'],
    ]
  );

  var options = {
    wordtree: {
      format: 'implicit',
      word: 'cats'
    }
  };

  var chart = new google.visualization.WordTree(document.getElementById('wordtree_basic'));
  chart.draw(data, options);
} 
*/
</script>

<script>
//wordcloud
 var wordcloudlist = $.ajax({
		
		type: "GET",
	    url: "/mymemo/wordcloud",
	    dataType: "json",
	    data: {
			mem_no : mem_no
		},
	    contentType: "application/json; charset:UTF-8", 
	    async: false
		}).responseText; 
  
   var wordcloudtest = [{"memo_title":"dd","mount":40}];
   
 	  var x = JSON.parse(wordcloudlist);
     var y = wordcloudtest;
 
   console.log("Json데이터 ",x)
   console.log("11",y)
 
   
   var color = d3.scale.linear() //선형적인 스케일로 표준화를 시킨다.
           .domain([0,1,2,3,4,5,6,10,15,20,100])//데이터의 범위, 입력 크기
           .range([0.50]);//표시할 범위, 출력 크기
           //ex)"#ddd", "#ccc", "#bbb", "#aaa", "#999", "#888", "#777", "#666", "#555", "#444", "#333", "#222"

   d3.layout.cloud().size([600, 400]) //[width,height]
           .words(x)
           .rotate(0)
           .fontSize(function(d) { return d.mount; })
           .on("end", draw)
           .start();
   
   function draw(words) {
       d3.select("#wordcloud").append("svg")//wordcloud 테이블에 svg를 붙이고
               .attr("width", 600)
               .attr("height", 400)
               .attr("class", "wordcloud")
               .append("g")
               .attr("transform", "translate(320,200)")
               .selectAll("text")
               .data(words)
               .enter().append("text")
               .style("font-size", function(d) { return d.mount + "px"; })
               .style("fill", function(d, i) { return color(i); })
               .attr("transform", function(d) {
                   return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
               })
               .text(function(d) { return d.memo_title; });
   }
</script>
</body>
</html>