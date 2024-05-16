<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>My Class</title>
</head>
<body>
<%@include file="../common/header.jsp"%>

<div class="container px-4 py-5">
    <%@include file="../common/classHeader.jsp"%>

    <div class="row row-cols-1 row-cols-md-2 align-items-md-center py-5">
        <div class="col d-flex align-items-start justify-content-between border rounded">
            <c:if test="${not empty myclassDTO}">
                <img src="/resources/img/myclass/${myclassDTO.save_file_name}" class="me-4 my-3 border rounded" width="300" height="450"/>
                <div class="d-flex flex-column" style="margin: 0 auto;">
                    <label>제목</label>
                    <div class="border p-2 mb-3 text-center">${myclassDTO.title}</div>
                    <label>내용</label>
                    <p class="border p-2 mb-3">${myclassDTO.content}</p>
                    <label>분야</label>
                    <div class="border p-2 mb-3">${myclassDTO.category}</div>
                    <label>해시태그</label>
                    <div class="border p-2 mb-3">${myclassDTO.tag}</div>
                    <label>공유한 사람</label>
                    <ul class="border p-2">
                        <c:forEach items="${shareList}" var="list">
                            <li class="list-group mb-3">${list}</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <c:if test="${empty myclassDTO}">
                <div>등록된 학습이 없습니다.</div>
            </c:if>
        </div>
        <div class="col">
            <h4 class="text-center">공유받은 학습</h4>
            <c:if test="${not empty receiveList}">
                <div class="row row-cols-1 row-cols-sm-2">
                    <c:forEach items="${receiveList}" var="list">
                        <div class="col d-flex flex-column mb-2">
                            <div class="d-inline-flex flex-column align-items-center rounded">
                                <img src="/resources/img/myclass/${list.save_file_name}" width="200" height="250" />
                                <div class="d-flex justify-content-between" style="width: 200px; font-size: 20px">
                                    <div class="d-flex align-items-center">
                                        <img src="/resources/img/balloon-heart-fill.svg" width="30"/>
                                        <div class="">${list.like_cnt}</div>
                                    </div>
                                    <div class="">${list.share_user_id}님</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty receiveList}">
                <div class="col mb-2 text-center">
                    공유 받은 학습이 없습니다.
                </div>
            </c:if>
        </div>
    </div>
</div>

<%@include file="../common/footer.jsp"%>
</body>
</html>
