<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog</title>
<title>DeutschBlog German Message</title>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript">
  window.onload = ()=> {
    document.getElementById('btn_retry').addEventListener('click', () => {
      location.href="./login.do";
    });

    document.getElementById('btn_home').addEventListener('click', () => {
      location.href="./index.do";
    });
  }

</script>
</head>
<body>
	<c:import url="/menu/top.do" />
	<DIV class='title_line'>알림</DIV>
	<DIV class='message'>
		<fieldset class='fieldset_basic'>
			<ul>
				<li class='li_none'>회원 로그인에 실패했습니다.</li>
				<li class='li_none'>ID 또는 패스워드가 일치하지 않습니다.</li>
				<li class='li_none'>
					<button type="button" id="btn_retry" class="btn btn-outline-warning btn-sm">로그인 다시 시도</button>
					<button type="button" id="btn_home" class="btn btn-outline-warning btn-sm">확인</button>
				</li>
			</ul>
		</fieldset>
	</DIV>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>