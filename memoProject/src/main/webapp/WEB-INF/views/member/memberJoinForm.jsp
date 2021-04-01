<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>

</head>
<body>

    <h1 class="text-center">회원 가입</h1>
    <div class="row">
        <div class="col-xs-3 col-sm-3"></div>
        <div class="col-xs-6 col-sm-6">
            
            <form method="post" action="/member/memberJoin">
                <table class="table">
                    <tr>
                        <td>아이디</td>
                        <td><input type="email" name="username" class="form-control" /> <br>
                            <span class="label label-danger">${idCheck}</span>
                        </td>     
                    </tr>
 
                    <tr>
                        <td>비밀번호</td>
                        <td>
                        	<input type="password" name="password" class="form-control" />
                        </td>         
                    </tr>
 
                    <tr>
                        <td>비밀번호확인</td>
                        <td><input type="password" name="pwCheck" class="form-control">
                             <br>
                        <span class="label label-danger">${pwCheck}</span></td>
                    </tr>
 
                    <tr>
                        <td>닉네임</td>
                        <td><input type="text" name="mem_name" class="form-control" /> <br>
                    </tr>
 
                    <tr>
                        <td>휴대폰번호</td>
                        <td><input type="text" name="mem_phone" class="form-control" /> <br>
                        </td>
                    </tr>
 
                    <tr>
                        <td>성별</td>
                        <td>
                        	<input type="radio" name="mem_gender" value="1">남&emsp;
         					<input type="radio" name="mem_gender" value="0" checked>여
                        </td>
                    </tr>
 
                    <tr>
                        <td>
                        	<input type = "hidden" name = "${_csrf.parameterName }" value = "${_csrf.token }"/>
                        	<input type = "hidden" name = "authorities" value = "ROLE_MEMBER"/>
                        	
                        	<input type="submit" value="회원가입">
                        </td>
                    </tr>
 
                </table>
            </form>
 
        </div>
    </div>

</body>
</html>