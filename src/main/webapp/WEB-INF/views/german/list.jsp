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
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>

<body>
	<c:import url="/menu/top.do" />

	<div class='title_line'>[ME✨] 회원 목록</div>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
	</aside>

	<div class='menu_line'></div>

	<table style='width: 100%;'>
		<colgroup>
			<col style='width: 10%;' />
			<col style='width: 10%;' />
			<col style='width: 10%;' />
			<col style='width: 15%;' />
			<col style='width: 30%;' />
			<col style='width: 15%;' />
			<col style='width: 10%;' />
		</colgroup>

		<thead>
			<tr style="text-align: center;">
				<th></th>
				<th>ID</th>
				<th>성명</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>등록일</th>
				<th></th>
			</tr>
		</thead>

		<c:forEach var="germanVO" items="${list }">
			<c:set var="germanno" value="${germanVO.germanno}" />
			<c:set var="grade" value="${germanVO.grade}" />
			<c:set var="id" value="${germanVO.id}" />
			<c:set var="mname" value="${germanVO.mname}" />
			<c:set var="tel" value="${germanVO.tel}" />
			<c:set var="address1" value="${germanVO.address1}" />
			<c:set var="mdate" value="${germanVO.mdate}" />

			<tr style="text-align: center;">
				<td>
					<c:choose>
						<c:when test="${grade >= 1 and grade <= 10}">
							<img src='/german/images/admin.png' title="관리자" class="icon_New">
						</c:when>
						<c:when test="${grade >= 11 and grade <= 20}">
							<img src='/german/images/user.png' title="회원" class="icon_New">
						</c:when>
						<c:when test="${grade >= 40 and grade <= 49}">
							<img src='/german/images/pause.png' title="정지 회원" class="icon_New">
						</c:when>
						<c:when test="${grade == 99}">
							<img src='/german/images/x.png' title="탈퇴 회원" class="icon_New">
						</c:when>
					</c:choose>
				</td>

				<td>
					<a href="./read.do?germanno=${germanno}">${id}</a>
				</td>

				<td>
					<a href="./read.do?germanno=${germanno}">${mname}</a>
				</td>

				<td>${tel}</td>

				<td style="font-size: 13px;">
					<c:choose>
						<c:when test="${address1.length() > 15 }">${address1.substring(0, 15) }...</c:when>
						<c:otherwise>${address1}</c:otherwise>
					</c:choose>
				</td>

				<td>${mdate.substring(0, 10)}</td>

				<%-- 년월일 --%>
				<td>
					<a href="./lock.do?germanno=${germanno}">
						<img src='/german/images/lock.png' title='정지' class="icon">
					</a>
					<a href="./read.do?germanno=${germanno}">
						<img src='/german/images/update.png' title='수정' class="icon">
					</a>
					<a href="./delete.do?germanno=${germanno}">
						<img src='/german/images/delete.png' title='삭제' class="icon">
					</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class='bottom_menu'>
		<button type='button' onclick="location.href='./create.do'" class="btn btn-outline-warning btn-sm"
			style="background-color: #583E26;">등록</button>
		<button type='button' onclick="location.reload();" class="btn btn-outline-warning btn-sm"
			style="background-color: #583E26;">새로고침</button>
	</div>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>

