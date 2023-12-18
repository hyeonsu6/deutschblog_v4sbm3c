<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<div class='title_line'>회원 삭제(관리자)</div>
	<aside class="aside_right">
		<A href="javascript:location.reload();">새로고침</A>
		<span class='menu_divide'>│</span>
		<A href='./create.do'>회원 가입</A>
		<span class='menu_divide'>│</span>
		<A href='./list.do'>목록</A>
	</aside>
	<div class='menu_line'></div>
	<div class='message'>
    <form name='frm' method='post' action='./delete.do'>
      '${germanVO.mname }(${germanVO.id })' 회원을 삭제하면 복구 할 수 없습니다.<br><br>
      정말로 삭제하시겠습니까?<br><br>         
      <input type='hidden' name='germanno' value='${germanVO.germanno}'>     
          
      <button type="submit" class="btn btn-dark btn-sm">삭제</button>
      <button type="button" onclick="location.href='./list.do'" class="btn btn-dark btn-sm">취소</button>
   
    </form>
  </div>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
