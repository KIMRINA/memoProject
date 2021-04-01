<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>Custom Login Page</h1>
<h2><c:out value = "${error}"/></h2>
<h2><c:out value = "${logout}"/></h2>

<form method = 'post' action = "/login">
	<div>
		<input type = 'text' name = 'username' value = 'member2@1'>
	</div>
	<div>
		<input type = 'password' name = 'password' value = '1'>
	</div>
	<div>
		<input type = 'submit'>
	</div>
	<input type = "hidden" name = "${_csrf.parameterName }" value = "${_csrf.token }"/>
</form>

<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
    <font color="red">
        <p>Your login attempt was not successful due to <br/>
            ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</p>
        <c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
    </font>
</c:if>

</body>
</html>