<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>My Page</title>
    <meta charset="UTF-8"/>
    <style>
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
<h1 style="text-align: center" class="mb-4">My Page 수정</h1>
<div id="snippetContent">
    <div class="container bootstrap snippets bootdey">
        <div class="panel-body inf-content">
            <div class="row align-items-center">
                <div class="col-md-4">
                    <img alt="" style="width:600px; border-radius: 50%;" title="" class="img-thumbnail" src="/resources/images/profile.jpg" />
                </div>
                <div class="col-md-6 col align-self-center">
                    <div class="table-responsive" style="margin: 10px auto;">
                        <form name="frmModify" id="frmModify" method="post" action="/member/modify">
                            <input type="hidden" name="pwd" id="pwd" value="${memberDTO.pwd}" />
                            <table class="table table-user-information">
                                <tbody>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-asterisk text-primary"></span> 아이디 </strong></td>
                                    <td><input type="text" name="user_id" id="user_id" value="${memberDTO.user_id}" readonly/></td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-user  text-primary"></span> 이름 </strong></td>
                                    <td>
                                        <input type="text" name="name" id="name" value="${memberDTO.name}" />
                                        <div id="div_err_name" style="display: none"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-cloud text-primary"></span> 이메일 </strong></td>
                                    <td>
                                        <input type="email" name="email" id="email" value="${memberDTO.email}" />
                                        <div id="div_err_email" style="display: none"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-bookmark text-primary"></span> 주소1 </strong></td>
                                    <td>
                                        <input type="text" name="addr1" id="addr1" value="${memberDTO.addr1}" />
                                        <div id="div_err_addr1" style="display: none"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-eye-open text-primary"></span> 주소2 </strong></td>
                                    <td>
                                        <input type="text" name="addr2" id="addr2" value="${memberDTO.addr2}" />
                                        <div id="div_err_addr2" style="display: none"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-envelope text-primary"></span> 생년월일 </strong></td>
                                    <td>
                                        <input type="date" name="birthday" id="birthday" value="${memberDTO.birthday}" />
                                        <div id="div_err_birthday" style="display: none"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td> <strong> <span class="glyphicon glyphicon-calendar text-primary"></span> 관심사항 </strong></td>
                                    <td>
                                        <input class="form-check-input me-1" type="checkbox" name="interest" id="interest_0" value="스포츠" <c:out value="${memberDTO.interest.contains(\"스포츠\") ? 'checked' : ''}"></c:out>>
                                        스포츠
                                        <input class="form-check-input me-1" type="checkbox" name="interest" id="interest_1" value="여행" <c:out value="${memberDTO.interest.contains(\"여행\") ? 'checked' : ''}"></c:out>>
                                        여행
                                        <input class="form-check-input me-1" type="checkbox" name="interest" id="interest_2" value="영화" <c:out value="${memberDTO.interest.contains(\"영화\") ? 'checked' : ''}"></c:out>>
                                        영화
                                        <input class="form-check-input me-1" type="checkbox" name="interest" id="interest_3" value="음악" <c:out value="${memberDTO.interest.contains(\"음악\") ? 'checked' : ''}"></c:out>>
                                        음악
                                        <div id="div_err_interest" style="display: none">adsd</div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <div>
                                <button type="submit" class="btn-primary btn-lg">수정하기</button>
                                <button type="button" class="btn-secondary btn-lg" onclick="location.href='/member/view?user_id=${memberDTO.user_id}'">취소</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
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

    console.log(serverValidResult);
</script>
</body>
</html>
