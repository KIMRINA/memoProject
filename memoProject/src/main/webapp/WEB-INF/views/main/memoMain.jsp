<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemozzangMain</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<meta name="author" content="www.twitter.com/cheeriottis">

<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Raleway:300,400' rel='stylesheet' type='text/css'>

<style>
  /* The Modal (background) */
  .modal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 1; /* Sit on top */
      left: 0;
      top: 0;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  }

  /* Modal Content Box */
  .modal-content {
      background-color: rgb(255 255 255 / 80%);
      margin: 15% auto; /* 15% from the top and centered */
      padding: 20px;
      border: 1px solid #888;
      width: 600px;
      position: relative;                         
  }
  
  /* 모달 박스 안 수정 */
  #p1 {
  	line-height: 1.5;
  	position: relative;
    left: 60px;
  }
  #div1 {
  	text-align: center;
  	background-color:#b7c7c3;
  	padding-bottom: 25px;
  	padding-top: 25px;
  	position: relative;
    top: 30px;
  }
  #div2 {
  	cursor:pointer;
  	background-color:#b7b7b7;
  	text-align: center;
  	padding-bottom: 10px;
  	padding-top: 10px;
  	position: relative;
    height: 40px;
    top: -20px;
  }
  #div2:hover {
  	background-color:#97cfc2;
  }
  
  
  /* 버튼 */
#btn1 {
  position: relative;
  left: 170px;
  height: 45px;
  width: 200px;
  margin: 10px 7px;
  padding: 5px 5px;
  font-weight: 700;
  font-size: 15px;
  letter-spacing: 2px;
  color: #383736;
  border: 2px #383736 solid;
  border-radius: 4px;
  text-transform: uppercase;
  outline: 0;
  overflow:hidden;
  z-index: 1;
  cursor: pointer;
  transition:         0.08s ease-in;
  -o-transition:      0.08s ease-in;
  -ms-transition:     0.08s ease-in;
  -moz-transition:    0.08s ease-in;
  -webkit-transition: 0.08s ease-in;
}
.slide:after{
  content:"가입하기";
  position:absolute;
  width:100%;
  height:100%;
  left:0;
  text-align:center;
  -webkit-transition: all 400ms cubic-bezier(0.680, -0.550, 0.265, 1.550); 
}

.slide:before {
  content:"일반 회원가입 →";
  height:100%;
  width:100%;
  position:absolute;
  color:#383736;
  text-align: center;
  left:-100%;
  opacity: 0;
  -webkit-transition: all 500ms cubic-bezier(0.680, -0.550, 0.265, 1.550); 
}

.slide:hover{
  background:#383736;
}
.slide2:hover{
  background:#fafd5a;
}
.slide3:hover{
  background:#ff2929;
}

.slide:hover:before, .slide3:hover:before{
  left:0;
  opacity:1;
  color:#fff;
}
.slide2:hover:before {
	left:0;
	opacity:1;
}

.slide:hover:after, .slide2:hover:after, .slide3:hover:after{
  left:100%;
  opacity:0;
}

#btn2 {
  position: relative;
  left: -50px;
  height: 45px;
  width: 200px;
  margin: 10px 7px;
  padding: 5px 5px;
  font-weight: 700;
  font-size: 15px;
  letter-spacing: 2px;
  color: #383736;
  border: 2px #383736 solid;
  border-radius: 4px;
  text-transform: uppercase;
  outline: 0;
  overflow:hidden;
  z-index: 1;
  cursor: pointer;
  transition:         0.08s ease-in;
  -o-transition:      0.08s ease-in;
  -ms-transition:     0.08s ease-in;
  -moz-transition:    0.08s ease-in;
  -webkit-transition: 0.08s ease-in;
}
#btn3 {
  position: relative;
  left: 50px;
  height: 45px;
  width: 200px;
  margin: 10px 7px;
  padding: 5px 5px;
  font-weight: 700;
  font-size: 15px;
  letter-spacing: 2px;
  color: #383736;
  border: 2px #383736 solid;
  border-radius: 4px;
  text-transform: uppercase;
  outline: 0;
  overflow:hidden;
  z-index: 1;
  cursor: pointer;
  transition:         0.08s ease-in;
  -o-transition:      0.08s ease-in;
  -ms-transition:     0.08s ease-in;
  -moz-transition:    0.08s ease-in;
  -webkit-transition: 0.08s ease-in;
}
.slide2:after{
  content:"카카오로 가입하기";
  position:absolute;
  width:100%;
  height:100%;
  left:0;
  text-align:center;
  -webkit-transition: all 400ms cubic-bezier(0.680, -0.550, 0.265, 1.550); 
}
.slide3:after{
  content:"구글로 가입하기";
  position:absolute;
  width:100%;
  height:100%;
  left:0;
  text-align:center;
  -webkit-transition: all 400ms cubic-bezier(0.680, -0.550, 0.265, 1.550); 
}

