<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>DeutschBlog</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />
 
  <div class='message'>
    <h3>회원 로그인이 필요한 페이지입니다.</h3>
    <br><br>
    <button type='button' onclick="location.href='/german/login.do'" class="btn btn-dark btn-sm">로그인</button>       
    <button type='button' onclick="location.href='/german/create.do'" class="btn btn-dark btn-sm">회원가입</button>       
  </div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
</body>
</html>