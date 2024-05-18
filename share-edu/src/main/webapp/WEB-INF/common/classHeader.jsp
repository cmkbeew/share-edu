<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<div class="d-flex border-bottom">
    <h2 class="me-3"><a href="/myclass/home?member_idx=${sessionScope.member_idx}" class="text-decoration-none text-dark">오늘의 학습</a></h2>
    <ul class="nav nav-pills rounded-pill align-items-center">
        <li class="nav-item">
            <a href="/myclass/myclass?member_idx=${sessionScope.member_idx}" class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2" id="all-category">
                <span class="d-none d-md-block">나의 학습</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/myclass/receiveList?member_idx=${sessionScope.member_idx}" class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2" id="note-business">
                <span class="d-none d-md-block">공유 학습</span>
            </a>
        </li>
        <li class="text-end">
            <a href="/myclass/regist"><button class="btn btn-primary">학습 등록</button></a>
        </li>
    </ul>
</div>
