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
<title>MEMOZZNAG 나의메모모아보기 - 한눈에모아보기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<meta name="author" content="www.twitter.com/cheeriottis">

<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Raleway:300,400' rel='stylesheet' type='text/css'>
<style>

/* Modal Content Box */
  .modal {
      display:none;                         
  }

/* memo */
#stickyModal {
  position: relative;
  background-color: #c6f1e7; 
  display: inline-block;
  padding: 20px;
  top: 70px;
  width: 900px;
  height: 400px;
}
#stickyModal:hover {
  background-color: #97cfc2;
}
#stickyModal textarea {
  border: 0px;
  min-width: 900px;
  min-height: 400px;
  max-width: 488px;
  max-height: 500px;
  background-color: transparent;
  color: #2d2d2d;
  font-family: 'Noto Serif KR', serif;
  font-size: 1.5em;
  line-height: 140%;
  outline: none
}
[draggable=true] {
    cursor: move;
}
#stickyModal:hover {
}
#stickyModal:before
{
  z-index: -1;
  position: absolute;
  content: "";
  bottom: 20px;
  left: 12px;
  width: 50%;
  top: 80%;
  max-width: 300px;
  background: transparent;
  box-shadow: 0 20px 10px #999;
  transform: rotate(-4deg)
}
#stickyModal::-webkit-scrollbar-track
{
	-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
	background-color: transparent;
}
#stickyModal::-webkit-scrollbar
{
	width: 10px;
	background-color: #F5F5F5;
}
#stickyModal::-webkit-scrollbar-thumb
{
	background-color: transparent;
	border: 0px;
}
::-webkit-input-placeholder { 
  color: #2d2d2d
}
::-moz-placeholder {
  color: #2d2d2d
}
:-ms-input-placeholder {
  color: #2d2d2d
}
:-moz-placeholder {
  color: #2d2d2d
}

#sticky {
  position: relative;
  background-color: #c6f1e7; 
  display: inline-block;
  padding: 20px;
  width: 200px;
  height: 170px;
  top: 50px;
}
#sticky:hover {
  background-color: #97cfc2;
}
#sticky textarea {
  border: 0px;
  min-width: 200px;
  min-height: 160px;
  max-width: 488px;
  max-height: 390px;
  background-color: transparent;
  font-family: "Comic Sans MS", cursive;
  color: #2d2d2d;
  font-size: 1.5em;
  line-height: 140%;
  min-height: 260px;
  outline: none
}
[draggable=true] {
    cursor: move;
}
#sticky:hover {
}
#sticky:before
{
  z-index: -1;
  position: absolute;
  content: "";
  bottom: 20px;
  left: 12px;
  width: 50%;
  top: 80%;
  max-width: 300px;
  background: transparent;
  box-shadow: 0 20px 10px #999;
  transform: rotate(-4deg)
}
#sticky::-webkit-scrollbar-track
{
	-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
	background-color: transparent;
}
#sticky::-webkit-scrollbar
{
	width: 10px;
	background-color: #F5F5F5;
}
#sticky::-webkit-scrollbar-thumb
{
	background-color: transparent;
	border: 0px;
}
::-webkit-input-placeholder { 
  color: #2d2d2d
}
::-moz-placeholder {
  color: #2d2d2d
}
:-ms-input-placeholder {
  color: #2d2d2d
}
:-moz-placeholder {
  color: #2d2d2d
}

/* end of memo */


/* 버튼 */
.animate {
	transition: all 0.1s;
	-webkit-transition: all 0.1s;
}

.action-button {
	position: relative;
	padding: 15px 50px;
  	margin: 0px 10px 10px 0px;
  	float: left;
	border-radius: 10px;
	font-family: 'Noto Serif KR', serif;
	font-size: 20px;
	color: #FFF;
	text-decoration: none;	
}

.blue {
	background-color: #3498DB;
	border-bottom: 5px solid #2980B9;
	text-shadow: 0px -2px #2980B9;
}
.action-button:active {
	transform: translate(0px,5px);
  -webkit-transform: translate(0px,5px);
	border-bottom: 1px solid;
}
#btnDiv1 {
	position: absolute;
    top: 110%;
    left: 660px;
}
/* end of 버튼 */


/* 에디터 */
#toolbar { 
  background: transparent;
  border:none;
  padding: 18px 0 24px
}

