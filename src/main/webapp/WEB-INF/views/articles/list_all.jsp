<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>DeutschBlog Articles</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body>
	<c:import url="/menu/top.do" />

	<div class='title_line'>[관리자] 콘텐츠 목록 (전체)</div>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
	</aside>

	<div class="menu_line"></div>

	<table>
		<colgroup>
			<col style="width: 15%;"></col>
			<col style="width: 60%;"></col>
			<col style="width: 15%;"></col>
			<col style="width: 10%;"></col>
		</colgroup>

		<thead>
			<tr style="text-align: center;">
				<th>🖼️</th>
				<th>콘텐츠</th>
				<th>등록일</th>
				<th></th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="articlesVO" items="${list }" varStatus="info">
				<c:set var="articlesno" value="${articlesVO.articlesno }" />
				<c:set var="thumb1" value="${articlesVO.thumb1 }" />

				<tr onclick="location.href='./read.do?articlesno=${articlesno}'" style="cursor: pointer; text-align: center;">
					<td>
						<c:choose>
							<c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
								<%-- 이미지인지 검사 --%>
								<%-- registry.addResourceHandler("/articles/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
								<img src="/articles/storage/${thumb1 }" style="width: 120px; height: 90px;">
							</c:when>

							<c:otherwise>
								<!-- 이미지가 없는 경우 기본 이미지 출력: /static/articles/images/none1.png -->
								<img src="/articles/images/none1.png" style="width: 120px; height: 90px;">
							</c:otherwise>
						</c:choose>
					</td>

					<td class="td_left">
						<span>${articlesVO.title }</span>
						<br>
						<c:choose>
							<c:when test="${articlesVO.article.length() > 80 }">${articlesVO.article.substring(0, 80) }...</c:when>
							<c:otherwise>
								<span style="font-size: 0.9em;">${articlesVO.article }</span>
							</c:otherwise>
						</c:choose>
					</td>

					<td>
						<span>${articlesVO.gdate.substring(0, 10)}</span>
					</td>

					<td>
						<a href="/articles/map.do?topicno=${topicno }&articlesno=${articlesno}&now_page=${param.now_page}" title="지도">
							<img src="/articles/images/map.png" class="icon">
						</a>
						<a href="/articles/youtube.do?topicno=${topicno }&articlesno=${articlesno}&now_page=${param.now_page}" title="유튜브">
							<img src="/articles/images/youtube.png" class="icon">
						</a>
						<a href="/articles/delete.do?topicno=${topicno }&articlesno=${articlesno}&now_page=${param.now_page}" title="삭제">
							<img src="/articles/images/delete.png" class="icon">
						</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>