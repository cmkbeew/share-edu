<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>공유 팝업</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="/resources/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<div class="container">
    <h2>공유할 사람 선택</h2>
    <div class="d-flex justify-content-between">
        <form>
            <div class="d-flex justify-content-center align-items-center">
                <label for="search_word">아이디/이름</label>
                <div class="mx-3">
                    <input class="form-control form-control-lg" type="search" placeholder="Search" aria-label="Search" name="search_word" id="search_word" value="">
                </div>
                <button class="btn-lg btn-primary" type="button" id="btn_search" onclick="searchMember()">검색</button>
            </div>
        </form>
    </div>
    <div class="mb-3">
        <form>
            <ul id="searchList" class="list-group list-group">
                <li class="list-group-item d-flex justify-content-between align-items-start"></li>
            </ul>
            <button type="button" class="btn-lg btn-primary mt-3" onclick="selectMember()">공유</button>
        </form>
    </div>
</div>

<script>
    function searchMember() {
        let search_word = document.getElementById("search_word").value;
        let searchList = document.getElementById("searchList");

        if(search_word == null || search_word == "" || search_word.length == 0) {
            Swal.fire({
               title: "검색 실패",
               text: "검색어를 입력하세요.",
               icon: "error"
            });
            return;
        } else {
            $.ajax({
                url: "/myclass/searchMember",
                type: "post",
                data: {search_word: search_word},
                success: function (result) {
                    $('#searchList').empty();
                    console.log(result);
                    if (result.length != 0) {
                        $(result).each(function () {
                            $('#searchList').append(
                                "<li class='list-group-item d-flex justify-content-between align-items-center'>"
                                + "<input type='checkbox' name='checkList' id='" + this.member_idx + "' value='" + this.member_idx + "'>"
                                + "<div>" + this.user_id + "</div>"
                                + "<div>" + this.name + "</div>"
                                + "<div>" + this.email + "</div>"
                                + "</li>"
                            );
                        });
                    } else {
                        $('#searchList').append(
                            "<li class='list-group-item d-flex justify-content-between align-items-start'>"
                            + "<div> 일치하는 회원이 없습니다. </div>"
                            + "</li>"
                        );
                    }

                }
            });
        }
    }

    function selectMember() {
        let arrMember = new Array();

        $("input[name='checkList']:checked").each(function(index) {
            let checkId = $(this).val();
            arrMember.push(checkId);
        });

        console.log(arrMember);
        window.opener.setCheckList(arrMember);
        window.close();
    }
</script>
</body>
</html>