.ql-editor {
  /* padding: 10px 0 0 !important; */
  font-weight:300;
  color: #282625;
  
  border: 0px;
  min-width: 900px;
  max-width: 488px;
  max-height: 300px;
  background-color: transparent;
  color: #2d2d2d;
  font-family: 'Noto Serif KR', serif;
  font-size: 1.5em;
  line-height: 140%;
  outline: none;
}

.ql-container.ql-snow {
  border:none !important;
}
.ql-container {
	height: 90%;
	font-size: 16px;
}

/* dropdown */
.dropdown, .dropdown label, .dropdown ul, .dropdown li {
  margin: 0;
  padding: 0;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  outline: 0;
  -webkit-user-select: none;
}

.dropdown {
  position: relative;
  display: inline-block;
  vertical-align: middle;
  font-family: "Oswald";
  width: 180px;
  box-shadow: -1px 1px #fff, -3px 3px #000;
  z-index: 1;
}

.dropdown label {
  padding: 0.5em;
  display: block;
  font-size: inherit;
  padding-right: 2em;
  border: 2px solid #000;
  text-transform: uppercase;
  cursor: pointer;
  overflow: hidden;
  background: url("data:image/png;base64,R0lGODlhDwAUAIABAAAAAP///yH5BAEAAAEALAAAAAAPABQAAAIXjI+py+0Po5wH2HsXzmw//lHiSJZmUAAAOw==") no-repeat 94% center;
}

.dropdown ul {
  border: 2px solid #000;
  border-top: 0;
}

.dropdown ul li {
  list-style: none;
  padding: 0.5em;
  display: block;
  font-size: inherit;
  text-transform: uppercase;
  background: #fff;
  cursor: pointer;
  width: 100%;
}

.dropdown ul li:not(:last-of-type) {
  border-bottom: 2px solid #000;
}

.dropdown ul {
  position: absolute;
  left: -9999px;
}

/* 검색 */
#content {
  position: absolute;
  height: 70px;
  width: 300px;
  margin-left: 170px;
  top: 245px;
  left: 1250px;
  transform: translate(-50%, -50%);
}

#content.on {
  -webkit-animation-name: in-out;
  animation-name: in-out;
  -webkit-animation-duration: 0.7s;
  animation-duration: 0.7s;
  -webkit-animation-timing-function: linear;
  animation-timing-function: linear;
  -webkit-animation-iteration-count: 1;
  animation-iteration-count: 1;
}

.input {
  box-sizing: border-box;
  width: 30px;
  height: 30px;
  border: 4px solid #000000;
  border-radius: 50%;
  background: none;
  color: rgb(255 255 255 / 30%);
  font-size: 16px;
  font-weight: 400;
  font-family: Roboto;
  outline: 0;
  -webkit-transition: width 0.4s ease-in-out, border-radius 0.8s ease-in-out,
    padding 0.2s;
  transition: width 0.4s ease-in-out, border-radius 0.8s ease-in-out,
    padding 0.2s;
  -webkit-transition-delay: 0.4s;
  transition-delay: 0.4s;
  -webkit-transform: translate(-100%, -50%);
  -ms-transform: translate(-100%, -50%);
  transform: translate(-100%, -50%);
}

.search {
  background: none;
  position: absolute;
  top: -10px;
  left: -10px;
  height: 30px;
  width: 30px;
  padding: 0;
  border-radius: 100%;
  outline: 0;
  border: 0;
  color: inherit;
  cursor: pointer;
  -webkit-transition: 0.2s ease-in-out;
  transition: 0.2s ease-in-out;
  -webkit-transform: translate(-100%, -50%);
  -ms-transform: translate(-100%, -50%);
  transform: translate(-100%, -50%);
}

.search:before {
  content: "";
  position: absolute;
  width: 16px;
  height: 4px;
  background-color: #000;
  -webkit-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  transform: rotate(45deg);
  margin-top: 25px;
  margin-left: 17px;
  -webkit-transition: 0.2s ease-in-out;
  transition: 0.2s ease-in-out;
}

.close {
  -webkit-transition: 0.4s ease-in-out;
  transition: 0.4s ease-in-out;
  -webkit-transition-delay: 0.4s;
  transition-delay: 0.4s;
}

.close:before {
  content: "";
  position: absolute;
  width: 27px;
  height: 4px;
  top: 24px;
  margin-top: -1px;
  margin-left: -13px;
  background-color: #000;
  -webkit-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  transform: rotate(45deg);
  -webkit-transition: 0.2s ease-in-out;
  transition: 0.2s ease-in-out;
}

