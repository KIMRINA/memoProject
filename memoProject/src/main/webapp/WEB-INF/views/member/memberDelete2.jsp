<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMOZZANG 회원탈퇴 완료</title>
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
}
#p3 {
	position: relative;
    top: 36%;
    text-align: center;
    font-size: 15pt;
}
#hr1 {
	width: 90%;
    position: relative;
    top: 8%;
}
#p4 {
	position: relative;
    top: 9%;
    font-size: 15pt;
    text-align: center;
}
#div4 {
	text-align: center;
}


/* 동의하기 버튼 */
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
  content:"홈으로 가기";
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


/* Inputs */
.login-input {
  position: relative;
  width: 50%;
  top: 15%;
  left: 26%;
  padding: 10px 5px;
  margin: 0 0 25px 0;
  border: none;
  border-bottom: 2px solid rgba(0, 0, 0, 0.2);
  box-sizing: border-box;
  background: transparent;
  font-size: 1rem;
  font-family: 'Roboto', sans-serif;
  font-weight: 500;
  opacity: 1;
  animation: input_opacity 0.8s cubic-bezier(.55, 0, .1, 1);
  transition: border-bottom 0.2s cubic-bezier(.55, 0, .1, 1);
}

.login-input:focus {
  outline: none;
  border-bottom: 2px solid #E37F00;
}

</style>
</head>
<body>

<div>
	<div id="div1">
		<p id="p1" style="font-size: 30pt;"><strong>회원탈퇴</strong></p>
		<div id="div3">
			<p id="p3"><b>탈퇴가 완료되었습니다<br>
						그동안 memozzang을 이용해주셔서 감사합니다</b></p>
		</div>
		<div id="div4">
			<button id="btn1" class="slide" onclick="goMain()">&nbsp;</button>
		</div>
	</div>
</div>


<script>
// main 이동
function goMain() {
	window.location.href = "/main/memoMain";
};
</script>

</body>
</html>