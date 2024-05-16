<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>Class Modify</title>
    <meta charset="UTF-8"/>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%@include file="../common/header.jsp"%>

<div class="container-md mt-3">
    <h1 style="text-align: center">학습 수정</h1>
    <form name="frmModify" id="frmModify" method="post" action="/myclass/modify" enctype="multipart/form-data">
        <input type="hidden" name="member_idx" value="${sessionScope.member_idx}"/>
        <input type="hidden" name="user_id" value="${sessionScope.user_id}"/>
        <input type="hidden" name="edu_idx" value="${myclassDTO.edu_idx}"/>
        <input type="hidden" name="org_file_name" value="${myclassDTO.org_file_name}"/>
        <input type="hidden" name="save_file_name" value="${myclassDTO.save_file_name}"/>

        <div class="mb-3">
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" value="${myclassDTO.title}" placeholder="제목" maxlength="100">
            <div id="div_err_title" style="display: none"></div>
        </div>

        <div class="mb-3">
            <label for="content" class="form-label">내용</label>
            <textarea class="form-control" id="content" name="content" rows="10" placeholder="내용을 입력하세요.">${myclassDTO.content}</textarea>
            <div id="div_err_content" style="display: none;"></div>
        </div>

        <div class="mb-3">
            <c:if test="${not empty myclassDTO.org_file_name}">
                <label class="form-label">이미지</label>
                <label for="file" id="org_file_name" class="form-control">${myclassDTO.org_file_name}</label>
                <input type="file" class="form-control" id="file" name="file" accept=".jpg, .png" onchange="previewImg(this)" oncancel="cancelFile(this)" hidden>
                <img id="preview" width="300" height="450" src="/resources/img/myclass/${myclassDTO.save_file_name}">
                <div id="div_err_file" style="display: none"></div>
            </c:if>
            <c:if test="${empty myclassDTO.org_file_name}">
                <label for="file" class="form-label">이미지</label>
                <input type="file" class="form-control" id="file" name="file" value="${myclassDTO.save_file_name}" accept=".jpg, .png" onchange="previewImg(this)">
                <img id="preview" width="300" height="450" style="display: none">
                <div id="div_err_file" style="display: none"></div>
            </c:if>
        </div>

        <div class="mb-3" >
            <span>오늘의 학습 노출 여부</span>
            <input type="radio" class="btn-check" id="display_y" name="display_state" value="Y" <c:out value="${myclassDTO.display_state == (\"Y\") ? 'checked' : ''}"></c:out>>
            <label class="btn btn-outline-dark" for="display_y">노출</label>

            <input type="radio" class="btn-check" id="display_n" name="display_state" value="N" <c:out value="${myclassDTO.display_state == (\"N\") ? 'checked' : ''}"></c:out>>
            <label class="btn btn-outline-dark" for="display_n">노출 안함</label>
        </div>
        <div id="div_err_display_state" style="display: none;"></div>

        <div id="display_date" class="mb-3" style="<c:out value="${myclassDTO.display_state == (\"Y\") ? '' : 'display:none'}"></c:out>">
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
                <ul id="shareMember" class="me-3 p-0">
                    <c:if test="${not empty sharedIdList}">
                        <c:forEach items="${sharedIdList}" var="list">
                            <li class='list-group-item d-flex justify-content-between align-items-center'>
                                <input type='text' class='border-0' name='shared_id' value="${list}" readonly>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty sharedIdList}">
                        <div>공유한 사람이 없습니다.</div>
                    </c:if>
                </ul>
                <button type="button" class="btn btn-secondary" onclick="openPopup();">공유하기</button>
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
            <button class="btn btn-primary" type="submit">학습 수정</button>
            <button class="btn btn-secondary" type="button" onclick="location.href='/myclass/view?edu_idx=${myclassDTO.edu_idx}'">이전으로</button>
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

    // 기존 파일 값 넣기


    // 기존 파일에서 취소 이벤트
    function cancelFile(input) {
        if(input.value.length < 1) {
            document.getElementById("preview").src = "";
            document.getElementById("preview").style.display = "none";
            document.getElementById("org_file_name").innerHTML = "<div style='color:red;'>선택된 파일이 없으면 기본 이미지가 적용됩니다.</div>";
        }
    }

    // 파일 이미지 미리보기
    function previewImg(input) {
        if(input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                console.log(e);
                document.getElementById("preview").src = e.target.result;
                document.getElementById("preview").style.display = "";
                document.getElementById("org_file_name").innerText = input.files[0].name;
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            document.getElementById("preview").src = "";
            document.getElementById("preview").style.display = "none";
            document.getElementById("org_file_name").innerHTML = "<div style='color:red;'>선택된 파일이 없으면 기본 이미지가 적용됩니다.</div>";
        }
    }

    // 공유하기 팝업
    function openPopup() {
        let pop = window.open("/myclass/sharing", "searchMember", "width=1000 height=700");
    }

    // 공유할 사람 리스트
    function setCheckList(arrMember) {
        $('#shareMember').empty();
        for(let i=0; i<arrMember.length; i++) {
            $('#shareMember').attr("style", "display:''");

            $('#shareMember').append(
                "<li class='list-group-item d-flex justify-content-between align-items-center'>"
                + "<input type='text' class='border-0' name='shared_id' value='"+arrMember[i]+"' readonly></input>"
                + "</li>"
            );
        }
    }

    $('#display_y').on("click", function() {
        $('#display_date').attr("style", "display:''");
    });

    $('#display_n').on("click", function() {
        $('#display_date').attr("style", "display:none");
    });
</script>

<%@include file="../common/footer.jsp"%>
</body>
</html>
