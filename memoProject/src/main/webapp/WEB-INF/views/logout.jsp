<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:url value="/logout" var="logoutUrl" />



	<!-- csrt for log out-->

	<form action="${logoutUrl}" method="post" id="logoutForm">

		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

	</form>


	<script>
		function formSubmit() {

			document.getElementById("logoutForm").submit();

		}
	</script>


	<!------------------------     navigation   ------------------------>

	....

	<form class="navbar-form navbar-right">

		<span style="color: gray;"><h5>
				${username} 님 반갑습니다.

				<a href="javascript:formSubmit()"> 로그아웃 </a>
			</h5></span>

	</form>


</body>
</html>