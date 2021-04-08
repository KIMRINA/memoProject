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
<title>MEMOZZANG 메모수정</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<meta name="author" content="www.twitter.com/cheeriottis">

<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

<style>

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

</style>

</head>
<body>

<!-- memo -->
<!-- Sticly note-->
<form name="formMod" method="post" action="/mymemo/mymemoModify">
<div draggable="true" id='sticky'>
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
  	<div id="quillEditor">
  		${modify.memo_contents}
  	</div>
  	<div>
  		<input type="radio" name="memo_open" id="memo_open" value="0" <c:if test="${modify.memo_open=='0'}">checked="checked"</c:if>> 공개
  		<input type="radio" name="memo_open" id="memo_open" value="1"<c:if test="${modify.memo_open=='1'}">checked="checked"</c:if>> 비공개
  	</div>
    <!-- <textarea id="speech" placeholder="여기, 오늘 당신의 메모를 적어보세요." 
			onfocus="this.placeholder = ''"
			onblur="this.placeholder = '여기, 오늘 당신의 메모를 적어보세요.'"></textarea> -->
</div>

<!-- 로그인 했을때 -->
<sec:authorize access="isAuthenticated()">
<div id="btnDiv1">
	<a href="#" class="action-button shadow animate blue" id="btnGo">메모등록</a>
	<!-- <button>메모등록</button> -->
</div>
</sec:authorize>

<!-- <input type="hidden" name="memo_contents" /> -->
<input type="hidden" name="mem_no" id="mem_no" value="${login.mem_no}">
<input type="hidden" name="username" value="${username}">
<input type="hidden" name="memo_name" id="memo_name" value="${login.mem_name}">
<input type="hidden" name="memo_no" id="memo_no" value="${modify.memo_no}">
<input type="hidden" id="memo_contents" name="memo_contents">


  </form>
<!-- end of memo -->



<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<script>
	
	// memo_contents를 담으려고 선언한 변수
	var memo_con = "";
	//var memo_con = document.getElementById('memo_contents');
	
	
		// memo 하나 읽기 ajax
	var memo_no = $('#memo_no').val();
	var dataCon = "";
	console.log("memo_no: "+memo_no);
	
	$.ajax({
		url : '${pageContext.request.contextPath}/mymemo/readOneMemo?memo_no='+ memo_no,
		type : 'get',
		async: "true",
		dataType: "json",
		data: {
			memo_no: memo_no,
		},
		success : function(data, textStatus) {
			console.log("readMemo : "+ JSON.stringify(data));
			
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
				    
				    //memo_con.innerHTML = JSON.stringify(text);

				    memo_con = $('input[name="memo_contents"]').val(JSON.stringify(justHtml));
				    dataCon = data.memo_contents
				    console.log("data.memo_contents: "+data.memo_contents);
				    

				    console.log(JSON.stringify(delta['ops']));

				  });
			   
			// a태그 사용해서 post 방식으로 넘기기
			   $("#btnGo").click(function() {
				  console.log("memo_no: "+memo_no);
				  console.log("memo_con: "+memo_con);
				  console.log("memo_open: "+memo_open);
				  
				  var f=document.formMod; //폼 name
				  f.memo_contents = memo_con;//POST방식으로 넘기고 싶은 값
				  f.memo_open = memo_open;//POST방식으로 넘기고 싶은 값
				  
				  f.action="/mymemo/mymemoModify";//이동할 페이지
				  f.method="post";//POST방식
				  f.submit();
			    });
			
				
			
		},error:function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
	});

	
   
   





/*    quill.getModule('toolbar').addHandler('image', function() {
       selectLocalImage();
   });
   

   // 퀼 이미지 콜백함수

   function selectLocalImage() {
       const input = document.createElement('input');
       input.setAttribute('type', 'file');
       input.click();

       // Listen upload local image and save to server
       input.onchange = function() {
           const fd = new FormData();
           const file = $(this)[0].files[0];
           fd.append('image', file);
           console.log("fd: "+fd+"file: "+file);

           $.ajax({
               type: 'post',
               enctype: 'multipart/form-data',
               url: '/uploadAjax',
               data: fd,
               processData: false,
               contentType: false,
               beforeSend: function(xhr) {
            	   if(header) {
            	   var header = xhr.setRequestHeader($("#_csrf_header").val(), $("#_csrf").val());
            	   }
               },
               success: function(data) {
                   const range = quill.getSelection();
                   quill.insertEmbed(range.index, 'image', 'http://localhost/uploadAjax/'+data);
               },
               error: function(err) {
                   console.error("Error ::: "+err);
               }
           });
       };
   } 
   */
  
  function addHTML() {
    var range = quill.getSelection(!quill.hasFocus()); 
    if (range) {
      quill.pasteHTML(range.index + range.length, "<br>" + range.index + "&mdash;" + range.length);
    }
  }
  
  

</script>
</body>
</html>