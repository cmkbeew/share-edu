<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>회원가입 페이지</title>
    <meta charset="UTF-8"/>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%@include file="../common/header.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table">
            <div class="d-table-cell">
                <div class="text-center mb-4">
                    <h1 class="h2">회원가입</h1>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="m-sm-4">
                            <form name="frmJoin" id="frmJoin" method="post" action="/member/join">
                                <div class="form-group">
                                    <label for="user_id">아이디</label>
                                    <div class="d-flex">
                                        <input class="form-control form-control-lg me-2" type="text" name="user_id" id="user_id" value="${memberDTO.user_id}" placeholder="Enter your ID">
                                        <input class="btn btn-lg btn-outline-secondary" id="user_id_check" type="button" value="중복 확인" onclick="duplicateId()">
                                    </div>
                                    <div id="div_err_user_id" style="display: none"></div>
                                </div>
                                <div class="form-group">
                                    <label for="pwd">비밀번호</label>
                                    <input class="form-control form-control-lg" type="password" name="pwd" id="pwd" value="${memberDTO.pwd}" placeholder="Enter your Password">
                                    <div id="div_err_pwd" style="display: none"></div>
                                </div>
                                <div class="form-group">
                                    <label for="name">이름</label>
                                    <input class="form-control form-control-lg" type="text" name="name" id="name" value="${memberDTO.name}" placeholder="Enter your Name">
                                    <div id="div_err_name" style="display: none"></div>
                                </div>
                                <div class="form-group">
                                    <label for="email">이메일</label>
                                    <div class="d-flex">
                                        <input class="form-control form-control-lg me-2" type="email" name="email" id="email" value="${memberDTO.email}" placeholder="Enter your Email">
                                        <input class="btn btn-lg btn-outline-secondary" id="email_check" type="button" value="중복 확인" onclick="duplicateEmail()">
                                    </div>
                                    <div id="div_err_email" style="display: none"></div>
                                </div>

                                <label>휴대폰번호</label>
                                <div class="form-group d-flex justify-content-evenly">
                                    <select class="form-select form-select-lg me-2" name="phone1" id="phone1">
                                        <option value="010" <c:if test="${memberDTO.phone1 == '010'}">selected</c:if>>010</option>
                                        <option value="011" <c:if test="${memberDTO.phone1 == '011'}">selected</c:if>>011</option>
                                        <option value="016" <c:if test="${memberDTO.phone1 == '016'}">selected</c:if>>016</option>
                                        <option value="017" <c:if test="${memberDTO.phone1 == '017'}">selected</c:if>>017</option>
                                        <option value="018" <c:if test="${memberDTO.phone1 == '018'}">selected</c:if>>018</option>
                                    </select>
                                    <input class="form-control form-control-lg me-2" type="text" name="phone2" id="phone2" value="${memberDTO.phone2}" maxlength="4">
                                    <input class="form-control form-control-lg me-2" type="text" name="phone3" id="phone3" value="${memberDTO.phone3}" maxlength="4">
                                </div>
                                <div id="div_err_phone1" style="display: none"></div>
                                <div id="div_err_phone2" style="display: none"></div>
                                <div id="div_err_phone3" style="display: none"></div>

                                <div class="text-center mt-3">
                                    <button type="button" id="registBtn" class="btn btn-lg btn-primary">회원가입</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<%@include file="../common/footer.jsp"%>
<script>
    const serverValidResult = {};
    <c:forEach items="${errors}" var="err">
    if(document.getElementById("div_err_${err.getField()}") != null) {
        document.getElementById("div_err_${err.getField()}").innerHTML = "<span style='color:red;'>${err.defaultMessage}</span>";
        document.getElementById("div_err_${err.getField()}").style.display = "block";
    }
    serverValidResult['${err.getField()}'] = '${err.defaultMessage}';
    </c:forEach>

    function swal(msg) {
        Swal.fire({
            icon: "error",
            title: "중복확인 실패",
            text: msg,
            confirmButtonColor: "#3085d6"
        });
    }

    function duplicateId() {
        let user_id = $('#user_id').val();
        const idRegexp = /^[a-z0-9]{4,12}/;

        if(user_id == '' || user_id.length == 0 || user_id == null) {
            $('#user_id').focus();
            swal("아이디를 입력하세요.");
            return;
        }
        if(!idRegexp.test(user_id)) {
            $('#user_id').focus();
            swal("4~12자 이내의 영어 소문자 및 숫자만 입력이 가능합니다.");
            return;
        }

        $.ajax({
            url: "/member/duplicateId",
            type: "post",
            data: {
                user_id : user_id
            },
            success: function(result) {
                if(result == "idCheck") {
                    $('#user_id').focus();
                    swal("이미 가입된 아이디입니다.");

                } else if(result == "pass") {
                    Swal.fire({
                        title: "사용가능한 아이디입니다.\r\n사용하시겠습니까?",
                        icon: "question",
                        showCancelButton: true,
                        confirmButtonColor: "#3085d6",
                        cancelButtonColor: "#d33",
                        confirmButtonText: "사용",
                        cancelButtonText: "취소"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $('#user_id_check').attr("disabled", true);
                            $('#user_id').attr("readonly", true);
                        }
                    });
                }
            }
        });
    }

    function duplicateEmail() {
        let email = $('#email').val();
        const emailRegexp = /^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$/;

        if(email == '' || email.length == 0 || email == null) {
            $('#email').focus();
            swal("이메일을 입력하세요.");
            return;
        }
        if(!emailRegexp.test(email)) {
            $('#email').focus();
            swal("이메일 형식에 맞춰 입력하세요.");
            return;
        }

        $.ajax({
            url: "/member/duplicateEmail",
            type: "post",
            data: {
                email : email
            },
            success: function(result) {
                if(result == "emailCheck") {
                    $('#email').focus();
                    swal("이미 가입된 이메일입니다.");
                } else if(result == "pass") {
                    Swal.fire({
                        title: "사용가능한 이메일입니다.\r\n사용하시겠습니까?",
                        icon: "question",
                        showCancelButton: true,
                        confirmButtonColor: "#3085d6",
                        cancelButtonColor: "#d33",
                        confirmButtonText: "사용",
                        cancelButtonText: "취소"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $('#email_check').attr("disabled", true);
                            $('#email').attr("readonly", true);
                        }
                    });
                }
            }
        });
    }

    $('#registBtn').click(function() {
        const frm = $('#frmJoin');
        if($('#user_id_check').prop("disabled") && $('#email_check').prop("disabled")) {
            frm.submit();
        }else {
            swal("중복 확인을 완료해주세요.");
        }
    });
</script>
</body>
</html>
