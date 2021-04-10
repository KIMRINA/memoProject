<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMOZZANG 나의메모모아보기 - 북마크로 모아보기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<meta name="author" content="www.twitter.com/cheeriottis">

<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Raleway:300,400' rel='stylesheet' type='text/css'>

<link rel="stylesheet" href="../resources/css/mymemoDefaultAll.css" type="text/css">
</head>
<body>

<div id="div1">
	<div id="div2">
		<div class='dropdown'>
  			<label>북마크로 모아보기</label>
  			<ul>
			    <li onClick='close_pop("/mymemo/mymemoDefaultAll");'>한눈에 모아보기</li>
			    <li onClick='close_pop("/mymemo/mymemoCalendar");'>달력으로 모아보기</li> 
			    <li onClick='close_pop("/mymemo/mymemoChart");'>그래프로 모아보기</li>
			    <li onClick='close_pop("/mymemo/mymemoBookmark");'>북마크로 모아보기</li>
			</ul>
		</div>
	</div>
	<div id="content">
		<input type="text" name="input" class="input" id="search-input">
		<button type="reset" class="search" id="search-btn"></button>
	</div>
</div><!-- div1 of end -->

<!-- 작은 메모들 -->
<div id="div3">
	<ul id='Grid'>
	</ul>
</div>

<form name="formMod" method="post" action="">
<input type="hidden" name="memo_contents" />
<input type="hidden" name="mem_no" id="mem_no" value="${login.mem_no}">
<input type="hidden" name="username" value="${username}">
<input type="hidden" name="memo_name" id="memo_name" value="${login.mem_name}">
<input type="hidden" name="memo_no" id="memo_no" value="${list.memo_no}">
</form>

<input type="hidden" id="memoBtn"onclick="goModal()" />
<div id="myModal" class="modal">
	<div draggable="true" id='stickyModal'>
		<a class="btn btn-outline-dark heart">
           <img id="heart" src="">
       	</a>
		<span class="material-icons-outlined" id="modalExitBtn" onClick='close_pop("/mymemo/mymemoBookmark");'>
			close
		</span>
  		<div id="quillEditor">
  		</div>
	</div>
	<div id="modalBtnDiv">
		<button id="modifyBtn" class="btn btn-default">MODIFY</button>
		<button id="removeBtn" class="btn btn-danger">DELETE</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	</div>
</div>	<!-- Modal of end -->



<script>
//팝업 Close 기능
function close_pop(url) {
	window.location.href = url;
};
</script>
<script>
	// 드롭다운
	var dropdown = document.querySelector('.dropdown'),
    dropdown_ul = dropdown.querySelector('ul');

	dropdown.addEventListener('click', function() {
	  if(dropdown_ul.offsetLeft < 0) {
	    dropdown_ul.style.left = '0';
	    dropdown_ul.style.right = '0';
	    dropdown_ul.stle.display = 'static';
	  } else {
	    dropdown_ul.style.left = '-9999px';
	    dropdown_ul.style.right = '';
	    dropdown_ul.stle.display = 'absolute';
	  }
	});
	
	$('.dropdown li').each(function() {
	  $(this).click(function() {
	    $('.dropdown label').text($(this).text());
	  });
	});
</script>
<script>

// search
const input = document.getElementById("search-input");
const searchBtn = document.getElementById("search-btn");

const expand = () => {
  searchBtn.classList.toggle("close");
  input.classList.toggle("square");
};

searchBtn.addEventListener("click", expand);

</script>
<script>

