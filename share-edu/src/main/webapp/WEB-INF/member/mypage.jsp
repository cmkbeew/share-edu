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
                            <form name="frmModify" id="frmModify" method="post" action="/member/mypage">
                                <div class="form-group">
                                    <label for="user_id">아이디</label>
                                    <input class="form-control form-control-lg me-2" type="text" name="user_id" id="user_id" value="${memberDTO.user_id}" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="name">이름</label>
                                    <input class="form-control form-control-lg" type="text" name="name" id="name" value="${memberDTO.name}" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="pwd">비밀번호</label>
                                    <input class="form-control form-control-lg" type="password" name="pwd" id="pwd" value="">
                                    <div id="pwd_msg"></div>
                                    <div id="div_err_pwd" style="display: none"></div>
                                </div>

                                <div class="form-group">
                                    <label for="pwd">비밀번호</label>
                                    <input class="form-control form-control-lg" type="password" name="pwd2" id="pwd2" value="" >
                                    <div id="pwd_msg2"></div>
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
                                <div id="phone2_msg"></div>
                                <div id="phone3_msg"></div>
                                <div id="div_err_phone2" style="display: none"></div>
                                <div id="div_err_phone3" style="display: none"></div>

                                <div class="form-group">
                                    <label for="email">이메일</label>
                                    <div class="d-flex">
                                        <input class="form-control form-control-lg me-2" type="email" name="email" id="email" value="${memberDTO.email}" placeholder="Enter your Email">
                                        <input class="btn btn-lg btn-outline-secondary" id="email_check" type="button" value="중복 확인" onclick="duplicateEmail()">
                                    </div>
                                    <div id="email_msg"></div>
                                    <div id="div_err_email" style="display: none"></div>
                                </div>

                                <div class="d-flex justify-content-lg-evenly mt-3">
                                    <button type="submit" id="modifyBtn" class="btn btn-lg btn-primary w-25">수정</button>
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
    const serverValidResult = {};
    <c:forEach items="${errors}" var="err">
    if(document.getElementById("div_err_${err.getField()}") != null) {
        document.getElementById("div_err_${err.getField()}").innerHTML = "<span style='color:red;'>${err.defaultMessage}</span>";
        document.getElementById("div_err_${err.getField()}").style.display = "block";
    }
    serverValidResult['${err.getField()}'] = '${err.defaultMessage}';
    </c:forEach>


    let pwd = $('#pwd');
    let pwd2 = $('#pwd2');
    let pwdRegexp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;

    let phone2 = $('#phone2');
    let phone2_msg = $('#phone2_msg');
    let phone2Regexp = /^[1-9]{1}[0-9]{3}$/;
    let phone3 = $('#phone3');
    let phone3_msg = $('#phone3_msg');
    let phone3Regexp = /^[0-9]{4}$/;
    let email = $('#email');
    let email_msg = $('#email_msg');
    let emailRegexp = /^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$/;


    // 새 비밀번호 조건에 맞는지 체크
    pwd.on("keyup", function(e) {
        // 아이디와 일치 확인
        if(pwd.val() != "${memberDTO.user_id}") {
            $('#pwd_msg').text("");
        } else {
            $('#pwd_msg').text("아이디와 동일한 패스워드는 사용할 수 없습니다.");
            $('#pwd_msg').css({"color": "red", "marginBottom": "10px"});
            return;
        }

        // 기존 비밀번호 동일 여부 확인
        if(pwd.val() != "${memberDTO.pwd}") {
            $('#pwd_msg').text("");
        } else {
            $('#pwd_msg').text("기존과 동일한 패스워드는 사용할 수 없습니다.");
            $('#pwd_msg').css({"color": "red", "marginBottom": "10px"});
            return;
        }

        // 비밀번호 조건 확인
        if(pwdRegexp.test(pwd.val())) {
            $('#pwd_msg').text("");
        } else {
            $('#pwd_msg').text("영문 + 숫자 + 특수문자 조합으로 최소 8자리 이상만 허용됩니다.");
            $('#pwd_msg').css({"color": "red", "marginBottom": "20px"});
        }

        // 비밀번호 일치 확인
        if(pwd.val() == pwd2.val() && pwd.val().length != 0) {
            $('#pwd_msg2').text("");
        } else {
            $('#pwd_msg2').text("비밀번호가 일치하지 않습니다.");
            $('#pwd_msg2').css({"color": "red", "marginBottom": "10px"});
        }
    });

    // 비밀번호 확인 일치하는지 체크
    pwd2.on("keyup", function(e) {
        if(pwd2.val() == pwd.val() && pwd2.val().length != 0) {
            $('#pwd_msg2').text("");
        } else {
            $('#pwd_msg2').text("비밀번호가 일치하지 않습니다.");
            $('#pwd_msg2').css({"color": "red", "marginBottom": "10px"});
        }
    });

    // 휴대폰 번호 확인
    phone2.on("keyup", function() {
        if(phone2Regexp.test(phone2.val())) {
            phone2_msg.text("");
        } else {
            phone2_msg.text("가운데 번호 형식에 맞춰 입력하세요");
            phone2_msg.css({"color": "red", "marginBottom": "20px"});
        }
    });
    phone3.on("keyup", function() {
        if(phone3Regexp.test(phone3.val())) {
            phone3_msg.text("");
        } else {
            phone3_msg.text("끝 번호 형식에 맞춰 입력하세요");
            phone3_msg.css({"color": "red", "marginBottom": "20px"});
        }
    });
    email.on("keyup", function() {
        if(emailRegexp.test(email.val())) {
            email_msg.text("");
        } else {
            email_msg.text("이메일 형식에 맞춰 입력하세요");
            email_msg.css({"color": "red", "marginBottom": "20px"});
        }
    });

    function swal(title, msg) {
        Swal.fire({
            icon: "error",
            title: title,
            text: msg,
            confirmButtonColor: "#3085d6"
        });
    }

    function duplicateEmail() {
        // let email = $('#email').val();
        const emailRegexp = /^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$/;

        if(email.val() == '' || email.val().length == 0 || email.val() == null) {
            email.focus();
            swal("중복확인 실패", "이메일을 입력하세요.");
            return;
        }
        if(!emailRegexp.test(email.val())) {
            $('#email').focus();
            swal("중복확인 실패", "이메일 형식에 맞춰 입력하세요.");
            return;
        }

        $.ajax({
            url: "/member/duplicateEmail",
            type: "post",
            data: {
                email : email.val()
            },
            success: function(result) {
                if(result == "emailCheck") {
                    $('#email').focus();
                    swal("중복확인 실패", "이미 가입된 이메일입니다.");
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

    $('#modifyBtn').on("click", function(e) {
        e.preventDefault();
        e.stopPropagation();

        if(phone2.val() == '' || phone2.val().length == 0 || phone2.val() == null) {
            phone2.focus();
            swal("입력 오류", "휴대폰 가운데 번호를 입력하세요.");
            return;
        }
        if(phone3.val() == '' || phone3.val().length == 0 || phone3.val() == null) {
            phone3.focus();
            swal("입력 오류", "휴대폰 끝 번호를 입력하세요.");
            return;
        }
        if(email.val() == '' || email.val().length == 0 || email.val() == null) {
            email.focus();
            swal("입력 오류", "이메일을 입력하세요.");
            return;
        }
    });
</script>
</body>
</html>
