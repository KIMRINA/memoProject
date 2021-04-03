<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMOZZANG 회원가입-가입완료</title>
<style>

#div1 {
	position: absolute;
    top: 40%;
    left: 450px;
    width: 650px;
    height: 100px;
}
#div2 {
	position: absolute;
    top: 50px;
    left: 330px;
}

#p2 {
	font-size: 13pt;
}
#div3 {
	background-color: rgba( 255, 255, 255, 0.5 );
	height: 200px;
	position: relative;
    top: -30%;
	text-align: center;
}
#p3 {
	position: relative;
    top: 35%;
    font-size: 15pt;
}
#div4 {
	text-align: center;
}

/* 홈으로가기 버튼 */
#btn1 {
  position: relative;
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
  content:"로그인하러 가기";
  position:absolute;
  width:100%;
  height:100%;
  left:0;
  text-align:center;
  -webkit-transition: all 400ms cubic-bezier(0.680, -0.550, 0.265, 1.550); 
}

.slide:before {
  content:"MEMOZZANG →";
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
.slide:hover:before{
  left:0;
  opacity:1;
  color:#fff;
}
.slide:hover:after{
  left:100%;
  opacity:0;
}

</style>
</head>
<body>

<div>
	<div id="div1">
		<p id="p1" style="font-size: 30pt;"><strong>회원가입</strong></p>
		<div id="div2">
			<p id="p2">1. 약관동의&nbsp;|&nbsp;2. 정보 입력&nbsp;|&nbsp;<strong>3. 가입 완료</strong></p>
		</div>
		<div id="div3">
			<p id="p3"><b>회원가입이 완료되었습니다<br>
			홈으로 가셔서 메모를 적어보세요!</b></p>
		</div>
		<div id="div4">
			<button id="btn1" class="slide" onclick="goLogin()">&nbsp;</button>
		</div>
	</div>
</div>


<script>
// main 이동
function goLogin() {
	window.location.href = "/member/customLogin";
};
</script>

</body>
</html>