var book_check = 0;
var memo_nono = "";
// memo 하나 읽기 ajax
function goModal(memo_no) {
		$('#myModal').show();
	  	console.log("oneMemo");
		console.log("memo_no: "+memo_no);
		
		// 메모 삭제
		$("#removeBtn").on("click", function(){
			alert("메모를 삭제합니다");
			console.log("memo_no: " + memo_no)
			window.location.href = "/mymemo/memoDelete?memo_no="+memo_no;
		});
		
		// 메모 수정
		$("#modifyBtn").on("click", function(){
			window.location.href = "/mymemo/mymemoModify?memo_no="+memo_no;
		});
		
		// memo 하나 읽기 ajax
		$.ajax({
			url : '${pageContext.request.contextPath}/mymemo/readOneMemo?memo_no='+ memo_no,
			type : 'get',
			async: "true",
			dataType: "json",
			data: {
				memo_no: memo_no,
			},
			success : function(data, textStatus) {
				console.log("readMemo : "+ JSON.stringify(data));
				var NodeList = "";
				var newNode = "<p id='memoP1'>게시글 번호: "+data.memo_no+"</p>";
					newNode += "<p id='memoP2'>작성날짜 :"+data.memo_writedate+"</p>";
					newNode += "<p id='memoP3'>글쓴이: "+data.memo_name+"</p>";
					newNode += "<p id='memoP4'>"+data.memo_title+"</p>";
					newNode += "<p id='memoP5'>"+data.memo_contents+"</p>";
					if(data.memo_open == 0) {
						newNode += "<input type='radio' name='memo_open' id='memo_open' value='0' checked='checked'><span>공개</span>";
						newNode += "<input type='radio' name='memo_open' id='memo_open' value='1'><span>비공개</span> ";
					} else if(data.memo_open == 1) {
						newNode += "<input type='radio' name='memo_open' id='memo_open' value='0'><span>공개</span>";
						newNode += "<input type='radio' name='memo_open' id='memo_open' value='1' checked='checked'><span>비공개</span>";
					}
					NodeList += newNode;
					console.log("NodeList: "+NodeList);
					
					
					if(data.book_likecheck>0) {
				        console.log("heartval: "+data.book_likecheck);
				        $("#heart").prop("src", "/resources/images/like2.png");
				    }
				    else {
				    	console.log("heartval: "+data.book_likecheck);
				    	$("#heart").prop("src", "/resources/images/like1.png");
				    }
					
				$(NodeList).appendTo($("#quillEditor"));
				
				book_check = data.book_likecheck;
				memo_nono = data.memo_no;
				
			},error:function(request,status,error){
	            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
		});
}	


// 페이징 ajax
 $(document).ready(function(){
	// 읽은 알림 총 갯수
	var oldListCnt = '${listCount}';
	console.log("oldListCnt: " + oldListCnt);
	// 조회 인덱스
	var startIndex = 1;	// 인덱스 초기값
	var searchStep = 5;	// 5개씩 로딩
	
	// 페이지 로딩 시 첫 실행
	readOldNotify(startIndex);
	
	// 더보기 실행함수 **
	function readOldNotify(index){
		var mem_no = $('#mem_no').val();
		console.log("???: "+mem_no);
		var _endIndex = index+searchStep-1;	// endIndex설정
		$.ajax({
			type: "get",
			async: "true",
			dataType: "json",
			data: {
				mem_no: mem_no,
				startIndex: index,
				endIndex: _endIndex
			},
			url: "${contextPath}/mymemo/mymemoBookSort",
			success: function (data, textStatus) {
				console.log("data: " + JSON.stringify(data));
				var NodeList = "";
				for(i = 0; i < data.length; i++){
					var newNode = "<li id='oneMemo' onclick='goModal("+data[i].memo_no+")'>";
					newNode += "<p id='p1'>"+data[i].memo_no+"</p>"
					newNode += "<p id='p2'>"+data[i].memo_name+"</p>"
					newNode += "<p id='p3'>"+data[i].memo_title+"</p>"
					newNode += "<p>"+data[i].memo_writedate+"</p></li>"
					NodeList += newNode;
				}
				NodeList += "<button id='searchMoreNotify'><span class='material-icons-outlined'>expand_more</span></button>"
				$(NodeList).appendTo($("#Grid")).slideDown();
				console.log("NodeList: "+newNode);
				
				// 더보기 클릭시
				$('#searchMoreNotify').click(function(){
					startIndex += searchStep;
					readOldNotify(startIndex);
					$('#searchMoreNotify').remove();
				})

				// 더보기 버튼 삭제
				if(startIndex + searchStep > oldListCnt){
					$('#searchMoreNotify').remove();
				}	 		
			},error:function(request,status,error){
	            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           }

		});
	}
	
	
	// 북마크
    var heartval = book_check;
    console.log("트발이: " + heartval);

    if(heartval>0) {
        console.log("heartval: "+heartval);
        $("#heart").prop("src", "/resources/images/like2.png");
        $(".heart").prop('name',heartval)
    }
    else {
    	console.log("heartval: "+heartval);
    	$("#heart").prop("src", "/resources/images/like1.png");
        $(".heart").prop('name',heartval)
    }

    $(".heart").on("click", function () {

        var that = $(".heart");

        var sendData = {'memo_no' : memo_nono,'heart' : that.prop('name')};
        $.ajax({
            url :'/mymemo/heartAdd',
            type :'POST',
            data : sendData,
            success : function(data){
            	console.log("트발이: "+data)
                that.prop('name',data);
                if(data==1) {
                	$('#heart').prop("src","/resources/images/like2.png");
                }
                else{
                	$('#heart').prop("src","/resources/images/like1.png");
                }


            }
        });
    });	
	
	
	
}); /* end of script */

</script>

</body>
</html>