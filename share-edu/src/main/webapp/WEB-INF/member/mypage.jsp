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
                    <h1 class="h2">마이페이지</h1>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="m-sm-4">
                            <form name="frmJoin" id="frmJoin" method="post" action="/member/join">
                                <div class="form-group">
                                    <label for="user_id">아이디</label>
                                        <input class="form-control form-control-lg me-2" type="text" name="user_id" id="user_id" value="${memberDTO.user_id}" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="name">이름</label>
                                    <input class="form-control form-control-lg" type="text" name="name" id="name" value="${memberDTO.name}" readonly>
                                    <div id="div_err_name" style="display: none"></div>
                                </div>

                                <div class="form-group">
                                    <label for="pwd">비밀번호</label>
                                    <input class="form-control form-control-lg" type="password" name="pwd" id="pwd" value="">
                                    <div id="div_err_pwd" style="display: none"></div>
                                </div>

                                <div class="form-group">
                                    <label for="pwd">비밀번호</label>
                                    <input class="form-control form-control-lg" type="password" name="pwd2" id="pwd2" value="" >
                                    <div id="div_err_pwd2" style="display: none"></div>
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

                                <div class="form-group">
                                    <label for="email">이메일</label>
                                        <input class="form-control form-control-lg me-2" type="email" name="email" id="email" value="${memberDTO.email}" placeholder="Enter your Email">
                                    <div id="div_err_email" style="display: none"></div>
                                </div>

                                <div class="d-flex justify-content-lg-evenly mt-3">
                                    <button type="button" id="modifyBtn" class="btn btn-lg btn-primary w-25">수정</button>
                                    <button type="button" id="cancelBtn" class="btn btn-lg btn-primary w-25">취소</button>
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
    let pwd = $('#pwd');
    let pwd2 = $('#pwd2');
    let pwdRegexp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;

    // 새 비밀번호 조건에 맞는지 체크
    pwd.on("keyup", function(e) {
        // 아이디와 일치 확인
        if(pwd.val() != "${memberDTO.user_id}") {
            $('#new_pwd_msg').text("");
            $('#new_pwd_check').attr("src", "/resources/img/lock-fill.svg");
            $('#new_checkbox').prop("checked", true);
        } else {
            $('#new_pwd_msg').text("아이디와 동일한 패스워드는 사용할 수 없습니다.");
            $('#new_pwd_msg').css({"color": "red", "marginBottom": "20px"});
            $('#new_pwd_check').attr("src", "/resources/img/unlock-fill.svg");
            $('#new_checkbox').prop("checked", false);
            return;
        }

        // 기존 비밀번호 동일 여부 확인
        if(pwd.val() != "${pwd}") {
            $('#new_pwd_msg').text("");
            $('#new_pwd_check').attr("src", "/resources/img/lock-fill.svg");
            $('#new_checkbox').prop("checked", true);
        } else {
            $('#new_pwd_msg').text("기존과 동일한 패스워드는 사용할 수 없습니다.");
            $('#new_pwd_msg').css({"color": "red", "marginBottom": "20px"});
            $('#new_pwd_check').attr("src", "/resources/img/unlock-fill.svg");
            $('#new_checkbox').prop("checked", false);
            return;
        }

        // 비밀번호 조건 확인
        if(pwdRegexp.test(pwd.val())) {
            $('#new_pwd_msg').text("");
            $('#new_pwd_check').attr("src", "/resources/img/lock-fill.svg");
            $('#new_checkbox').prop("checked", true);
        } else {
            $('#new_pwd_msg').text("영문 + 숫자 + 특수문자 조합으로 최소 8자리 이상만 허용됩니다.");
            $('#new_pwd_msg').css({"color": "red", "marginBottom": "20px"});
            $('#new_pwd_check').attr("src", "/resources/img/unlock-fill.svg");
            $('#new_checkbox').prop("checked", false);
        }

        // 비밀번호 일치 확인
        if(pwd.val() == pwd2.val() && pwd.val().length != 0) {
            $('#new_pwd_msg2').text("");
            $('#new_pwd_check2').attr("src", "/resources/img/lock-fill.svg");
            $('#new_checkbox2').prop("checked", true);
        } else {
            $('#new_pwd_msg2').text("비밀번호가 일치하지 않습니다.");
            $('#new_pwd_msg2').css({"color": "red", "marginBottom": "20px"});
            $('#new_pwd_check2').attr("src", "/resources/img/unlock-fill.svg");
            $('#new_checkbox2').prop("checked", false);
        }
    });

    // 비밀번호 확인 일치하는지 체크
    pwd2.on("keyup", function(e) {
        if(pwd2.val() == pwd.val() && pwd2.val().length != 0) {
            $('#new_pwd_msg2').text("");
            $('#new_pwd_check2').attr("src", "/resources/img/lock-fill.svg");
            $('#new_checkbox2').prop("checked", true);
        } else {
            $('#new_pwd_msg2').text("비밀번호가 일치하지 않습니다.");
            $('#new_pwd_msg2').css({"color": "red", "marginBottom": "20px"});
            $('#new_pwd_check2').attr("src", "/resources/img/unlock-fill.svg");
            $('#new_checkbox2').prop("checked", false);
        }
    });
</script>
</body>
</html>
