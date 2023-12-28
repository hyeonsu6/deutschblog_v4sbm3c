<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog💛 Category</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body>
<body>
	<c:import url="/menu/top.do" />

	<div class='title_line'>[ME✨] 카테고리 정보 수정</div>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
	</aside>

	<form name='frm' method='post' action='/topic/update.do'>
		<br>
		<input type='hidden' name='topicno' value='${topicVO.topicno }'>
		<div style="text-align: center; margin-bottom: 20px;">
			<label style="margin-right: 5px;">카테고리 이름</label>
			<input type="text" name="name" value="${topicVO.name }" required="required" autofocus="autofocus" class=""
				style="width: 30%; margin-right: 10px;">

			<label style="margin-right: 5px;">등록된 콘텐츠 수</label>
			<input type="text" name="cnt" value="${topicVO.cnt }" required="required" autofocus="autofocus" class=""
				style="width: 20%">
			<button type="submit" class="btn btn-outline-warning btn-sm" style="background-color: #583E26;">저장하기</button>
			<button type="button" onclick="history.back();" class="btn btn-outline-warning btn-sm"
				style="background-color: #583E26;">취소(목록)</button>
		</div>
	</form>
	<br>
	<table>
		<colgroup>
			<col style='width: 10%;' />
			<col style='width: 40%;' />
			<col style='width: 10%;' />
			<col style='width: 20%;' />
			<col style='width: 20%;' />
		</colgroup>

		<thead>
			<tr style="text-align: center;">
				<th>순서</th>
				<th>카테고리 이름</th>
				<th>등록된 콘텐츠 수</th>
				<th>등록일</th>
				<th></th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="topicVO" items="${list }" varStatus="info">
				<c:set var="topicno" value="${topicVO.topicno }" />

				<tr style="text-align: center;">
					<td>${info.count }</td>

					<td>
						<a href="../articles/list_by_topicno.do?topicno=${topicno }" style="display: block;">${topicVO.name }</a>
					</td>

					<td>${topicVO.cnt }</td>

					<td>${topicVO.gdate.substring(0, 10) }</td>

					<td>
						<a href="../articles/create.do?topicno=${topicno }" title="콘텐츠 등록">
							<img src="/topic/images/create.png" class="icon">
						</a>
						<c:choose>
							<c:when test="${topicVO.visible == 'Y'}">
								<a href="./update_visible_n.do?topicno=${topicno }" title="카테고리 공개 설정">
									<img src="/topic/images/show.png" class="icon">
								</a>
							</c:when>
							<c:otherwise>
								<a href="./update_visible_y.do?topicno=${topicno }" title="카테고리 비공개 설정">
									<img src="/topic/images/hide.png" class="icon">
								</a>
							</c:otherwise>
						</c:choose>
						<a href="./update_seqno_forward.do?topicno=${topicno }" title="우선 순위 높임">
							<img src="/topic/images/increase.png" class="icon">
						</a>
						<a href="./update_seqno_backward.do?topicno=${topicno }" title="우선 순위 낮춤">
							<img src="/topic/images/decrease.png" class="icon">
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
