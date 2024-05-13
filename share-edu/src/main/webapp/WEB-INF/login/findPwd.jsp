<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>비밀번호 찾기</title>
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
                    <h1 class="h2">비밀번호를 잊으셨나요?</h1>
                    <p class="lead">본인인증을 진행하기 위해 아이디를 입력하여 주세요.</p>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="m-sm-4">
                            <form>
                                <div class="form-group">
                                    <label>아이디</label>
                                    <input class="form-control form-control-lg" type="text" name="user_id" id="user_id">
                                </div>
                                <div class="text-center mt-3"> <button type="button" class="btn btn-lg btn-primary" onclick="changeTempPwd()">임시비밀번호 발급</button></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../common/footer.jsp"%>
</div>
<script>
    function changeTempPwd() {
        let user_id = $('#user_id').val();

        $.ajax({
            url: "/login/findPwd",
            type: "post",
            data: {user_id: user_id},
            success: function(result) {
                if(result != "fail") {
                    Swal.fire({
                        title: "임시 비밀번호",
                        text: result,
                        icon: "success"
                    }).then(() => {
                        window.location.href = "/login/login";
                    });
                }
            }
        });
    }
</script>
</body>
</html>
