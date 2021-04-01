<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */                          
        }
 
</style>

</head>
<body>

<!-- 회원가입 모달 -->
<button onclick="goJoin()">메모등록</button>
<!-- The Modal -->
    <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
      	<p><span style="font-size: 14pt;"><b><span style="font-size: 21pt;">메모를 작성하시려면</span></b></span></p>
      	<p><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">회원가입이 필요합니다</span></b></span></p>
      	<div style="background-color:#DDDDDD;padding-bottom: 10px;padding-top: 10px;">
      		<p style="line-height: 1.5;"><b><span style="font-size: 16pt;">일반회원가입</span></b><button style="text-align: right;">가입하기</button></p>
      	</div>
        <p style="text-align: center; line-height: 1.5;"><br /></p>
        <div style="text-align: center; background-color:#DDDDDD;padding-bottom: 25px;padding-top: 25px;">
      		<p style="text-align: center; line-height: 1.5;"><b><span style="font-size: 16pt;">소셜회원가입</span></b></p>
      		<button>카카오로 가입하기</button><button>구글로 가입하기</button>
      	</div>
        <p style="text-align: center; line-height: 1.5;"><b><span style="color: rgb(255, 0, 0); font-size: 14pt;"></span></b></p>
        <p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;"><br /></span></p>
        <p><br /></p>
       <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
       	<span class="pop_bt" style="font-size: 13pt;" >닫기</span>
      </div>
      </div>
 
    </div>
        <!--End Modal-->



<script>

// 회원가입 이동 모달
	function goJoin() {
		$('#myModal').show();
	};
	//팝업 Close 기능
	function close_pop(flag) {
		$('#myModal').hide();
	};
</script>

</body>
</html>