.close:after {
  content: "";
  position: absolute;
  width: 27px;
  height: 4px;
  background-color: #000;
  top: 24px;
  margin-top: -1px;
  margin-left: -13px;
  cursor: pointer;
  -webkit-transform: rotate(-45deg);
  -ms-transform: rotate(-45deg);
  transform: rotate(-45deg);
}

.square {
  box-sizing: border-box;
  padding: 0 40px 0 10px;
  width: 300px;
 /*  height: 50px; */
  border: 4px solid #000000;
  border-radius: 0;
  background: none;
  color: #000;
  font-family: Roboto;
  font-size: 16px;
  font-weight: 400;
  outline: 0;
  -webkit-transition: width 0.4s ease-in-out, border-radius 0.4s ease-in-out,
    padding 0.2s;
  transition: width 0.4s ease-in-out, border-radius 0.4s ease-in-out,
    padding 0.2s;
  -webkit-transition-delay: 0.4s, 0s, 0.4s;
  transition-delay: 0.4s, 0s, 0.4s;
  -webkit-transform: translate(-100%, -50%);
  -ms-transform: translate(-100%, -50%);
  transform: translate(-100%, -50%);
}

</style>
</head>

<body>

<div id="div1">
	<div id="div2">
		<div class='dropdown'>
  			<label>한눈에 모아보기</label>
  			<ul>
			    <li>한눈에 모아보기</li>
			    <li>달력으로 모아보기</li> 
			    <li>그래프로 모아보기</li>
			    <li>북마크로 모아보기</li>
			</ul>
		</div>
	</div>
	<div id="content">
		<input type="text" name="input" class="input" id="search-input">
		<button type="reset" class="search" id="search-btn"></button>
	</div>
</div><!-- div1 of end -->
<c:forEach items="${list}" var="memo">
<div draggable="true" id='sticky'>
		<p>${memo.memo_no}</p>
		<p>${memo.memo_name}</p>
		<p>${memo.memo_title}</p>
		<p><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${memo.memo_writedate}" /></p>
</div>
</c:forEach>

<!-- memo -->
<!-- Sticly note-->
<form name="formMod" method="post" action="">
  </form>

<button id="memoBtn"onclick="goModal()">dd</button>
<div id="myModal" class="modal">
<div draggable="true" id='stickyModal'>
  	<div id="toolbar">
    <span class="ql-formats">
          <select class="ql-font"></select>
          <select class="ql-size"></select>
        </span>
        <span class="ql-formats">
          <button class="ql-bold"></button>
          <button class="ql-italic"></button>
          <button class="ql-underline"></button>
          <button class="ql-strike"></button>
        </span>
        <span class="ql-formats">
          <select class="ql-color"></select>
          <select class="ql-background"></select>
        </span>
        <span class="ql-formats">
          <button class="ql-script" value="sub"></button>
          <button class="ql-script" value="super"></button>
        </span>
        <span class="ql-formats">
          <button class="ql-header" value="1"></button>
          <button class="ql-header" value="2"></button>
          <button class="ql-blockquote"></button>
        </span>
        <span class="ql-formats">
          <button class="ql-list" value="ordered"></button>
          <button class="ql-list" value="bullet"></button>
          <button class="ql-indent" value="-1"></button>
          <button class="ql-indent" value="+1"></button>
        </span>
        <span class="ql-formats">
          <button class="ql-direction" value="rtl"></button>
          <select class="ql-align"></select>
        </span>
        <span class="ql-formats">
          <button class="ql-link"></button>
          <button class="ql-image"></button>
          <button class="ql-video"></button>
        </span>
        <span class="ql-formats">
          <button class="ql-clean"></button>
        </span>
      </div>
  	<div id="quillEditor"></div>
  	<div>
  		<input type="radio" name="memo_open" id="memo_open" value="0" checked="checked"> 공개
  		<input type="radio" name="memo_open" id="memo_open" value="1"> 비공개
  	</div>
    <!-- <textarea id="speech" placeholder="여기, 오늘 당신의 메모를 적어보세요." 
			onfocus="this.placeholder = ''"
			onblur="this.placeholder = '여기, 오늘 당신의 메모를 적어보세요.'"></textarea> -->
	</div>
</div>	<!-- Modal of end -->



