<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>비밀번호 변경</title>
    <meta charset="UTF-8"/>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%@include file="../common/header.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table h-100">
            <div class="d-table-cell align-middle">
                <div class="text-center mt-4">
                    <h1 class="h3">개인정보 보호를 위해 비밀번호를 변경해주세요.</h1>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="m-sm-3">
                            <form action="/login/changePwd" method="post">
                                <input type="hidden" name="user_id" value="${user_id}" />
                                <label>이전 비밀번호</label>
                                <div class="form-group d-flex justify-content-around mb-3">
                                    <input class="form-control form-control-lg me-3" type="password" name="old_pwd" id="old_pwd">
                                    <img src="/resources/img/unlock-fill.svg" width="30" id="old_pwd_check"/>
                                    <input type="checkbox" id="old_checkbox" hidden/>
                                </div>
                                <div id="old_pwd_msg"></div>

                                <label>새 비밀번호</label>
                                <div class="form-group d-flex justify-content-around mb-3">
                                    <input class="form-control form-control-lg me-3" type="password" name="new_pwd" id="new_pwd">
                                    <img src="/resources/img/unlock-fill.svg" width="30" id="new_pwd_check"/>
                                    <input type="checkbox" id="new_checkbox" hidden/>
                                </div>
                                <div id="new_pwd_msg"></div>

                                <label>비밀번호 확인</label>
                                <div class="form-group d-flex justify-content-around mb-3">
                                    <input class="form-control form-control-lg me-3" type="password" name="new_pwd2" id="new_pwd2">
                                    <img src="/resources/img/unlock-fill.svg" width="30" id="new_pwd_check2" />
                                    <input type="checkbox" id="new_checkbox2" hidden/>
                                </div>
                                <div id="new_pwd_msg2"></div>

                                <div class="d-flex justify-content-lg-evenly">
                                    <button type="submit" class="btn btn-lg w-25 btn-primary" id="changeBtn" disabled>확인</button>
                                    <button type="button" class="btn btn-lg w-25 btn-primary" onclick="location.href='/login/login'">취소</button>
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
    let old = $('#old_pwd');
    let newPwd = $('#new_pwd');
    let newPwd2 = $('#new_pwd2');
    let pwdRegexp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;

    old.on("keyup", function(e) {
        // 기존 패스워드와 일치여부 판단
        if(old.val() == "${pwd}") {
            $('#old_pwd_msg').text("");
            $('#old_pwd_check').attr("src", "/resources/img/lock-fill.svg");
            $('#old_checkbox').prop("checked", true);
            allCheck();
        } else {
            $('#old_pwd_msg').text("이전 비밀번호가 일치하지 않습니다.");
            $('#old_pwd_msg').css({"color": "red", "marginBottom": "20px"});
            $('#old_pwd_check').attr("src", "/resources/img/unlock-fill.svg");
            $('#old_checkbox').prop("checked", false);
            allCheck();
        }
    });

    // 새 비밀번호 조건에 맞는지 체크
    newPwd.on("keyup", function(e) {
        // 아이디와 일치 확인
        if(newPwd.val() != "${user_id}") {
            $('#new_pwd_msg').text("");
            $('#new_pwd_check').attr("src", "/resources/img/lock-fill.svg");
            $('#new_checkbox').prop("checked", true);
            allCheck();
        } else {
            $('#new_pwd_msg').text("아이디와 동일한 패스워드는 사용할 수 없습니다.");
            $('#new_pwd_msg').css({"color": "red", "marginBottom": "20px"});
            $('#new_pwd_check').attr("src", "/resources/img/unlock-fill.svg");
            $('#new_checkbox').prop("checked", false);
            allCheck();
            return;
        }

        // 기존 비밀번호 동일 여부 확인
        if(newPwd.val() != "${pwd}") {
            $('#new_pwd_msg').text("");
            $('#new_pwd_check').attr("src", "/resources/img/lock-fill.svg");
            $('#new_checkbox').prop("checked", true);
            allCheck();
        } else {
            $('#new_pwd_msg').text("기존과 동일한 패스워드는 사용할 수 없습니다.");
            $('#new_pwd_msg').css({"color": "red", "marginBottom": "20px"});
            $('#new_pwd_check').attr("src", "/resources/img/unlock-fill.svg");
            $('#new_checkbox').prop("checked", false);
            allCheck();
            return;
        }

        // 비밀번호 조건 확인
        if(pwdRegexp.test(newPwd.val())) {
            $('#new_pwd_msg').text("");
            $('#new_pwd_check').attr("src", "/resources/img/lock-fill.svg");
            $('#new_checkbox').prop("checked", true);
            allCheck();
        } else {
            $('#new_pwd_msg').text("영문 + 숫자 + 특수문자 조합으로 최소 8자리 이상만 허용됩니다.");
            $('#new_pwd_msg').css({"color": "red", "marginBottom": "20px"});
            $('#new_pwd_check').attr("src", "/resources/img/unlock-fill.svg");
            $('#new_checkbox').prop("checked", false);
            allCheck();
        }

        // 비밀번호 일치 확인
        if(newPwd.val() == newPwd2.val() && newPwd.val().length != 0) {
            $('#new_pwd_msg2').text("");
            $('#new_pwd_check2').attr("src", "/resources/img/lock-fill.svg");
            $('#new_checkbox2').prop("checked", true);
            allCheck();
        } else {
            $('#new_pwd_msg2').text("비밀번호가 일치하지 않습니다.");
            $('#new_pwd_msg2').css({"color": "red", "marginBottom": "20px"});
            $('#new_pwd_check2').attr("src", "/resources/img/unlock-fill.svg");
            $('#new_checkbox2').prop("checked", false);
            allCheck();
        }
    });

    // 비밀번호 확인 일치하는지 체크
    newPwd2.on("keyup", function(e) {
        if(newPwd2.val() == newPwd.val() && newPwd2.val().length != 0) {
            $('#new_pwd_msg2').text("");
            $('#new_pwd_check2').attr("src", "/resources/img/lock-fill.svg");
            $('#new_checkbox2').prop("checked", true);
            allCheck();
        } else {
            $('#new_pwd_msg2').text("비밀번호가 일치하지 않습니다.");
            $('#new_pwd_msg2').css({"color": "red", "marginBottom": "20px"});
            $('#new_pwd_check2').attr("src", "/resources/img/unlock-fill.svg");
            $('#new_checkbox2').prop("checked", false);
            allCheck();
        }
    });

    function allCheck() {
        if($('#old_checkbox').prop("checked") && $('#new_checkbox').prop("checked") && $('#new_checkbox2').prop("checked")) {
            $('#changeBtn').prop("disabled", false);
        } else {
            $('#changeBtn').prop("disabled", true);
        }
    }


</script>
</body>
</html>
