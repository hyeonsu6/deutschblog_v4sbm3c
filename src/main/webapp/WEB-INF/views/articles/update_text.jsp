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
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<c:import url="/menu/top.do" />
	<DIV class='title_line'>${topicVO.name }>${title } > 수정</DIV>
	<aside class="aside_right">
		<a href="./create.do?topicno=${topicno }">등록</a>
		<span class='menu_divide'>│</span>
		<a href="javascript:location.reload();">새로고침</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_topicno.do?topicno=${topicno }&now_page=${param.now_page}&word=${param.word }">목록형</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_topicno_grid.do?topicno=${topicno }&now_page=${param.now_page}&word=${param.word }">갤러리형</a>
	</aside>
	`
	<div style="text-align: right; clear: both;">
		<form name='frm' id='frm' method='get' action='./list_by_topicno_search_paging.do'>
			<input type='hidden' name='topicno' value='${topicVO.topicno }'>
			<%-- 게시판의 구분 --%>
			<c:choose>
				<c:when test="${param.word != '' }">
					<%-- 검색하는 경우 --%>
					<input type='text' name='word' id='word' value='${param.word }' class='input_word'>
				</c:when>
				<c:otherwise>
					<%-- 검색하지 않는 경우 --%>
					<input type='text' name='word' id='word' value='' class='input_word'>
				</c:otherwise>
			</c:choose>
			<button type='submit' class='btn btn-dark btn-sm' style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색</button>
			<c:if test="${param.word.length() > 0 }">
				<button type='button' class='btn btn-dark btn-sm' onclick="location.href='./list_by_topicno.do?topicno=${topicVO.topicno}&word='" style="padding: 2px 8px 3px 8px; margin: 0px 0px 2px 0px;">검색 취소</button>
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
			<input type='text' name='title' value='${title }' required="required" autofocus="autofocus" class="form-control" style='width: 100%;'>
		</div>
		<div>
			<label>내용</label>
			<textarea name='article' required="required" class="form-control" rows="12" style='width: 100%;'>${article }</textarea>
		</div>
		<div>
			<label>검색어</label>
			<input type='text' name='word' value="${word }" required="required" class="form-control" style='width: 100%;'>
		</div>
		<div>
			<label>패스워드</label>
			<input type='password' name='pw' value='' required="required" class="form-control" style='width: 50%;'>
		</div>
		<div class="article_body_bottom">
			<button type="submit" class="btn btn-dark btn-sm">저장</button>
			<button type="button" onclick="history.back();'" class="btn btn-dark btn-sm">취소</button>
		</div>
	</FORM>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>