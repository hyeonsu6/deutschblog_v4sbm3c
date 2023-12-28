<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>Festival Blog CateGory</title>
<link rel="shortcut icon" href="/images/festival.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body>
	<c:import url="/menu/top.do" />

	<div class='title_line'>카테고리</div>

	<table>
		<colgroup>
			<col style='width: 20%;' />
			<col style='width: 60%;' />
			<col style='width: 20%;' />
		</colgroup>

		<thead>
			<tr style="text-align: center;">
				<th>번호</th>
				<th>카테고리</th>
				<th>등록된 콘텐츠 수</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="topicVO" items="${list}" varStatus="info">
				<c:if test="${topicVO.visible == 'Y'}">
					<c:set var="topicno" value="${topicVO.topicno}" />
					<c:set var="seqno" value="${topicVO.seqno }" />

					<tr style="text-align: center;">
						<td>${seqno }</td>

						<td>
							<a href="../articles/list_by_topicno.do?topicno=${topicno }" style="display: block;">${topicVO.name }</a>
						</td>

						<td>${topicVO.cnt}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
