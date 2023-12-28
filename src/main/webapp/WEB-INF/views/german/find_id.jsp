<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
    function id_search() {
        var frm = document.idfindscreen;
        if (frm.member_name.value.length < 1) {
            alert("이름을 입력해주세요");
            return;
        }
        if (frm.member_phone.value.length != 13) {
            alert("핸드폰번호를 정확하게 입력해주세요");
            return;
        }
        frm.method = "post";
        frm.action = "findIdResult.jsp";
        // 넘어간화면
        frm.submit();
    }
</script>

</head>
<body>
	<c:import url="/menu/top.do" />
	<form name="idfindscreen" method="POST">
		<div class="search-title">
			<h3>휴대폰 본인확인</h3>
		</div>
		<section class="form-search">
			<div class="find-name">
				<label>이름</label>
				<input type="text" name="member_name" class="btn-name" placeholder="등록한 이름">
				<br>
			</div>
			<div class="find-phone">
				<label>번호</label>
				<input type="text" onKeyup="addHypen(this);" name="member_phone" class="btn-phone" placeholder="휴대폰번호를 '-'없이 입력">
			</div>
			<br>
		</section>
		<div class="btnSearch">
			<input type="button" name="enter" value="찾기" onClick="id_search()">
			<input type="button" name="cancle" value="취소" onClick="history.back()">
		</div>
	</form>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>