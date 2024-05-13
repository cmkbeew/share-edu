<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
<c:if test="${empty sessionScope.user_id}" var="noLogin">
    <a href="/login/login">로그인</a>
    <a href="/member/join">회원가입</a>
</c:if>
<c:if test="${not noLogin}">
    <a href="/login/logout">로그아웃</a>
    <a href="/member/mypage">내정보수정</a>
</c:if>
${sessionScope.user_id}
${sessionScope.name}
</body>
</html>