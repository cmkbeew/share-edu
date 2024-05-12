<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>My Page</title>
    <meta charset="UTF-8"/>

    <style type="text/css">
        .inf-content{
            border:1px solid #DDDDDD;
            -webkit-border-radius:10px;
            -moz-border-radius:10px;
            border-radius:10px;
            box-shadow: 7px 7px 7px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
<h1 style="text-align: center" class="mb-4">My Page</h1>
<div id="snippetContent">
    <div class="container bootstrap snippets bootdey">
        <div class="panel-body inf-content">
            <div class="row align-items-center">
                <div class="col-md-4">
                    <img alt="" style="width:600px; border-radius: 50%;" title="" class="img-thumbnail" src="/resources/images/profile.jpg" />
                </div>
                <div class="col-md-6 col align-self-center">
                    <div class="table-responsive" style="margin: 10px auto;">
                        <form name="frmDelete" id="frmDelete" method="post" action="/member/delete">
                            <input type="hidden" name="user_id" id="user_id" value="${memberDTO.user_id}" />
                            <table class="table table-user-information">
                                <tbody>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-asterisk text-primary"></span> 아이디 </strong></td>
                                    <td class="text-secondary">${memberDTO.user_id}</td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-user  text-primary"></span> 이름 </strong></td>
                                    <td class="text-secondary">${memberDTO.name}</td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-cloud text-primary"></span> 이메일 </strong></td>
                                    <td class="text-secondary">${memberDTO.email}</td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-bookmark text-primary"></span> 주소1 </strong></td>
                                    <td class="text-secondary">${memberDTO.addr1}</td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-eye-open text-primary"></span> 주소2 </strong></td>
                                    <td class="text-secondary">${memberDTO.addr2}</td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-envelope text-primary"></span> 생년월일 </strong></td>
                                    <td class="text-secondary">${memberDTO.birthday}</td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-calendar text-primary"></span> 관심사항 </strong></td>
                                    <td class="text-secondary">${memberDTO.interest}</td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-calendar text-primary"></span> 가입일 </strong></td>
                                    <td class="text-secondary">${memberDTO.reg_date}</td>
                                </tr>
                                </tbody>
                            </table>
                        </form>
                        <div>
                            <button type="button" class="btn-secondary btn-lg" onclick="location.href='/member/modify?user_id=${memberDTO.user_id}'">수정</button>
                            <button type="button" class="btn-danger btn-lg" onclick="goDelete()">탈퇴</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function goDelete() {
            const frm = document.getElementById("frmDelete");
            let confirm_flag = confirm("해당 게시글을 삭제하시겠습니까?");

            if(confirm_flag) {
                frm.submit();
            }
        }
    </script>
</div>
</body>
</html>
