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
<title>MEMOZZANG 회원탈퇴</title>
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
	height: 400px;
	position: relative;
    top: -30%;

}
#div4 {
	background-color: rgba( 255, 255, 255, 0.5 );
	height: 180px;
	position: relative;
    top: -30%;

}
#hr1 {
	width: 90%;
    position: relative;
    top: 8%;
}
#p3 {
	position: relative;
    top: 7.5%;
    text-align: center;
    font-size: 15pt;
}
#p3_1 {
	position: relative;
    top: 30px;
    left: 40px;
    color: darkblue;
}
#p3_2 {
	position: relative;
    top: 17px;
    left: 60px;
    width: 550px;
}
#p3_3 {
	position: relative;
    top: 20px;
    left: 40px;
    color: darkblue;
}

#p4 {
	position: relative;
    top: 17%;
    font-size: 14pt;
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
  content:"확인";
  position:absolute;
  width:100%;
  height:100%;
  left:0;
  text-align:center;
  -webkit-transition: all 400ms cubic-bezier(0.680, -0.550, 0.265, 1.550); 
}

.slide:before {
  content:"회원탈퇴→";
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
  top: 17%;
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

/* 테이블 */
table{
  	border: 2px solid #c6f1e7;
    width: 90%;
    position: relative;
    top: 20px;
    left: 34px;
    text-align: center;
}

.blue{
  border:2px solid #c6f1e7;
}

.blue thead{
  background:#c6f1e7;
}
th,td{
  padding:5px 0;
}

tbody tr:nth-child(even){
  background:#cce4df8a;
}

tbody tr:hover{
background:#96ead7;
  color:#FFFFFF;
}


</style>
</head>
<body>

<form id="frmMod" action="/member/memberDelete" method = 'post'>
<div>
	<div id="div1">
		<p id="p1" style="font-size: 30pt;"><strong>회원탈퇴</strong></p>
		<div id="div2">
		</div>
		<div id="div3">
			<p id="p3"><b>memozzang 탈퇴 신청 전, 아래 사항을 반드시 읽어주십시오.</b></p>
			<hr id="hr1">
			<p id="p3_1">1. 기존 아이디로 재가입이 불가능 합니다.</p>
			<p id="p3_2">회원 탈퇴를 신청하시면 해당 아이디는 즉시 탈퇴 처리되며, 이후 영구적으로 사용이 중지되므로 새로운 아이디로만 재가입이 가능 합니다.
			</p>
			<p id="p3_3">2. 회원 정보 및 게시물 삭제</p>
			<table class="blue">
				<thead>
				<tr>
			      <th>내용</th>
			      <th>기간</th>
    			</tr>
    			</thead>
    			<tbody>
    			<tr>
			      <td>계약 또는 청약철회 등에 관한 기록</td>
			      <td>5년</td>
    			</tr>
    			<tr>
			      <td>대금결제 및 재화 등의 공급에 관한 기록</td>
			      <td>5년</td>
    			</tr>
    			<tr>
			      <td>소비자의 불만 또는 분쟁처리에 관한 기록</td>
			      <td>5년</td>
    			</tr>
    			</tbody>
			</table>
		</div>
		<div id="div4">
			<p id="p4">위 탈퇴 정책을 확인하였으며, 내용에 동의합니다.</p>
			<sec:authentication property="principal.username" var="username"/>
			<input type = 'hidden' name = 'username' id="username" value = '${username}'>
			<input type="password" name = 'password' id="password" class="login-input" placeholder="PASSWORD" />
			<span class="label label-danger">${pwCheck}</span>
			<input type = "hidden" name = "${_csrf.parameterName }" value = "${_csrf.token }"/>
		</div>
		<div id="div5" style="text-align: center; margin: -2%;">
			<button id="btn1" class="slide">&nbsp;</button>
		</div>
	</div>
</div>
</form>

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
				//location.href="${pageContext.request.contextPath}/member/memberDelete2";
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