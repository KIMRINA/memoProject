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
<script src="https://code.jquery.com/jquery-latest.js"></script>
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


 
</style>

</head>
<body>

<!-- 회원가입 모달 -->
<sec:authorize access="isAnonymous()">
<button onclick="goModal()">메모등록</button>
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
        
<sec:authorize access="isAuthenticated()">
	<button>메모등록</button>
</sec:authorize>



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
	
</script>

</body>
</html>