.slide2:before, .slide3:before {
  content:"가입하기 →";
  height:100%;
  width:100%;
  position:absolute;
  color:black;
  text-align: center;
  left:-100%;
  opacity: 0;
  -webkit-transition: all 500ms cubic-bezier(0.680, -0.550, 0.265, 1.550); 
}


/* memo */
#sticky {
  position: relative;
  background-color: #c6f1e7; 
  display: inline-block;
  padding: 20px;
  top: 70px;
  width: 900px;
  height: 400px;
}
#sticky:hover {
  background-color: #97cfc2;
}
#sticky textarea {
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
    left: 45%;
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

</style>

</head>
<body>

<!-- memo -->
<!-- Sticly note-->
<form name="formMod" method="post" action="/main/memoCreate">
<div draggable="true" id='sticky' class="notepad">
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
  	<div id="speech"></div>
  	<div>
  		<input type="radio" name="memo_open" value="0"> 공개
  		<input type="radio" name="memo_open" value="1"> 비공개
  	</div>
    <!-- <textarea id="speech" placeholder="여기, 오늘 당신의 메모를 적어보세요." 
			onfocus="this.placeholder = ''"
			onblur="this.placeholder = '여기, 오늘 당신의 메모를 적어보세요.'"></textarea> -->
</div>

  </form>
<!-- end of memo -->
  


<!-- 회원가입 모달 -->
<!-- 로그인 안했을때 -->
<sec:authorize access="isAnonymous()">
<div id="btnDiv1">
	<a href="#" class="action-button shadow animate blue" onclick="goModal()">메모등록</a>
</div>
<!-- <button onclick="goModal()">메모등록</button> -->
<!-- The Modal -->
    <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
      	<p><span style="font-size: 14pt;"><b><span style="font-size: 21pt;">메모를 작성하시려면</span></b></span></p>
      	<p><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">회원가입이 필요합니다</span></b></span></p>
      	<div style="background-color:#b7c7c3;padding-bottom: 10px;padding-top: 10px;">
      		<p id="p1"><b><span style="font-size: 16pt;">일반회원가입</span></b><button id="btn1" class="slide" onclick="goJoin()">&nbsp;</button></p>
      	</div>
        <div id="div1">
      		<p style="text-align: center; line-height: 1.5;"><b><span style="font-size: 16pt;">소셜회원가입</span></b></p>
      		<button id="btn2" class="slide2" >&nbsp;</button><button id="btn3" class="slide3" >&nbsp;</button>
      	</div>
        <p style="text-align: center; line-height: 1.5;"><b><span style="color: rgb(255, 0, 0); font-size: 14pt;"></span></b></p>
        <p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;"><br /></span></p>
        <p><br /></p>
       <div id="div2" onClick="close_pop();">
       	<span class="pop_bt" style="font-size: 13pt;position: relative;top: 20%;">닫기</span>
      </div>
      </div>
 
    </div>
</sec:authorize>
        <!--End Modal-->






<script>

	// 모달 이동
	function goModal() {
		$('#myModal').show();
	};
	//팝업 Close 기능
	function close_pop(flag) {
		$('#myModal').hide();
	};
	
	
	// 회원가입 이동
	function goJoin() {
		window.location.href = "/member/memberJoin1";
	};
	
	function goCreate() {
		form.action = "/main/memoCreate";
		form.submit = "";
		//$('#formMod').submit();
		//location.href="${pageContext.request.contextPath}/main/memoCreate";
	}
	
	$(function() {
		
		// 메모 이동
		//$("#sticky").draggable();
	})
	
</script>

<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<script>
  var quill = new Quill('#speech', {
    theme: 'snow',
    placeholder: '여기, 오늘 당신의 메모를 적어보세요.',
    formats : 'Block',
    modules: {
      toolbar: '#toolbar'
    }
  });

  function addHTML() {
    var range = quill.getSelection(!quill.hasFocus()); 
    if (range) {
      quill.pasteHTML(range.index + range.length, "<br>" + range.index + "&mdash;" + range.length);
    }
  }
  
	//폼(input)에 자동저장
  quill.on('text-change', function() {
    var delta = quill.getContents();
    var text = quill.getText();
    var justHtml = quill.root.innerHTML;

    $('input[name="memo_contents"]').val(JSON.stringify(justHtml));

    console.log(JSON.stringify(delta['ops']));

  });

</script>

</body>
</html>