<input type="hidden" name="memo_contents" />
<input type="hidden" name="mem_no" id="mem_no" value="${login.mem_no}">
<input type="hidden" name="username" value="${username}">
<input type="hidden" name="memo_name" id="memo_name" value="${login.mem_name}">



<button id="searchMoreNotify" class="btn btn-outline-primary btn-block col-sm-10 mx-auto">더 보기</button>
<!-- end of memo -->


<script>

// 모달 이동
function goModal() {
	$('#myModal').show();
};
//팝업 Close 기능
function close_pop(flag) {
	$('#myModal').hide();
};


$(function() {
	// 메모 이동
	$("#sticky").draggable();
	
	document.getElementById("memoBtn").onclick = function() {
	    document.getElementById("myModal").style.display="block";
	}

	/* document.getElementById("memoBtn").onclick = function() {
	    document.getElementById("myModal").style.display="none";
	}  */  
	
	
	// 더보기
/* 	$("#sticky").slice(0, 10).show(); // select the first ten
    $("#load").click(function(e){ // click event for load more
        e.preventDefault();
        $("#sticky:hidden").slice(0, 10).show(); // select next 10 hidden divs and show them
        if($("#sticky:hidden").length == 0){ // check if any hidden divs still exist
            alert("No more divs"); // alert if there are none left
        }
    }); */
	
	
})

</script>
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<script>

//memo_contents를 담으려고 선언한 변수
	var memo_con = "";
	
	// quill api 사용
	var quill = new Quill('#quillEditor', {
	theme: 'snow',
	placeholder: '여기, 오늘 당신의 메모를 적어보세요.',
	formats : 'Block',
	modules: {
	  toolbar: '#toolbar'
	}
	});
	
	quill.on('text-change', function() {
	    var delta = quill.getContents();
	    var text = quill.getText();
	    var justHtml = quill.root.innerHTML;
	
	    memo_con = $('input[name="memo_contents"]').val(JSON.stringify(justHtml));
	
	    console.log(JSON.stringify(delta['ops']));
	
	  });
	
	 function addHTML() {
		    var range = quill.getSelection(!quill.hasFocus()); 
		    if (range) {
		      quill.pasteHTML(range.index + range.length, "<br>" + range.index + "&mdash;" + range.length);
		    }
	}
	 
	 
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

// search
const input = document.getElementById("search-input");
const searchBtn = document.getElementById("search-btn");

const expand = () => {
  searchBtn.classList.toggle("close");
  input.classList.toggle("square");
};

searchBtn.addEventListener("click", expand);

</script>
<script>

// 페이징
$(document).ready(function(){
	// 읽은 알림 총 갯수
	var oldListCnt = '${listCount}';
	console.log("oldListCnt: " + oldListCnt);
	// 조회 인덱스
	var startIndex = 1;	// 인덱스 초기값
	var searchStep = 5;	// 5개씩 로딩
	
	// 페이지 로딩 시 첫 실행
	readOldNotify(startIndex);
	
	// 더보기 클릭시
	$('#searchMoreNotify').click(function(){
		startIndex += searchStep;
		readOldNotify(startIndex);
	})
	
	// 더보기 실행함수 **
	function readOldNotify(index){
		var mem_no = $('#mem_no').val();
		console.log("???: "+mem_no);
		var _endIndex = index+searchStep-1;	// endIndex설정
		$.ajax({
			type: "post",
			async: "true",
			dataType: "json",
			data: {
				mem_no: mem_no,
				startIndex: index,
				endIndex: _endIndex,
			},
			url: "${contextPath}/mymemo/searchMoreNotify",
			success: function (data, textStatus) {
				console.log("ddd"+data);
				var NodeList = "";
				for(i = 0; i < data.length; i++){
					let newNode = "<div style='display: none;' id='sticky'>";
					newNode += "<p>"+data[i].memo_no+"</p>"
					newNode += "<p>"+data[i].memo_name+"</p>"
					newNode += "<p>"+data[i].memo_title+"</p>"
					newNode += "<p>"+data[i].memo_writedate+"</p>"
					NodeList += newNode;
				}
				$(NodeList).appendTo($("#sticky")).slideDown();

				// 더보기 버튼 삭제
				if(startIndex + searchStep > oldListCnt){
					$('#searchMoreNotify').remove();
				}				
			},error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           }

		});
	}
});

</script>


</body>
</html>