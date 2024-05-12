<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>로그인 페이지</title>
    <meta charset="UTF-8"/>
</head>
<body>
<%@include file="../common/header.jsp"%>
<div id="snippetContent">
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card-group mb-0">
                    <div class="card p-4">
                        <div class="card-body">
                            <h1>Login</h1>
                            <p class="text-muted">Sign In to your account</p>
                            <form name="frmLogin" id="frmLogin" method="post" action="/login/login">
                                <div class="input-group mb-2">
													<span class="input-group-addon">
														<i class="fa fa-user"></i>
													</span>
                                    <input type="text" class="form-control" name="user_id" id="user_id" value="<c:out value='${save_id != null ? save_id : loginDTO.user_id}' />" placeholder="ID">
                                </div>
                                <div id="div_err_user_id" style="display: none"></div>

                                <div class="input-group mb-2">
														<span class="input-group-addon">
															<i class="fa fa-lock"></i>
														</span>
                                    <input type="password" class="form-control" name="pwd" id="pwd" value="" placeholder="Password">
                                </div>
                                <div id="div_err_pwd" style="display: none"></div>

                                <div class="d-flex justify-content-evenly">
                                    <div><input type="checkbox" name="save_id" id="save_id" <c:if test="${save_id != null}">checked</c:if> />아이디 저장</div>
                                    <div><input type="checkbox" name="auto_login" id="auto_login" <c:if test="${auto_login != null}">checked</c:if> />자동 로그인</div>
                                </div>

                                <c:if test="${login_err_msg != null}">
                                    <div style="color:red;">${login_err_msg}</div>
                                </c:if>

                                <div class="row mt-3">
                                    <div class="col-6">
                                        <button type="submit" id="btnLogin" class="btn btn-primary px-4">로그인</button>
                                    </div>
                                    <div class="col-6 text-right">
                                        <button type="button" class="btn btn-link px-0">아이디/비밀번호 찾기</button>
                                    </div>

                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="card text-white bg-primary py-5 d-md-down-none" style="width:44%">
                        <div class="card-body text-center">
                            <div>
                                <h2 class="mb-4">Sign up</h2>
                                <p>To use our service,<br> You must register as our member.</p>
                                <button type="button" class="btn btn-primary active mt-3" onclick="location.href='/member/join'">Register Now!</button>
                            </div>
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
        document.getElementById("div_err_${err.getField()}").innerHTML = "<span style='color:red;'> ${err.defaultMessage}</span>";
        document.getElementById("div_err_${err.getField()}").style.display = "block";
    }
    serverValidResult['${err.getField()}'] = '${err.defaultMessage}';
    </c:forEach>
</script>
</body>
</html>
