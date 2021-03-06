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
<title>MEMOZZANG 나의메모모아보기 - 한눈에 모아보기</title>
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
  			<label>한눈에 모아보기</label>
  			<ul>
			    <li onClick='close_pop("/mymemo/mymemoDefaultAll");'>한눈에 모아보기</li>
			    <li onClick='close_pop("/mymemo/mymemoCalendar");'>달력으로 모아보기</li> 
			    <li onClick='close_pop("/mymemo/mymemoChart");'>그래프로 모아보기</li>
			    <li onClick='close_pop("/mymemo/mymemoBookmark");'>북마크로 모아보기</li>
			</ul>
		</div>
	</div>
	<div id="content">
		<input type="text" name="input" class="input" id="search-input" value='${cri.keyword}' />
		<button type="reset" class="search" id="search-btn"></button>
	</div>
</div><!-- div1 of end -->

<!-- 작은 메모들 -->
<div id="div3">
	<ul id='Grid'>
	</ul>
</div>

<%-- <c:forEach items="${list}" var="memo"> --%>
<!-- 	<div id='sticky'> -->
<%-- 		<p>${list.memo_no}</p>
		<p>${list.memo_name}</p>
		<p>${list.memo_title}</p>
		<p><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.memo_writedate}" /></p> --%>
<!-- 	</div> -->
<%-- </c:forEach> --%>
<!-- memo -->
<!-- Sticly note-->
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
		<!-- <span class="material-icons-outlined" id="modalNoheartBtn">
			favorite_border
		</span> -->
		<span class="material-icons-outlined" id="modalExitBtn" onClick='close_pop("/mymemo/mymemoDefaultAll");'>
			close
		</span>
		<span class="material-icons-outlined" id="sound" onClick='soundTTS()'>
			volume_up
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




<!-- <button id="searchMoreNotify">더 보기</button> -->
<!-- end of memo -->


<script>

//팝업 Close 기능
function close_pop(url) {
	window.location.href = url;
	
 	/* $.ajax({
		url : '${pageContext.request.contextPath}/mymemo/mymemoDefaultAll',
		type : 'get',
		success : function(data) {
			window.location.href = "/mymemo/mymemoDefaultAll";
		},error:function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
	}); */
	
};


$(document).ready(function(){
});		// end of $(document).ready

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
/* TTS */
var voices = [];
	function setVoiceList() {
		voices = window.speechSynthesis.getVoices();
	}
	setVoiceList();
	if (window.speechSynthesis.onvoiceschanged !== undefined) {
		window.speechSynthesis.onvoiceschanged = setVoiceList;
	}
	function speech(txt) {
		if(!window.speechSynthesis) {
			alert("음성 재생을 지원하지 않는 브라우저입니다. 크롬, 파이어폭스 등의 최신 브라우저를 이용하세요");
			return;
		}
		var lang = 'ko-KR';
		var utterThis = new SpeechSynthesisUtterance(txt);
		utterThis.onend = function (event) {
			console.log('end');
		};
		utterThis.onerror = function(event) {
			console.log('error', event);
		};
		var voiceFound = false;
		for(var i = 0; i < voices.length ; i++) {
			if(voices[i].lang.indexOf(lang) >= 0 || voices[i].lang.indexOf(lang.replace('-', '_')) >= 0) {
			utterThis.voice = voices[i];
			voiceFound = true;
			}
		}
		if(!voiceFound) {
			alert('voice not found');
			return;
		}
		utterThis.lang = lang;
		utterThis.pitch = 1;
		utterThis.rate = 1; //속도
		window.speechSynthesis.speak(utterThis);
}
	

var book_check = 0;
var memo_nono = "";
var memo_content = "";
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
					newNode += "<br><br><br>"
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
				memo_content = data.memo_contents;
				
			},error:function(request,status,error){
	            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
		});
}

function soundTTS() {
	console.log("TTS");
	console.log("memo_content?: "+memo_content)
	var t = memo_content;
    speech(t.value);
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
				endIndex: _endIndex,
			},
			url: "${contextPath}/mymemo/searchMoreNotify",
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
	
	// enter시 검색 ajax
	$("#search-input").keyup(function(e){
		if(e.keyCode == 13)  {
			var oldSearchListCnt = '${listCountSearch}';
			console.log("oldListCnt: " + oldListCnt);
			// 조회 인덱스
			var startIndex = 1;	// 인덱스 초기값
			var searchStep = 5;	// 5개씩 로딩
			
			$('#Grid *').remove();		// Grid 내부요소만 삭제위해 *붙임
			readOldNotifySearch(startIndex);
			
			
			function readOldNotifySearch(index){
				var mem_no = $('#mem_no').val();
				var keyword = $('#search-input').val();
				console.log("???: "+mem_no);
				console.log("keyword?: "+keyword);
				var _endIndex = index+searchStep-1;	// endIndex설정
				$.ajax({
					type: "get",
					async: "true",
					dataType: "json",
					data: {
						mem_no: mem_no,
						startIndex: index,
						endIndex: _endIndex,
						keyword: keyword
					},
					url: "${contextPath}/mymemo/searchList",
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
							readOldNotifySearch(startIndex);
							$('#searchMoreNotify').remove();
						})

						// 더보기 버튼 삭제
						if(startIndex + searchStep > oldSearchListCnt){
							$('#searchMoreNotify').remove();
						}	 		
					},error:function(request,status,error){
			            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			           }

				});
			}
			
			
		}
	});
	
	
	
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