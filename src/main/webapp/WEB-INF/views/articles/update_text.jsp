<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="topicno" value="${topicVO.topicno }" />
<c:set var="articlesno" value="${articlesVO.articlesno }" />
<c:set var="title" value="${articlesVO.title }" />
<c:set var="article" value="${articlesVO.article }" />
<c:set var="word" value="${articlesVO.word }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog Articles</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body>
	<c:import url="/menu/top.do" />
	<div class='title_line'>
		<a href="./list_by_topicno.do?topicno=${topicVO.topicno }" class='title_link'>${topicVO.name }</a>
		>
		<a
			href="./read.do?articlesno=${articlesno }&word=${param.word }&now_page=${param.now_page }&topicno=${topicVO.topicno }"
			class='title_link'>${title }</a>
		> 콘텐츠 수정
	</div>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_topicno.do?topicno=${topicno }&now_page=${param.now_page}&word=${param.word }">목록형</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_topicno_grid.do?topicno=${topicno }&now_page=${param.now_page}&word=${param.word }">갤러리형</a>
	</aside>

	<div style="text-align: right; clear: both;">
		<form name='frm' id='frm' method='get' action='./list_by_topicno_search_paging.do'>
			<input type='hidden' name='topicno' value='${topicVO.topicno }'>
			<%-- 게시판의 구분 --%>

			<c:choose>
				<c:when test="${param.word != '' }">
					<%-- 검색하는 경우 --%>
					<input type='text' name='word' id='word' value='${param.word }' class='input_word' placeholder=" 검색어를 검색해주세요!">
				</c:when>
				<c:otherwise>
					<%-- 검색하지 않는 경우 --%>
					<input type='text' name='word' id='word' value='' class='input_word'>
				</c:otherwise>
			</c:choose>
			<button type='submit' class="btn btn-outline-warning btn-sm" style="background-color: #583E26;">검색</button>
			<c:if test="${param.word.length() > 0 }">
				<button type='button' class="btn btn-outline-warning btn-sm" style="background-color: #583E26;"
					onclick="location.href='./list_by_topicno.do?topicno=${topicVO.topicno}&word='">검색 취소</button>
			</c:if>
		</form>
	</div>

	<div class='menu_line'></div>

	<form name='frm' method='post' action='./update_text.do'>
		<input type="hidden" name="topicno" value="${topicno }">
		<input type="hidden" name="articlesno" value="${articlesno }">
		<input type="hidden" name="now_page" value="${param.now_page }">

		<div>
			<label>제목</label>
			<input type='text' name='title' value='${title }' required="required" autofocus="autofocus" class="form-control"
				style='width: 100%; margin-bottom: 15px;'>
		</div>
		<div>
			<label style="margin-bottom: 15px;">내용</label>
			<textarea name='article' required="required" class="form-control" rows="20" style='width: 100%; margin-bottom: 15px;'>${article }</textarea>
		</div>
		<div>
			<label>검색어</label>
			<input type='text' name='word' value="${word }" required="required" class="form-control"
				style='width: 100%; margin-bottom: 15px;'>
		</div>
		<div>
			<label>패스워드</label>
			<input type='password' name='pw' value='' required="required" class="form-control" style='width: 50%;'>
		</div>
		<div class="content_body_bottom">
			<button type="submit" class="btn btn-outline-warning btn-sm" style="background-color: #583E26;">저장</button>
			<button type="button" onclick="history.back();" class="btn btn-outline-warning btn-sm"
				style="background-color: #583E26;">취소(목록)</button>
		</div>
	</form>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>

