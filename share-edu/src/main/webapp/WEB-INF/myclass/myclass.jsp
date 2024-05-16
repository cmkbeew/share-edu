<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8"/>

    <style>
        #top {
            text-align: center;
        }
        #view {
            text-decoration: none;
            color: black;
        }
        #view:hover {
            color: blue;
            font-size: 18px;
        }
    </style>
</head>
<body>
<%@include file="../common/header.jsp"%>
<div class="container px-4 py-5">
    <%@include file="../common/classHeader.jsp"%>
    <div id="top" class="mt-4">
        <form id="frmSearch" name="frmSearch" method="get" action="/myclass/myclass">
            <input type="hidden" name="member_idx" value="${sessionScope.member_idx}">
            <div class="d-flex justify-content-center align-items-center">
                <div class="mx-5 my-3">
                    <span>검색 범위 : </span>
                    <input class="form-check-input" type="checkbox" value="title" id="search_type_0" name="search_type"
                    <c:forEach items="${responseDTO.search_type}" var="dto">
                    <c:if test ="${fn:contains(dto,'title' )}">
                           checked
                    </c:if>
                    </c:forEach>
                    >
                    <label class="form-check-label" for="search_type_0">
                        제목
                    </label>
                    <input class="form-check-input" type="checkbox" value="content" id="search_type_1" name="search_type"
                    <c:forEach items="${responseDTO.search_type}" var="dto">
                    <c:if test ="${fn:contains(dto,'content' )}">
                           checked
                    </c:if>
                    </c:forEach>
                    >
                    <label class="form-check-label" for="search_type_1">
                        내용
                    </label>
                </div>
                <div>
                    <input class="form-control form-control-lg me-2" type="search" placeholder="Search" aria-label="Search" name="search_word" id="search_word" value="${responseDTO.search_word}">
                </div>
            </div>
            <div class="d-flex justify-content-center align-items-center ">
                <span class="mx-3 my-3">검색 기간 : </span>
                <input class="form-control form-control-lg w-25" type="date" name="search_date1" id="search_date1" value="${responseDTO.search_date1}" >
                &nbsp;&nbsp;~&nbsp;&nbsp;
                <input class="form-control form-control-lg w-25" type="date" name="search_date2" id="search_date2" value="${responseDTO.search_date2}" >
            </div>

            <button class="btn btn-primary" type="submit" id="btn_search">검색</button>
            <button class="btn btn-outline-danger" type="reset">초기화</button>
        </form>

        <div class="mb-3" style="text-align: right">
            <button type="button" class="btn btn-primary" onclick="location.href='/myclass/regist'">글 등록</button>
            <button type="button" class="btn btn-secondary" onclick="location.href='/myclass/home?member_idx=${sessionScope.member_idx}'">홈으로</button>
        </div>
    </div>

    <div class="mb-3">
        <table class="table">
            <thead>
                <tr class="text-center">
                    <th scope="col">글번호</th>
                    <th scope="col" class="w-50">제목</th>
                    <th scope="col">등록일</th>
                    <th scope="col">좋아요</th>
                    <th scope="col">오늘의 학습 노출 여부</th>
                    <th scope="col">오늘의 학습 노출 기간</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="list" items="${responseDTO.dtoList}">

                    <tr class="text-center">
                        <td>${list.edu_idx}</td>
                        <td class="text-start"><a href="/myclass/view?edu_idx=${list.edu_idx}" class="text-decoration-none">${list.title}</a></td>
                        <td>${list.reg_date}</td>
                        <td>${list.like_cnt}</td>
                        <td>${list.display_state}</td>
                        <td>${list.display_start} ~ ${list.display_end}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <%@include file="/WEB-INF/common/paging.jsp"%>
</div>
<script>
    document.getElementById("btn_search").addEventListener("click", function (e) {
        e.preventDefault();
        e.stopPropagation();

        let type1 = document.getElementById("search_type_0").checked;
        let type2 = document.getElementById("search_type_1").checked;
        let word = document.getElementById("search_word").value;

        if(word != null || word != "" || word.length != 0) {
            if (type1 || type2) {
                document.getElementById("frmSearch").submit();
                return;
            } else {
                Swal.fire({
                    title: "검색 실패",
                    text: "검색 범위를 선택하세요.",
                    icon: "error"
                });
            }
        } else {
            Swal.fire({
                title: "검색 실패",
                text: "검색어를 입력하세요.",
                icon: "error"
            });
        }
    });
</script>
<%@include file="../common/footer.jsp"%>
</body>
</html>
