<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="calno" value="${calVO.calno }" />
<c:set var="title" value="${calVO.title }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog Calendar</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
	<c:import url="/menu/top.do" />
	<div class='title_line'>
		🔔DeutschBlog Month Event🧡 >
		<a href="./read.do?calno=${calno}" class='title_link'>${title }</a>
	</div>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
		<c:if test="${sessionScope.manager_id != null }">
			<span class='menu_divide'>│</span>
			<a href="./list_all.do">목록형</a>
			<span class='menu_divide'>│</span>
			<a href="./list_all_calendar.do">달력형</a>
		</c:if>
	</aside>

	<div class='menu_line'></div>

	<fieldset class="fieldset_basic">
		<div style="width: 100%; word-break: break-all; text-align: center;">
			<span style="font-size: 24px; margin-right: 5px;">🎈일정 : ${title}</span>
			<br>
			<form name='frm' method='post' action='./delete.do'>
				<input type='hidden' name='calno' value='${calno}'>

				<div style='text-align: center; margin: 10px auto;'>
					<span style="color: #FF4500;">
						삭제를 진행 하시겠습니까? <br> 삭제하시면 복구 할 수 없습니다.
					</span>
					<br> <br>
					<button type="submit" class="btn btn-outline-warning btn-sm" style="background-color: #583E26;">일정 삭제하기</button>
					<button type="button" onclick="history.back()" class="btn btn-outline-warning btn-sm"
						style="background-color: #583E26;">취소하기</button>
				</div>
			</form>
		</div>

	</fieldset>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>

