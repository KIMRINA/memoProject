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
<title>MEMOZZANG 나의메모모아보기 - 달력으로 모아보기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<meta name="author" content="www.twitter.com/cheeriottis">

<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Raleway:300,400' rel='stylesheet' type='text/css'>

<link rel="stylesheet" href="../resources/css/mymemoDefaultAll.css" type="text/css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.6.0/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.6.0/locales-all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.6.0/main.min.css" rel='stylesheet' type='text/css'>

<style>
#div4 {
	position: absolute;
    top: 330px;
    left: 170px;
    width: 1200px;
    height: 700px;
    background-color: rgba( 255, 255, 255, 0.7 );
}
</style>
</head>

<body>

<div id="div1">
	<div id="div2">
		<div class='dropdown'>
  			<label>달력으로 모아보기</label>
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


<div id="external-events">
    <div class="fc-event"></div>
      <input type="checkbox" id="drop-remove" style="position: absolute;top: 400px;">
      <label for="drop-remove"></label>
</div>
<div id="div4">
	<div id='calendar'></div>
</div>


<!-- memo -->
<!-- Sticly note-->
<form name="formMod" method="post" action="">
<input type="hidden" name="memo_contents" />
<input type="hidden" name="mem_no" id="mem_no" value="${login.mem_no}">
<input type="hidden" name="username" value="${username}">
<input type="hidden" name="memo_name" id="memo_name" value="${login.mem_name}">
<input type="hidden" name="memo_no" id="memo_no" value="${list.memo_no}">
</form>

<div id="myModal" class="modal">
	<div draggable="true" id='stickyModal'>
		<a class="btn btn-outline-dark heart">
           <img id="heart" src="">
       	</a>
		<!-- <span class="material-icons-outlined" id="modalNoheartBtn">
			favorite_border
		</span> -->
		<span class="material-icons-outlined" id="modalExitBtn" onClick='close_pop("/mymemo/mymemoCalendar");'>
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




<!-- <button id="searchMoreNotify">더 보기</button> -->
<!-- end of memo -->

<script>
var mem_no = $('#mem_no').val();
console.log("mem_no?: "+mem_no);
var memo_n = "";
document.addEventListener('DOMContentLoaded', function() {
	var initialLocaleCode = 'ko';
	var localeSelectorEl = document.getElementById('locale-selector');
	var Calendar = FullCalendar.Calendar;
	var Draggable = FullCalendar.Draggable;

	var containerEl = document.getElementById('external-events');
	var calendarEl = document.getElementById('calendar');
	var checkbox = document.getElementById('drop-remove');
	  
	  // initialize the external events
	  // -----------------------------------------------------------------

	  new Draggable(containerEl, {
	    itemSelector: '.fc-event',
	    eventData: function(eventEl) {
	      return {
	        title: eventEl.innerText
	      };
	    }
	  });

	  // initialize the calendar
	  // -----------------------------------------------------------------
	  
	  var calendar = new FullCalendar.Calendar(calendarEl, {
		  eventClick: function(info) {
		      var eventObj = info.event;
		      info.jsEvent.preventDefault();

		        alert('Clicked ' + eventObj.title);
		        memo_n = info.event.url;
		        console.log("memo_n: "+memo_n);
		        goModal(memo_n);
		    },
	    initialView: 'dayGridMonth',
	    initialDate: '2021-04-07',
	    height: '100%',
	    locale: initialLocaleCode,
	    buttonIcons: false, // show the prev/next text
	    weekNumbers: true,
	    navLinks: true, // can click day/week names to navigate views
	    editable: true,
	    dayMaxEvents: true, // allow "more" link when too many events
	    events: 'https://fullcalendar.io/demo-events.json?overload-day',
	    headerToolbar: {
	      left: 'prev,next today',
	      center: 'title',
	      right: 'dayGridMonth,timeGridWeek,timeGridDay'
	    },
	    editable: true,
	    droppable: true, // this allows things to be dropped onto the calendar
	    drop: function(info) {
	        // is the "remove after drop" checkbox checked?
	        if (checkbox.checked) {
	          // if so, remove the element from the "Draggable Events" list
	          info.draggedEl.parentNode.removeChild(info.draggedEl);
	        }
	    },
	    eventSources: [{
	    	events: function(info, successCallback, failureCallback) {
				$.ajax({
					url: "/mymemo/calendarList",
					type: 'POST',
					dataType: 'json',
					data: {
						mem_no : mem_no
					},
					success: function(data) {
						console.log("Data:"+JSON.stringify(data))
						successCallback(data);
					}
				});
			}
		}]
	    
	  });

	  calendar.render();
	  
	  
	});

</script>
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
					newNode += "<p>"+data.book_likecheck+"</p>"
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


 $(document).ready(function(){
	
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