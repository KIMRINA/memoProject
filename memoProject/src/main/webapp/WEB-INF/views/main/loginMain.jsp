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


/* ?????? */
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
/* end of ?????? */


/* ????????? */
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
  	<div id="quillEditor"></div>
  	<div>
  		<input type="radio" name="memo_open" id="memo_open" value="0" checked="checked"> ??????
  		<input type="radio" name="memo_open" id="memo_open" value="1"> ?????????
  	</div>
    <!-- <textarea id="speech" placeholder="??????, ?????? ????????? ????????? ???????????????." 
			onfocus="this.placeholder = ''"
			onblur="this.placeholder = '??????, ?????? ????????? ????????? ???????????????.'"></textarea> -->
</div>

<!-- ????????? ????????? -->
<sec:authorize access="isAuthenticated()">
<div id="btnDiv1">
	<a href="#" class="action-button shadow animate blue" onclick="goCreate(mem_no, username, memo_name, memo_open)">????????????</a>
</div>
</sec:authorize>

<input type="hidden" name="memo_contents" />
<input type="hidden" name="mem_no" id="mem_no" value="${login.mem_no}">
<input type="hidden" name="username" value="${username}">
<input type="hidden" name="memo_name" id="memo_name" value="${login.mem_name}">


  </form>
<!-- end of memo -->
  



<script>
	
	$(function() {
		// ?????? ??????
		//$("#sticky").draggable();
	})
	
</script>

<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<script>
	
	// memo_contents??? ???????????? ????????? ??????
	var memo_con = "";

	// quill api ??????
   var quill = new Quill('#quillEditor', {
    theme: 'snow',
    placeholder: '??????, ?????? ????????? ????????? ???????????????.',
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
	    console.log("memocon: "+memo_con);

	    console.log(JSON.stringify(delta['ops']));

	  });
   
/*    quill.getModule('toolbar').addHandler('image', function() {
       selectLocalImage();
   });
   

   // ??? ????????? ????????????

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
  
  // a?????? ???????????? post ???????????? ?????????
    function goCreate(mem_no, username, memo_name, memo_open){
	  var f=document.formMod; //??? name
	  f.mem_no = mem_no; //POST???????????? ????????? ?????? ???
	  f.username = username; //POST???????????? ????????? ?????? ???
	  f.memo_name = memo_name;//POST???????????? ????????? ?????? ???
	  f.memo_contents = memo_con;//POST???????????? ????????? ?????? ???
	  f.memo_open = memo_open;//POST???????????? ????????? ?????? ???
	  
	  f.action="/main/memoCreate";//????????? ?????????
	  f.method="post";//POST??????
	  f.submit();
}

</script>
</body>
</html>