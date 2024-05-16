<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>도서 목록</title>

    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/carousel/">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <script src="//code.jquery.com/jquery-3.5.1.min.js" ></script>

</head>
<body style="padding-bottom: 0px;">
<%@ include file="/WEB-INF/common/header.jsp"%>
<section class="py-5">
    <div class="container px-4 px-lg-5">
        <%@ include file="/WEB-INF/common/classHeader.jsp"%>
        <div class="row gx-4 gx-lg-5 align-items-center justify-content-evenly">
            <div class="col-md-6">
                <img class="mb-5 mb-md-0 mx-3" src="<spring:url value='/resources/img/myclass/${myclassDTO.save_file_name}'/>" alt="학습 이미지" width="400" height="600">
            </div>
            <div class="col-md-6 mt-5">
                <div class="">
                    <label for="title" class="form-label">제목</label>
                    <input type="text" class="form-control bg-white" id="title" name="title" value="${myclassDTO.title}" readonly>
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">내용</label>
                    <textarea class="form-control bg-white" id="content" name="content" rows="10" placeholder="내용을 입력하세요." style="resize: none" readonly>${myclassDTO.content}</textarea>
                </div>

                <div class="mb-3" >
                    <span>오늘의 학습 노출 여부</span>
                    <div class="d-flex justify-content-start">
                        <input type="text" class="form-control w-25 me-2 <c:out value="${myclassDTO.display_state == (\"Y\") ? 'bg-black text-white' : 'bg-white text-black'}"></c:out>" id="display_y" name="display_state" value="노출" readonly>
                        <input type="text" class="form-control w-25 <c:out value="${myclassDTO.display_state == (\"N\") ? 'bg-black text-white' : 'bg-white text-black'}"></c:out>" id="display_n" name="display_state" value="노출안함" readonly>
                    </div>
                </div>

                <c:if test="${myclassDTO.display_state == 'Y'}">
                    <div class="mb-3">
                        <span>오늘의 학습 노출 기간 </span>
                        <div class="d-flex align-items-center">
                            <input type="date" class="form-control w-25 bg-white" name="display_start" id="display_start" value="${myclassDTO.display_start}" readonly/>
                            &nbsp;&nbsp;~&nbsp;&nbsp;
                            <input type="date" class="form-control w-25 bg-white" name="display_end" id="display_end" value="${myclassDTO.display_end}" readonly/>
                        </div>
                    </div>
                </c:if>

                <div class="mb-3">
                    <label class="form-label">공유한 사람</label>
                    <div class="d-flex">
                        <ul id="shareMember" class="p-0 m-0">
                            <c:if test="${not empty sharedIdList}">
                                <c:forEach items="${sharedIdList}" var="list">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">${list}</li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                    <div id="div_err_share_id" style="display: none"></div>
                </div>

                <div class="mb-3">
                    <label for="category" class="form-label">분야</label>
                    <input type="text" class="form-control bg-white" id="category" name="category" value="${myclassDTO.category}" readonly>
                </div>

                <div class="mb-3">
                    <label for="tag" class="form-label">해시태그</label>
                    <input type="text" class="form-control bg-white" id="tag" name="tag" value="${myclassDTO.tag}" readonly>
                </div>

                <button type="button" class="btn btn-outline-secondary" onclick="location.href='/myclass/myclass?member_idx=${sessionScope.member_idx}'">목록</button>
                <c:if test="${myclassDTO.member_idx == sessionScope.member_idx}">
                    <button type="button" class="btn btn-outline-primary" onclick="location.href='/myclass/modify?edu_idx=${myclassDTO.edu_idx}'">수정</button>
                    <button type="button" class="btn btn-outline-danger" onclick="goDelete(${myclassDTO.edu_idx})">삭제</button>
                </c:if>
            </div>
        </div>
    </div>
</section>


<script>

    function goDelete(edu_idx) {
        let confirm_flag = Swal.fire({
            title: "해당 학습글을 삭제하겠습니까?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33"
        }).then((result) => {
           if(result.isConfirmed) {
               $.ajax({
                   type: "POST",
                   url: "/myclass/delete",
                   data : {
                       edu_idx : edu_idx
                   },
                   success :function(data) {
                       if(data == "success") {
                           Swal.fire({
                               title: "삭제 성공",
                               text: "해당 학습을 삭제했습니다.",
                               icon: "success"
                           }).then(() => {
                               window.location.href="/myclass/myclass?member_idx=${sessionScope.member_idx}";
                           });
                       }
                   }
               });
           }
        });


        <%--if(confirm_flag) {--%>
        <%--    $.ajax({--%>
        <%--        type: "POST",--%>
        <%--        url: "/myclass/delete",--%>
        <%--        data : {--%>
        <%--            edu_idx : edu_idx--%>
        <%--        },--%>
        <%--        success :function(data) {--%>
        <%--            if(data == "success") {--%>
        <%--                Swal.fire({--%>
        <%--                    title: "삭제 성공",--%>
        <%--                    text: "해당 학습을 삭제했습니다.",--%>
        <%--                    icon: "success"--%>
        <%--                }).then(() => {--%>
        <%--                    window.location.href="/myclass/myclass?member_idx=${sessionScope.member_idx}";--%>
        <%--                });--%>
        <%--            }--%>
        <%--        }--%>
        <%--    });--%>
        <%--}--%>
    }
</script>
<%@ include file="/WEB-INF/common/footer.jsp"%>
</body>
</html>
