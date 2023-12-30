<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="calno" value="${calVO.calno }" />
<c:set var="title" value="${calVO.title }" />
<c:set var="memo" value="${calVO.memo }" />
<c:set var="calstart" value="${calVO.calstart }" />
<c:set var="calend" value="${calVO.calend }" />

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
		<a href="./list_all_calendar.do" class='title_link'>${calVO.title }</a>
		> 일정 수정
	</div>
	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
		<c:if test="${sessionScope.manager_id != null }">
			<span class='menu_divide'>│</span>
			<a href="./create.do">일정 등록</a>
			<span class='menu_divide'>│</span>
			<a href="./list_all.do">목록형</a>
			<span class='menu_divide'>│</span>
			<a href="./list_all_calendar.do">달력형</a>
		</c:if>
	</aside>

	<div class='menu_line'></div>

	<form name='frm' method='post' action='./update.do'>
		<input type="hidden" name="calno" value="${calno }">

		<div>
			<label style="font-size: 18px; margin-top: 10px; margin-left: 26%;">일정</label>
			<input type='text' name='title' value='${title}' required="required" autofocus="autofocus" class="form-control"
				style='width: 50%; margin-left: 25%; margin-bottom: 15px;'>


			<label style="margin-left: 26%;">Memo</label>
			<textarea name='memo' required="required" class="form-control" rows="2"
				style='width: 50%; margin-left: 25%; margin-bottom: 15px;'>${memo}</textarea>
		</div>

		<div style="text-align: center;">
			<label style="margin-right: 5px;">Start Date</label>
			<input type="date" id="calstart" name="calstart" required="required" style='margin-bottom: 20px; text-align: center;'
				value='${calstart}'>
			~
			<label style="margin-right: 5px;">End Date</label>
			<input type="date" id="calend" name="calend" required="required" style='text-align: center;' value='${calend}'>
		</div>


		<div style="text-align: center;">
			<button type="submit" class="btn btn-outline-warning btn-sm" style="background-color: #583E26;">일정 수정하기</button>
			<button type="button" onclick="history.back();" class="btn btn-outline-warning btn-sm"
				style="background-color: #583E26;">취소(목록)</button>
		</div>
	</form>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
