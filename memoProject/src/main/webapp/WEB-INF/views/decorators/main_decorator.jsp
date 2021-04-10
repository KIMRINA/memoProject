<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>

<script src="https://code.jquery.com/jquery-latest.js"></script>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Love+Ya+Like+A+Sister&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@700&display=swap" rel="stylesheet">
<html>
<head>
	<title>
		<decorator:title default="traveler" />
	</title>
	<style>
	
/* div */
	
.globalmenu{
		width: 1506px;
		height: 190px;
		border: 2px solid #09c;
		font-family: 'Love Ya Like A Sister', cursive;
		background-color: rgba( 255, 255, 255, 0.3 );
	}
	.globalmenu .left-menu{
		float: left;
		width: 300px;
		height: 1001px;
		border: 2px solid red;
	}
	.globalmenu .middium-title{
    	position: absolute;
    	left: 650px;
	}
	.globalmenu .right-home{
    	position: absolute;
    	left: 1400px;
    	top: 64px;
	}
	.foot{
		width: 1506px;
		height: 44px;
		border: 2px solid purple;
		background-color: rgba( 255, 255, 255, 0.3 );
	}
	.main .content .article{
		width: 1506px;
		height: 850px;
		border: 2px solid blue;
		background-color: rgba( 255, 255, 255, 0.3 );
	}
	
	
/* google icon */
.material-icons-outlined {
  font-family: 'Material Icons';
  font-weight: normal;
  font-style: normal;
  font-size: 60px;  /* Preferred icon size */
  display: inline-block;
  line-height: 1;
  text-transform: none;
  letter-spacing: normal;
  word-wrap: normal;
  white-space: nowrap;
  direction: ltr;
  color: #000000;

  /* Support for all WebKit browsers. */
  -webkit-font-smoothing: antialiased;
  /* Support for Safari and Chrome. */
  text-rendering: optimizeLegibility;

  /* Support for Firefox. */
  -moz-osx-font-smoothing: grayscale;

  /* Support for IE. */
  font-feature-settings: 'liga';
}

.material-icons-outlined:hover {
	color: #c6f1e7;
}

	
/* 메뉴 */
body
{
  margin: 0;
  padding: 0;
  
  background-color: rgba( 255, 255, 255, 0.5 );
  background-image: url('https://www.myfreetextures.com/wp-content/uploads/2014/11/wooden-cork-texture.jpg');
}

#menuToggle
{
  display: block;
  position: relative;
  top: 80px;
  left: 50px;
  z-index: 2;
  -webkit-user-select: none;
  user-select: none;
}

#menuToggle a
{
  text-decoration: none;
  color: #232323;
  
  transition: color 0.3s ease;
}

#menuToggle a:hover
{
  color: tomato;
}


#menuToggle input
{
  display: block;
  width: 40px;
  height: 32px;
  position: absolute;
  top: -7px;
  left: -5px;
  cursor: pointer;
  opacity: 0; /* hide this */
  z-index: 2; /* and place it over the hamburger */
  
  -webkit-touch-callout: none;
}

/*
 * Just a quick hamburger
 */
#menuToggle span
{
  display: block;
  width: 33px;
  height: 4px;
  margin-bottom: 5px;
  position: relative;
  
  background: #000000;
  border-radius: 3px;
  
  z-index: 1;
  
  transform-origin: 4px 0px;
  
  transition: transform 0.5s cubic-bezier(0.77,0.2,0.05,1.0),
              background 0.5s cubic-bezier(0.77,0.2,0.05,1.0),
              opacity 0.55s ease;
}

#menuToggle span:first-child
{
  transform-origin: 0% 0%;
}

#menuToggle span:nth-last-child(2)
{
  transform-origin: 0% 100%;
}

/* 
 * Transform all the slices of hamburger
 * into a crossmark.
 */
#menuToggle input:checked ~ span
{
  opacity: 1;
  transform: rotate(45deg) translate(-2px, -1px);
  background: #232323;
}

/*
 * But let's hide the middle one.
 */
#menuToggle input:checked ~ span:nth-last-child(3)
{
  opacity: 0;
  transform: rotate(0deg) scale(0.2, 0.2);
}

/*
 * Ohyeah and the last one should go the other direction
 */
#menuToggle input:checked ~ span:nth-last-child(2)
{
  transform: rotate(-45deg) translate(0, -1px);
}

/*
 * Make this absolute positioned
 * at the top left of the screen
 */
#menu
{
  position: absolute;
  width: 300px;
  height: 662px;
  margin: -109px 0 0 -50px;
  padding: 50px;
  padding-top: 180px;
  font-family: 'Noto Serif KR', serif;
  
  background: #c6f1e7;
  list-style-type: none;
  -webkit-font-smoothing: antialiased;
  /* to stop flickering of text in safari */
  
  transform-origin: 0% 0%;
  transform: translate(-100%, 0);
  
  transition: transform 0.5s cubic-bezier(0.77,0.2,0.05,1.0);
}

#menu li
{
  padding: 30px 80px;
  font-size: 30px;
}

/*
 * And let's slide it in from the left
 */
#menuToggle input:checked ~ ul
{
  transform: none;
}
	
	</style>
	<decorator:head />
</head>
<body>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String name = "";
    if(principal != null) {
        name = auth.getName();
    }
%>


<div class="ex-layout">
	<div class="globalmenu">
		<div class="left-menu">
		
			<nav role="navigation">
			  <div id="menuToggle">
			    <input type="checkbox" />
			    <span></span>
			    <span></span>
			    <span></span>
			    
			    <ul id="menu">
			      <a href="/others/othersMemo"><li>타인메모<br>모아보기</li></a>
			      
			      <sec:authorize access="isAnonymous()">
			      	<a href="/member/customLogin" onclick="altert()"><li>나의메모<br>모아보기</li></a>
			      	<a href="/member/customLogin"><li>로그인</li></a>
			      	<a href="/member/memberJoin1"><li>회원가입</li></a>
			      </sec:authorize>
			      <sec:authorize access="isAuthenticated()">
			      <a href="/mymemo/mymemoDefaultAll"><li>나의메모<br>모아보기</li></a>
			      	<a href="/member/memberModify1"><li>회원정보수정</li></a>
			      	<a href="#" onclick="document.getElementById('logout-form').submit();"><li>로그아웃</li></a>
			      </sec:authorize>
			    </ul>
			  </div>
			</nav>
			
			<form id="logout-form" action='<c:url value='/member/customLogout'/>' method="POST">
   				<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
			</form>

			
		</div><!-- left-menu -->
		
		<div class="middium-title">
			<img src="/resources/decorators/img/logo_transparent.png" width="200px" height="200px">
		</div>
		
		<div class="right-home">
			<sec:authorize access="isAnonymous()">
			<span style="cursor:pointer;" class="material-icons-outlined" onclick="goMain()">
				gite
			</span>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<span style="cursor:pointer;" class="material-icons-outlined" onclick="goLoginMain()">
				gite
			</span>
			</sec:authorize>
		</div>
		
	
	</div><!-- globalmenu -->
	<div class="main">
		<div class="content">
			<div class="article">
				<decorator:body />
			</div>
	</div>
	<div class="foot">foot</div>




</div>
</div>

	
<script>
// main 이동
function goMain() {
	window.location.href = "/main/memoMain";
};

function goLoginMain() {
	window.location.href = "/main/loginMain";
}

function altert() {
	alert('로그인이 필요합니다.');
}

</script>
</body>
</html>
