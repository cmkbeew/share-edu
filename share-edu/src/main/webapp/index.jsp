<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body class="text-center text-dark bg-light bg-opacity-25">
<%@include file="/WEB-INF/common/header.jsp"%>
<div class="cover-container w-50 mx-auto my-5">
    <main class="px-3">
        <c:choose>
            <c:when test="${user_id != null}">
                <h1>${name}님 환영합니다.</h1>
                <p class="lead">
                    방문해주셔서 감사합니다.
                </p>
                <p class="lead">
                    <a href="/login/logout" class="btn btn-lg btn-secondary fw-bold border-white text-white bg-secondary">로그아웃</a>
                    <a href="/myclass/home?member_idx=${sessionScope.member_idx}" class="btn btn-lg btn-secondary fw-bold border-white text-white bg-secondary">오늘의 학습</a>
                </p>
            </c:when>
            <c:otherwise>
                <h1>환영합니다.</h1>
                <p class="lead">
                    방문해주셔서 감사합니다.
                    서비스를 이용하시려면 로그인이 필요합니다.
                </p>
                <p class="lead">
                    <a href="/login/login" class="btn btn-lg btn-secondary fw-bold border-white text-white bg-secondary">로그인</a>
                    <a href="/member/join" class="btn btn-lg btn-secondary fw-bold border-white text-white bg-secondary">회원가입</a>
                </p>
            </c:otherwise>
        </c:choose>
    </main>
</div
<%@include file="/WEB-INF/common/footer.jsp"%>
</body>
</html>