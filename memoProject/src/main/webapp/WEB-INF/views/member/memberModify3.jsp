<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMOZZANG 회원정보 수정</title>
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
	height: 480px;
	position: relative;
    top: -30%;
}

.form-control {
	width: 625px;
	height: 30px;
}
.form-control2 {
	width: 560px;
	height: 30px;
}
.table {
	position: relative;
    top: 20px;
    left: 10px;
}


/* 회원가입 버튼 */
#reg_submit {
	position: absolute;
    top: 103%;
    left: 36%;
    
  height: 45px;
  width: 150px;
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
#reg_submit:disabled {
	color: #bcbcbc;
  border: 2px #bcbcbc solid;
  cursor: not-allowed;
}
#reg_submit:hover{
  background:#383736;
  color:white;
}
#reg_submit:hover:before{
  left:0;
  opacity:1;
  color:#fff;
}
#reg_submit:hover:after{
  left:100%;
  opacity:0;
}
</style>
</head>
<body>

<div>
	<div id="div1">
		<p id="p1" style="font-size: 30pt;"><strong>회원정보수정</strong></p>
		<div id="div2">
		</div>
	
   		<div id="div3">
            <form name="formMod" method="post" action="/member/memberMod" onSubmit="return CheckForm(this)">
                <table class="table">
                    <tr>
						<td>
							<b>이메일</b>
						</td>
					</tr>
					<tr>
						<td id="td2">
							<sec:authentication property="principal.username" var="username"/>
							<input type="email" id="email_id" name="username" value = '${username}' class="form_w200" style="width: 625px;height: 30px;" readonly />
						</td>
					</tr>
 
                    <tr>
                        <td><b>비밀번호</b></td>
                    </tr>
                    <tr>
                    	<td>
                        	<input type="password" id="mem_pw" name="password" class="form-control" placeholder="비밀번호" />
                        </td> 
                    </tr>
                    <tr>
						<td>
							<p id="pwCheckF" style="color: #FF6600; margin: 0;"></p>
						</td>
					</tr>
 
                    <tr>
                        <td><b>비밀번호확인</b></td>
                    </tr>
                    <tr>
                    	<td><input type="password" id="mem_pw_check" name="pwCheck" class="form-control" placeholder="비밀번호 확인" />
                    </tr>
                    <tr>
						<td>
							<p id="pwCheckFF" style="color: #FF6600; margin: 0;"></p>
						</td>
					</tr>
 
                    <tr>
                        <td><b>닉네임</b></td>
                    </tr>
                    <tr>
                    	<td>
                    		<input type="text" id="mem_name" name="mem_name" value="${login.mem_name}" class="form-control" />
                    	</td>
                    </tr>
 
                    <tr>
                        <td><b>휴대폰번호</b></td>
                    </tr>
                    <tr>
                    	<td>
                    		<input type="text" id="mem_phone" name="mem_phone" value="${login.mem_phone}" class="form-control" /> <br>
                        </td>
                    </tr>
                    <tr>
						<td>
							<p id="phoneCheckFF" style="color: #FF6600; margin: 0;"></p>
						</td>
					</tr>
 
                    <tr>
                        <td><b>성별</b></td>
                    </tr>
                    <tr>
                    	<td>
                        	<input type="radio" name="mem_gender" value="1" <c:if test="${login.mem_gender=='1'}">checked="checked"</c:if>>남&emsp;
         					<input type="radio" name="mem_gender" value="0" <c:if test="${login.mem_gender=='0'}">checked="checked"</c:if>>여
                        </td>
                    </tr>
 
                    <tr>
                        <td>
                        	<input type = "hidden" name = "${_csrf.parameterName }" value = "${_csrf.token }"/>
                        	<input type = "hidden" name = "authorities" value = "ROLE_MEMBER"/>
                        	
                        	<input type="submit" id="reg_submit" value="회원수정">
                        </td>
                    </tr>
 
                </table>
            </form>
 
    	</div>	<!-- end of div3 -->
	</div>	<!-- end of div1 -->
</div>

<script>
var pw_rule = /^[A-Za-z0-9]{4,12}$/;	// 비밀번호 정규식
var phone_rule = /^\d{3}-\d{3,4}-\d{4}$/;	// 폰번호 정규식


$(document).ready(function(){
	
	// 비밀번호 유효성 체크
	$('#mem_pw').keyup(function(){
		$('#pwCheckFF').text('');
	}); 
	$('#mem_pw_check').keyup(function(){
		if($('#mem_pw').val()!=$('#mem_pw_check').val()){
			$('#pwCheckFF').text('');
	  		$('#pwCheckFF').html("패스워드 확인이 불일치 합니다");
	 	} else if(!pw_rule.test($('#mem_pw').val())) {
	 		$('#pwCheckFF').text('');
		  	$('#pwCheckFF').html("패스워드는 4자부터 12자까지 사용가능합니다");
	 	} else{
		  	$('#pwCheckFF').text('');
		  	$('#pwCheckFF').html("<font color='blue'>패스워드 확인이 일치 합니다.</font>");
	 	}
	});
	
	
	// 휴대폰번호 유효성 체크
	$('#mem_phone').keyup(function(){
		if(!phone_rule.test($('#mem_phone').val())){
			$('#phoneCheckFF').text('');
	  		$('#phoneCheckFF').html("휴대폰 번호는 숫자와 '-'를 사용하여 입력합니다.");
	 	} else{
		  	$('#phoneCheckFF').text('');
		  	$('#phoneCheckFF').html("<font color='blue'>휴대폰 번호가 정상적입니다.</font>");
	 	}
	});
	
	
 }); // end of script
 
//폼체크
 function CheckForm(check){
 	
   // 비밀번호 검사
   var userpwd1 = $("#mem_pw").val();
   var userpwd2 = $("#mem_pw_check").val();
    if(userpwd1.length == 0){
       alert("비밀번호를 입력해주세요");
     $("#mem_pw").focus();
     return false;
   }
   if(userpwd2.length == 0) {
 	  alert("비밀번호 확인을 해주세요");
 	  $("#mem_pw_check").focus();
 	  return false;
  }
   
   // 닉네임 검사
   var mem_name = $("#mem_name").val();
   if(mem_name.length == 0){
       alert("닉네임을 입력해주세요");
     $("#mem_name").focus();
     return false;
   }
   
 	//휴대폰번호 검사
   var mem_phone = $("#mem_phone").val();
   if(mem_phone.length == 0){
       alert("휴대폰번호를 입력해주세요");
     $("#mem_phone").focus();
     return false;
   }

   alert('회원정보 수정이 완료되었습니다.');

 }	// end of CheckForm(check)
 
</script>
</body>
</html>