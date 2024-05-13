<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="/resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
    <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
        <a href="/" class="d-flex align-items-center col-md-3 mb-2 mb-md-0 text-dark text-decoration-none">
            <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-android" viewBox="0 0 16 16">
                <path d="M2.76 3.061a.5.5 0 0 1 .679.2l1.283 2.352A8.9 8.9 0 0 1 8 5a8.9 8.9 0 0 1 3.278.613l1.283-2.352a.5.5 0 1 1 .878.478l-1.252 2.295C14.475 7.266 16 9.477 16 12H0c0-2.523 1.525-4.734 3.813-5.966L2.56 3.74a.5.5 0 0 1 .2-.678ZM5 10a1 1 0 1 0 0-2 1 1 0 0 0 0 2m6 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
            </svg>
        </a>

        <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
            <li><a href="/" class="nav-link px-2 link-dark" style="font-size: 20px;">Home</a></li>
            <li><a href="/bbs/list" class="nav-link px-2 link-dark" style="font-size: 20px;">My Class</a></li>
<%--            <li><a href="#" class="nav-link px-2 link-secondary">Features</a></li>--%>
        </ul>

        <div class="col-md-3 text-end">
            <c:if test="${sessionScope.user_id != null}">
                <button type="button" class="btn btn-outline-primary me-2" onclick="location.href='/login/logout'">로그아웃</button>
                <button type="button" class="btn btn-primary" onclick="location.href='/member/view?user_id=${sessionScope.user_id}'">마이페이지</button>
            </c:if>
            <c:if test="${sessionScope.user_id == null}">
                <button type="button" class="btn btn-outline-primary me-2" onclick="location.href='/login/login'">로그인</button>
                <button type="button" class="btn btn-primary" onclick="location.href='/member/join'">회원가입</button>
            </c:if>
        </div>
    </header>
</div>

