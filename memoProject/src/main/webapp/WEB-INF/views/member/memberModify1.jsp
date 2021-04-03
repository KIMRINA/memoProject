<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMOZZANG 회원정보 수정-비밀번호 확인</title>
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
	height: 300px;
	position: relative;
    top: -30%;

}
#p3 {
	position: relative;
    top: 10%;
    left: 40%;
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
	position: relative;
    top: 500px;
    left: 360px;
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
  content:"확인";
  position:absolute;
  width:100%;
  height:100%;
  left:0;
  text-align:center;
  -webkit-transition: all 400ms cubic-bezier(0.680, -0.550, 0.265, 1.550); 
}

.slide:before {
  content:"회원정보 수정으로 →";
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

<form name="frmMod" action="/member/memberModify3" method = 'get'>
<div>
	<div id="div1">
		<p id="p1" style="font-size: 30pt;"><strong>회원정보수정</strong></p>
		<div id="div2">
		</div>
		<div id="div3">
			<p id="p3"><b>비밀번호 확인</b></p>
			<hr id="hr1">
			<p id="p4"><b>회원님의 정보를 보호하기 위해<br>비밀번호를 다시 확인합니다.</b></p>
			<sec:authentication property="principal.username" var="username"/>
			<input type = 'hidden' name = 'username' id="username" value = '${username}'>
			<input type="password" name = 'password' id="password" class="login-input" placeholder="PASSWORD" />
			<span class="label label-danger">${pwCheck}</span>
			<input type = "hidden" name = "${_csrf.parameterName }" value = "${_csrf.token }"/>
		</div>
	</div>
</div>
</form>
		<div id="div4">
			<button id="btn1" class="slide">&nbsp;</button>
		</div>


<script>

$(document).ready(function(){	// docu 

 // 비번 중복 검사
$("#btn1").click(function() {	// onclick
	var username =$("#username").val();
	var password =$("#password").val();
	console.log(username);
	console.log(password);
		
	$.ajax({
		url : '${pageContext.request.contextPath}/member/memberModPwCheck?username='+username+'&password='+password,
		type : 'post',
		dateType : "json",
		data : $("#frmMod").serializeArray(),
		success : function(data) {
			console.log("mod: "+ data);							
			if (data==true) {
				console.log("비밀번호 일치");	
				$("#frmMod").submit();
				location.href="${pageContext.request.contextPath}/member/memberModify3";
			} else {
				alert("패스워드가 틀렸습니다.");
				return;
			}
		}, error : function() {
			console.log("실패");
		}
	});
});


});	// end of script function

</script>

</body>
</html>