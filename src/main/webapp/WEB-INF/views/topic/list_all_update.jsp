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
</head>
<body>
	<c:import url="/menu/top.do" />
	<div class='title_line'>카테고리 수정</div>
	<aside class="aside_right">
		<a href="./create.do?topicno=${topicVO.topicno }">등록</a>
		<span class='menu_divide'>│</span>
		<a href="javascript:location.reload();">새로고침</a>
	</aside>
	<div class="menu_line"></div>
	<form name='frm' method='post' action='/topic/update.do'>
		<input type='hidden' name='topicno' value='${topicVO.topicno }'>
		<div style="text-align: center;">
			<label>카테고리 이름</label>
			<input type="text" name="name" value="${topicVO.name }" required="required" autofocus="autofocus" class=""
				style="width: 30%">
			<label>글수</label>
			<input type="text" name="cnt" value="${topicVO.cnt }" required="required" autofocus="autofocus" class=""
				style="width: 20%">
			<button type="submit" class="btn btn-dark btn-sm">저장</button>
			<button type="button" onclick="history.back();" class="btn btn-dark btn-sm">취소</button>
		</div>
	</form>
	<table class="table table-hover">
		<colgroup>
			<col style='width: 10%;' />
			<col style='width: 40%;' />
			<col style='width: 10%;' />
			<col style='width: 20%;' />
			<col style='width: 20%;' />
		</colgroup>
		<thead>
			<tr>
				<th class="th_bs">순서</th>
				<th class="th_bs">카테고리 이름</th>
				<th class="th_bs">자료수</th>
				<th class="th_bs">등록일</th>
				<th class="th_bs">기타</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="topicVO" items="${list }" varStatus="info">
				<c:set var="topicno" value="${topicVO.topicno }" />
				<tr>
					<td class="td_bs">${info.count }</td>
					<td>
						<a href="./read.do?topicno=${topicno }" style="display: block;">${topicVO.name }</a>
					</td>
					<td class="td_bs">${topicVO.cnt }</td>
					<td class="td_bs">
						<span style="font-size: 1em;">📝 ${topicVO.gdate.substring(0, 10)}</span>
					</td>
					<td class="td_bs">
						<a href="../articles/create.do?topicno=${topicno }" title="등록">
							<img src="/topic/images/create.png" class="icon">
						</a>
						<img src="/topic/images/show.png" class="icon">
						<a href="./update_seqno_forward.do?topicno=${topicno }" title="우선 순위 높임">
							<img src="/topic/images/decrease.png" class="icon">
						</a>
						<a href="./update_seqno_backward.do?topicno=${topicno }" title="우선 순위 낮춤">
							<img src="/topic/images/increase.png" class="icon">
						</a>
						<a href="./update.do?topicno=${topicno }" title="수정">
							<img src="/topic/images/update.png" class="icon">
						</a>
						<a href="./delete.do?topicno=${topicno }" title="삭제">
							<img src="/topic/images/delete.png" class="icon">
						</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>