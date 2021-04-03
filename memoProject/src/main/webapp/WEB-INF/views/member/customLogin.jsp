<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMOZZANG LOGIN</title>
<style>

#div1 {
	position: absolute;
    top: 40%;
    left: 450px;
    width: 650px;
    height: 100px;
}
#p2 {
	font-size: 13pt;
	color:red;
	position: relative;
    top: 30px;
}
#div3 {
	background-color: rgba( 255, 255, 255, 0.5 );
	height: 300px;
	position: relative;
    top: -30%;
	text-align: center;
}
#p3 {
	position: relative;
    top: 170px;
}
#div4 {
	text-align: center;
}
#loginForm {
	position: relative;
    top: -30%;
}
#div3_login{
	position: absolute;
    top: 70px;
    left: -10px;
    width: 700px;
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

/* 로그인 */
/* Inputs */
.login-input {
  position: relative;
  width: 50%;
  top: 15%;
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
		<p id="p1" style="font-size: 30pt;"><strong>로그인</strong></p>
		<form method = 'post' action = "/login" id="loginForm">
			<div id="div3">
				<p id="p2"><strong><c:out value = "${error}"/></strong><strong><c:out value = "${logout}"/></strong></p>
				<div id="div3_login">
					<input type = 'text' name = 'username' class="login-input" placeholder="EMAIL ID" value = 'member2@1'>
					<input type = 'password' name = 'password' class="login-input" placeholder="PASSWORD" value = '1'>
				</div>
				<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
				    <font color="red">
				        <p id="p3">Your login attempt was not successful due to <br/>
				            ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</p>
				        <c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
				    </font>
				</c:if>
			</div>
			<div id="div4">
				<button id="btn1" class="slide">&nbsp;</button>
				<input type = "hidden" name = "${_csrf.parameterName }" value = "${_csrf.token }"/>
			</div>
		</form>
	</div>
</div>




</body>
</html>