<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>Class Regist</title>
    <meta charset="UTF-8"/>

</head>
<body>
<%@include file="../common/header.jsp"%>

<div class="container-md mt-3">
    <h1 style="text-align: center">학습 등록</h1>
    <form name="frmRegist" id="frmRegist" method="post" action="/myclass/regist" enctype="multipart/form-data">
        <input type="hidden" name="member_idx" value="${sessionScope.member_idx}"/>

        <div class="mb-3">
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" value="${myclassDTO.title}" placeholder="제목">
            <div id="div_err_title" style="display: none"></div>
        </div>

        <div class="mb-3">
            <label for="content" class="form-label">내용</label>
            <textarea class="form-control" id="content" name="content" rows="3" placeholder="내용을 입력하세요.">${myclassDTO.content}</textarea>
            <div id="div_err_content" style="display: none;"></div>
        </div>

        <div class="mb-3">
            <label for="file" class="form-label">이미지</label>
            <input type="file" class="form-control" id="file" name="file" value="${myclassDTO.org_file_name}" accept=".jpg, .png" onchange="previewImg(this)">
            <img id="preview" width="300" height="450" style="display: none">
            <div id="div_err_file" style="display: none"></div>
        </div>

        <div class="mb-3" >
            <span>오늘의 학습 노출 여부</span>
            <input type="radio" class="btn-check" id="display_y" name="display_state" value="Y" <c:out value="${myclassDTO.display_state == (\"Y\") ? 'checked' : ''}"></c:out>>
            <label class="btn btn-outline-dark" for="display_y">노출</label>

            <input type="radio" class="btn-check" id="display_n" name="display_state" value="N" <c:out value="${myclassDTO.display_state == (\"N\") ? 'checked' : ''}"></c:out>>
            <label class="btn btn-outline-dark" for="display_n">노출 안함</label>
        </div>
        <div id="div_err_display_state" style="display: none;"></div>

        <div class="mb-3">
            <span>오늘의 학습 노출 기간 </span>
            <div class="d-flex align-items-center">
            <input type="date" class="form-control w-25" name="display_start" id="display_start" value="${myclassDTO.display_start}" />
                &nbsp;&nbsp;~&nbsp;&nbsp;
            <input type="date" class="form-control w-25" name="display_end" id="display_end" value="${myclassDTO.display_end}" />
            </div>
            <div id="div_err_display_start" style="display: none;"></div>
            <div id="div_err_display_end" style="display: none;"></div>
        </div>

        <div class="mb-3">
            <label class="form-label">공유한 사람</label>
            <div class="d-flex">
                <ul id="shareMember" class="me-3">
                    <li>이름 + 공유날짜</li>
                    <li>이름 + 공유날짜</li>
                </ul>
<%--                <input type="text" class="form-control w-50 me-3" id="share_id" name="share_id" value="${myclassDTO.share_id}">--%>
                <button class="btn btn-secondary" onclick="openPopup();return false;">공유하기</button>
            </div>
            <div id="div_err_share_id" style="display: none"></div>
        </div>

        <div class="mb-3">
            <label for="category" class="form-label">분야</label>
            <input type="text" class="form-control" id="category" name="category" value="${myclassDTO.category}">
            <div id="div_err_category" style="display: none"></div>
        </div>

        <div class="mb-3">
            <label for="tag" class="form-label">해시태그</label>
            <input type="text" class="form-control" id="tag" name="tag" value="${myclassDTO.tag}">
            <div id="div_err_tag" style="display: none"></div>
        </div>

        <div class="d-grid gap-2">
            <button class="btn btn-primary" type="submit">글 등록</button>
            <button class="btn btn-secondary" type="button" onclick="location.href='/bbs/list'">게시판 목록</button>
        </div>
    </form>
</div>

<script>
    const serverValidResult = {};
    <c:forEach items="${errors}" var="err">
    if(document.getElementById("div_err_${err.getField()}") != null) {
        document.getElementById("div_err_${err.getField()}").innerHTML = "<span style='color:red;'>${err.defaultMessage}</span>";
        document.getElementById("div_err_${err.getField()}").style.display = "block";
    }
    serverValidResult['${err.getField()}'] = '${err.defaultMessage}';
    </c:forEach>

    // 파일 이미지 미리보기
    function previewImg(input) {
        if(input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("preview").src = e.target.result;
                document.getElementById("preview").style.display = "";
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            document.getElementById("preview").src = "";
            document.getElementById("preview").style.display = "none";
        }
    }

    // 공유하기 팝업
    function openPopup() {
        let pop = window.open("/myclass/sharing", "searchMember", "width=1000 height=700");
    }

    function setCheckList(arrMember) {
        console.log(arrMember);
        // TODO: 찾아온 idx 기반으로 member + now() 찾아오기
    }
</script>

<%@include file="../common/footer.jsp"%>
</body>
</html>
