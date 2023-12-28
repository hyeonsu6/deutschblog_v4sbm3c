<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>DeutschBlog Login</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body>
	<c:import url="/menu/top.do" />
	
	<div class='title_line'>관리자 로그인</div>
	
	<div class='message'>
		<fieldset class='fieldset_basic'>
			<ul>
				<li class='li_none'>관리자 로그인에 실패했습니다.</li>
				<li class='li_none'>ID 또는 패스워드가 일치하지 않습니다.</li>
				<li class='li_none'>
					<button type="button" id="btn_retry" class="btn btn-dark" onclick="location.href='./login.do'">로그인 다시 시도</button>
					<button type="button" id="btn_home" class="btn btn-dark" onclick="location.href='/index.do'">확인</button>
				</li>
			</ul>
		</fieldset>
	</div>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>