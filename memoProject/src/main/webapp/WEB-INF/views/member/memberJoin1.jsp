<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMOZZANG 회원가입-약관동의</title>
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
	height: 200px;
	position: relative;
    top: -30%;

}
#p3 {
	position: relative;
    top: 5%;
    left: 50px;
    font-size: 15pt;
}
#hr1 {
	width: 90%;
    position: relative;
    top: 2%;
}
#p4 {
	position: relative;
    top: 5%;
    left: 50px;
    font-size: 15pt;
}
#p5 {
	position: absolute;
    top: 72px;
    left: 80%;
    font-size: 10pt;
    cursor:pointer;
}
#p6 {
	position: relative;
    top: 10%;
    left: 50px;
    font-size: 15pt;
}
#p7 {
	position: absolute;
    top: 129px;
    left: 80%;
    font-size: 10pt;
    cursor:pointer;
}
#div4 {
	text-align: center;
}

</style>
</head>
<body>

<form name="frmJoin" action="/member/memberJoinForm"  onSubmit="return CheckForm(this)">
<div>
	<div id="div1">
		<p id="p1" style="font-size: 30pt;"><strong>회원가입</strong></p>
		<div id="div2">
			<p id="p2"><strong>1. 약관동의</strong>&nbsp;|&nbsp;2. 정보 입력&nbsp;|&nbsp;3. 가입 완료</p>
		</div>
		<div id="div3">
			<p id="p3"><input type="checkbox" value='selectall' name='agree' onclick='selectAll(this)'>&nbsp;<b>전체동의</b></p>
			<hr id="hr1">
			<p id="p4"><input type="checkbox" name='agree' id="agree1">&nbsp;<b>회원가입약관</b></p>
			<p id="p5" onclick="window.open('/member/memberJoinTerms1','약관전체보기','width=700,height=500,location=no,status=no,scrollbars=yes');"><U>약관전체보기</U></p>
			<p id="p6"><input type="checkbox" name='agree' id="agree2">&nbsp;<b>개인정보처리방침안내</b></p>
			<p id="p7" onclick="window.open('/member/memberJoinTerms2','약관전체보기','width=900,height=450,location=no,status=no,scrollbars=yes');"><U>약관전체보기</U></p>
		</div>
		<div id="div4">
			<button>동의하고 회원가입</button>
		</div>
	</div>
</div>

</form>

<script>

// 체크박스 전체선택, 전체해제
function selectAll(selectAll)  {
  const checkboxes 
       = document.getElementsByName('agree');
  
  checkboxes.forEach((checkbox) => {
    checkbox.checked = selectAll.checked;
  })
}

// 체크박스 동의 여부
function CheckForm(check){
        
var chk1=document.frmJoin.agree1.checked;
var chk2=document.frmJoin.agree2.checked;

if(!chk1){
    alert('회원가입 약관에 동의해 주세요');
    return false;
} 
if(!chk2) {
    alert('개인정보처리방침안내 약관에 동의해 주세요');
    return false;
}

//체크박스 체크여부 확인 [동일 이름을 가진 체크박스 여러개일 경우]
var isAgreeChk = false;
var arr_Agree = document.getElementsByName("agree");
for(var i=0;i<arr_Agree.length;i++){
    if(arr_Agree[i].checked == true) {
        isAgreeChk = true;
        break;
    }
}
if(!isAgreeChk){
    alert("약관을 모두 동의해주세요.");
    return false;
}

}




</script>

</body>
</html>