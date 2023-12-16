<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>DeutschBlog</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<c:import url="/menu/top.do" />
	<div class='title_line'>카테고리</div>
	<aside class="aside_right">
		<a href="./create.do?topicno=${topicVO.topicno }">등록</a>
		<span class='menu_divide'>│</span>
		<a href="javascript:location.reload();">새로고침</a>
	</aside>
	<div class="menu_line"></div>
	<form name='frm' method='post' action='/topic/create.do'>
		<div style="text-align: center;">
			<label>카테고리 이름</label>
			<input type="text" name="name" value="" required="required" autofocus="autofocus" class="" style="width: 50%">
			<button type="submit" class="btn btn-dark btn-sm" style="height: 28px; margin-bottom: 5px;">등록</button>
			<button type="button" onclick="location.href='./list_all.do'" class="btn btn-dark btn-sm"
				style="height: 28px; margin-bottom: 5px;">목록</button>
		</div>
	</form>
	<br>
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
				<c:set var="seqno" value="${topicVO.seqno }" />
				<tr>
					<td class="td_bs">${seqno }</td>
					<td>
						<a href="../articles/list_by_topicno.do?topicno=${topicno }" style="display: block;">${topicVO.name }</a>
					</td>
					<td class="td_bs">${topicVO.cnt }</td>
					<td class="td_bs">
						<span style="font-size: 1em;">📝 ${topicVO.gdate.substring(0, 10)}</span>
					</td>
					<td class="td_bs">
						<a href="../articles/create.do?topicno=${topicno }" title="등록">
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
