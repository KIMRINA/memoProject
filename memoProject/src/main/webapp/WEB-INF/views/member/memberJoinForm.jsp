<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMOZZANG 회원가입-정보입력</title>
<style>
#div1 {
	position: absolute;
    top: 40%;
    left: 450px;
    width: 650px;
    height: 100px;
    background-color: aliceblue;
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
	height: 450px;
	position: relative;
    top: -30%;
}
#id_check_button {
	position: absolute;
    right: 3.4%;
}


</style>
</head>
<body>

<script> 

// 폼체크
function CheckForm(check){
	
//이메일 아이디 유효성 검사 및 정규식 검증. 
  var email_rule =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
  var email_id =$("#email_id").val();
  var email_domain =$("#email_domain").val();
  var mail ="";
 
  if(!email_id){
      alert("이메일을 입력해주세요");
    $("#email_id").focus();
    return false;
  }
  if(!email_domain){
      alert("도메인을 입력해주세요");
    $("#email_domain").focus();
    return false;
  }
  mail = email_id+"@"+email_domain;
  $("#mail").val(mail);  
  
  if(!email_rule.test(mail)){
      alert("이메일을 형식에 맞게 입력해주세요.");
    return false;
  }
  
  
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


}	// end of CheckForm(check)



// 이메일 도메인 선택
function setEmailDomain(domain){
	$("#email_domain").val(domain);
}

$(document).ready(function(){    

 // 이메일 중복검사
  $("#id_check_button").click(function() {
	  console.log("email_id check");
		// id = "id_reg" / name = "userId"
		var email_id =$("#email_id").val();
  		var email_domain =$("#email_domain").val();
  		var mail = email_id+"@"+email_domain;
		var username = mail;
  		console.log(mail);
  		
		$.ajax({
			url : '${pageContext.request.contextPath}/member/idCheck?username='+ username,
			type : 'get',
			success : function(data) {
				console.log("1 = 중복o / 0 = 중복x : "+ data);							
				
				if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다 :p");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
					} else {
						
						if(username == "@" || username.charAt(0) == "@")  {
							
							$('#id_check').text('아이디를 입력해주세요 :)');
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);				
							
						} else if(username.charAt(username.length-1) == "@") {
							$('#id_check').text('도메인을 입력해주세요 :)');
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);
							
						} else if(data == 0) {
							$('#id_check').text('사용 가능 합니다 :)');
							$('#id_check').css('color', 'blue');
							$("#reg_submit").attr("disabled", false);
							
						} else {
							
							$('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다 :) :)");
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);
						}
						
					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
		
		
});	// end of script function
    
</script>

<div>
	<div id="div1">
		<p id="p1" style="font-size: 30pt;"><strong>회원가입</strong></p>
		<div id="div2">
			<p id="p2">1. 약관동의&nbsp;|&nbsp;<strong>2. 정보 입력</strong>&nbsp;|&nbsp;3. 가입 완료</p>
		</div>
	
   		<div id="div3">
            <form name="formJoin" method="post" action="/member/memberJoin" onSubmit="return CheckForm(this)">
                <table class="table">
                    <%-- <tr>
                        <td>아이디</td>
                        <td><input type="email" name="username" class="form-control" /> <br>
                            <span class="label label-danger">${idCheck}</span>
                        </td>     
                    </tr> --%>
                    <tr>
						<td>
							이메일 <span class="em_red">*</span>
						</td>
					</tr>
					<tr>
						<td id="td2">
							<input type="text" id="email_id" name="username" class="form_w200" title="이메일 아이디" placeholder="이메일" maxlength="18" > @ 
							<input type="text" id="email_domain" name="username" class="form_w200" title="이메일 도메인" placeholder="이메일 도메인" maxlength="18"> 
							<select class="select" title="이메일 도메인 주소 선택" onclick="setEmailDomain(this.value);return false;">
							    <option value="">-선택-</option>
							    <option value="naver.com">naver.com</option>
							    <option value="gmail.com">gmail.com</option>
							    <option value="hanmail.net">hanmail.net</option>
							    <option value="hotmail.com">hotmail.com</option>
							    <option value="korea.com">korea.com</option>
							    <option value="nate.com">nate.com</option>
							    <option value="yahoo.com">yahoo.com</option>
							</select>
							<input type="button" value="중복확인" id="id_check_button" />
						</td>
					</tr>
					<tr>
						<td>
							<p class="check_font" id="id_check"></p>
						</td>
					</tr>
 
                    <tr>
                        <td>비밀번호</td>
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
                        <td>비밀번호확인</td>
                    </tr>
                    <tr>
                    	<td><input type="password" id="mem_pw_check" name="pwCheck" class="form-control" placeholder="비밀번호 확인" />
                        <%-- <span class="label label-danger">${pwCheck}</span></td> --%>
                    </tr>
                    <tr>
						<td>
							<p id="pwCheckFF" style="color: #FF6600; margin: 0;"></p>
						</td>
					</tr>
 
                    <tr>
                        <td>닉네임</td>
                    </tr>
                    <tr>
                    	<td><input type="text" id="mem_name" name="mem_name" class="form-control" />
                    </tr>
 
                    <tr>
                        <td>휴대폰번호</td>
                    </tr>
                    <tr>
                    	<td>
                    		<select class="select" title="국번 선택" name="mem_phone">
							    <option value="">-선택-</option>
							    <option value="010">010</option>
							    <option value="011">011</option>
							    <option value="016">016</option>
							    <option value="017">017</option>
							    <option value="018">018</option>
							    <option value="019">019</option>
							</select>
                    		<input type="text" id="mem_phone" name="mem_phone" class="form-control" /> <br>
                        </td>
                    </tr>
                    <tr>
						<td>
							<p id="phoneCheckFF" style="color: #FF6600; margin: 0;"></p>
						</td>
					</tr>
 
                    <tr>
                        <td>성별</td>
                    </tr>
                    <tr>
                    	<td>
                        	<input type="radio" name="mem_gender" value="1">남&emsp;
         					<input type="radio" name="mem_gender" value="0" checked>여
                        </td>
                    </tr>
 
                    <tr>
                        <td>
                        	<input type = "hidden" name = "${_csrf.parameterName }" value = "${_csrf.token }"/>
                        	<input type = "hidden" name = "authorities" value = "ROLE_MEMBER"/>
                        	
                        	<input type="submit" id="reg_submit" value="회원가입" disabled="true">
                        </td>
                    </tr>
 
                </table>
            </form>
 
    	</div>	<!-- end of div3 -->
	</div>	<!-- end of div1 -->
</div>




<script>
var pw_rule = /^[A-Za-z0-9]{4,12}$/;	// 비밀번호 정규식
var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
var phone_rule = /^\d{3,4}-\d{4}$/;	// 폰번호 정규식


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
 


</script>

</body>
</html>