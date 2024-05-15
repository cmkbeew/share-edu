<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>My Class</title>
</head>
<body>
<%@include file="../common/header.jsp"%>

<div class="container px-4 py-5">
    <div class="d-flex border-bottom">
        <h2 class="me-3">오늘의 학습</h2>
        <ul class="nav nav-pills rounded-pill align-items-center">
            <li class="nav-item">
                <a href="javascript:void(0)" class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2" id="all-category">
                    <span class="d-none d-md-block">나의 학습</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="javascript:void(0)" class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2" id="note-business">
                    <span class="d-none d-md-block">공유 학습</span>
                </a>
            </li>
        </ul>
    </div>

    <div class="row row-cols-1 row-cols-md-2 align-items-md-center py-5">
        <div class="col d-flex align-items-start border rounded">
            <img src="/resources/img/myclass/exam01.png" class="me-4 my-3" width="300" height="450"/>
            <div class="d-flex flex-column">
                <div class="border my-3 text-center">제목</div>
                <div class="my-3">Paragraph of text beneath the heading to explain the heading. We'll add onto it with another sentence and probably just keep going until we run out of words.</div>
                <div class="my-3">분야</div>
                <div class="my-3">태그</div>
                <div class="my-3">공유한 사람</div>
            </div>
        </div>
        <div class="col">
            <h4 class="text-center">공유학습</h4>
            <div class="row row-cols-1 row-cols-sm-2">

                <div class="col d-flex flex-column mb-2">
                    <div class="d-inline-flex flex-column align-items-center rounded">
                        <img src="/resources/img/myclass/exam01.png" width="200" height="250" />
                        <div class="d-flex justify-content-between">
                            <div class="">좋아요</div>
                            <div class="">ㅇㅇㅇ님</div>
                        </div>
                    </div>
                </div>

                <div class="col d-flex flex-column">
                    <div class="d-inline-flex flex-column align-items-center rounded">
                        <img src="/resources/img/myclass/exam01.png" width="200" height="250" />
                        <div class="d-flex justify-content-between">
                            <div class="">좋아요</div>
                            <div class="">ㅇㅇ님</div>
                        </div>
                    </div>
                </div>

                <div class="col d-flex flex-column">
                    <div class="d-inline-flex flex-column align-items-center rounded">
                        <img src="/resources/img/myclass/exam01.png" width="200" height="250" />
                        <div class="d-flex justify-content-between">
                            <div class="">좋아요</div>
                            <div class="">ㅇㅇㅇ님</div>
                        </div>
                    </div>
                </div>

                <div class="col d-flex flex-column">
                    <div class="d-inline-flex flex-column align-items-center rounded">
                        <img src="/resources/img/myclass/exam01.png" width="200" height="250" />
                        <div class="d-flex justify-content-between">
                            <div class="">좋아요</div>
                            <div class="">ㅇㅇㅇㅇ님</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../common/footer.jsp"%>
</body>
</html>
