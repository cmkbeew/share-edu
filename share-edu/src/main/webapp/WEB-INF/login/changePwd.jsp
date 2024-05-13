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
                        <div class="m-sm-4">
                            <form>
                                <div class="form-group">
                                    <label>이전 비밀번호</label>
                                    <input class="form-control form-control-lg mb-3" type="password" name="old_pwd" id="old_pwd">
                                </div>
                                <div>
                                    <label>새 비밀번호</label>
                                    <input class="form-control form-control-lg mb-3" type="password" name="new_pwd" id="new_pwd">
                                </div>
                                <div>
                                    <label>비밀번호 확인</label>
                                    <input class="form-control form-control-lg mb-3" type="password" name="new_pwd_check" id="new_pwd_check">
                                </div>
                                <div class="d-flex justify-content-lg-evenly">
                                    <button type="button" class="btn btn-lg w-25 btn-primary" disabled>확인</button>
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

    old.on("keyup", function(e) {
        // TODO: 기존 패스워드와 일치여부 판단
    });

    // TODO: 새 비밀번호 조건에 맞는지 체크

    // TODO: 비밀번호 확인 일치하는지 체크
</script>
</body>
</html>
