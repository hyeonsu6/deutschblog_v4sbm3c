<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<c:import url="/menu/top.do" />
	<DIV class='title_line'>관리자 로그인</DIV>
	<div class='content_body'>
		<div class="login_container">
			<div class="login_image">
				<img src="/css/images/login2.jpg" alt="로그인 이미지">
			</div>
			<div style='width: 40%; margin: 50px -50px 0px auto;'>
				<FORM name='frm' method='POST' action='./login.do'>
					<div class="form_input">
						<input type='text' class="form-control" name='id' id='id' value="${cookie.ck_manager_id.value}"
							required="required" style='width: 53%;' placeholder="아이디" autofocus="autofocus">
						<Label style='color: #FFF3B0;'>
							<input type='checkbox' name='id_save' value='Y' ${cookie.ck_manager_id.value == 'Y' ? "checked='checked'" : "" }>
							저장
						</Label>
					</div>
					<div class="form_input">
						<input type='password' class="form-control" name='pw' id='pw' value='${cookie.ck_manager_pw.value}'
							required="required" style='width: 53%;' placeholder="패스워드">
						<Label style='color: #FFF3B0;'>
							<input type='checkbox' name='pw_save' value='Y' ${cookie.ck_manager_pw.value == 'Y' ? "checked='checked'" : "" }>
							저장
						</Label>
					</div>
					<div class="login_bottom_menu">
						<button type="submit" class="btn btn-light btn-sm">로그인</button>
						<button type='button' id='btn_create' class="btn btn-light btn-sm">회원가입</button>
					</div>
				</FORM>
			</div>
		</div>
	</div>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
