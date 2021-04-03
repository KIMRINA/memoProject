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
    top: 10%;
    left: 50px;
    font-size: 15pt;
}
#hr1 {
	width: 90%;
    position: relative;
    top: 8%;
}
#p4 {
	position: relative;
    top: 7%;
    left: 50px;
    font-size: 15pt;
}
#p5 {
	position: absolute;
    top: 77px;
    left: 80%;
    font-size: 10pt;
    cursor:pointer;
}
#p6 {
	position: relative;
    top: 13%;
    left: 50px;
    font-size: 15pt;
}
#p7 {
	position: absolute;
    top: 134px;
    left: 80%;
    font-size: 10pt;
    cursor:pointer;
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
  content:"동의하고 회원가입";
  position:absolute;
  width:100%;
  height:100%;
  left:0;
  text-align:center;
  -webkit-transition: all 400ms cubic-bezier(0.680, -0.550, 0.265, 1.550); 
}

.slide:before {
  content:"회원가입 →";
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

<form name="frmJoin" action="/member/memberJoin2"  onSubmit="return CheckForm(this)">
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
			<button id="btn1" class="slide">&nbsp;</button>
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