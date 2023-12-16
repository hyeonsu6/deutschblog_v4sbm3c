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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
  window.onload = ()=> {
    document.getElementById('btn_create').addEventListener('click', () => {
      location.href="./create.do";
    });

    document.getElementById('btn_loadDefault').addEventListener('click', () => {
      document.getElementById('id').value = 'user1@gmail.com';
      document.getElementById('passwd').value = '1234';
    });
  }
    
</script>
</head>
<body>
	<c:import url="/menu/top.do" />
	<div class='title_line'>회원 로그인</div>
	<div class='content_body'>
		<div class="login_container">
			<div class="login_image">
				<img src="/css/images/login.jpg" alt="로그인 이미지">
			</div>
			<div style='width: 40%; margin: 50px -50px 0px auto;'>
				<FORM name='frm' method='POST' action='./login.do'>
					<div class="form_input">
						<input type='text' class="form-control" name='id' id='id' value="${ck_id}" required="required" style='width: 53%;' placeholder="아이디" autofocus="autofocus">
						<Label> <input type='checkbox' name='id_save' value='Y' ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
						</Label>
					</div>
					<div class="form_input">
						<input type='password' class="form-control" name='passwd' id='passwd' value='${ck_passwd}' required="required" style='width: 53%;' placeholder="패스워드">
						<Label> <input type='checkbox' name='passwd_save' value='Y' ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
						</Label>
					</div>
					<div class="login_bottom_menu">
						<button type="submit" class="btn btn-dark btn-sm">로그인</button>
						<button type='button' id='btn_create' class="btn btn-dark btn-sm">회원가입</button>
					</div>
				</FORM>
			</div>
		</div>
	</div>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>