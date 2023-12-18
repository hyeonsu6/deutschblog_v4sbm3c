<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body>
	<c:import url="/menu/top.do" />
	<div class='title_line'>
		<A href="/articles/list_by_topicno.do?topicno=${topicVO.topicno }" class="title_link">${topicVO.name }</A>
		> ${articlesVO.title } > Youtube 등록/수정/삭제
	</div>
	<ASIDE class="aside_right">
		<A href="javascript:location.reload();">새로고침</A>
		<span class='menu_divide'>│</span>
		<A href="./list_by_topicno.do?topicno=${param.topicno }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">기본 목록형</A>
		<span class='menu_divide'>│</span>
		<A href="./list_by_topicno_grid.do?topicno=${param.topicno }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">갤러리형</A>
	</ASIDE>
	<div style="text-align: right; clear: both;">
		<form name='frm' id='frm' method='get' action='./list_by_topicno.do'>
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
			<button type='submit' class='btn btn-dark btn-sm'>검색</button>
			<c:if test="${param.word.length() > 0 }">
				<button type='button' class='btn btn-dark btn-sm' onclick="location.href='./list_by_topicno.do?topicno=${topicVO.topicno}&word='">검색 취소</button>
			</c:if>
		</form>
	</div>
	<div class='menu_line'></div>
	<%--등록 폼 --%>
	<form name='frm_youtube' method='POST' action='./youtube.do'>
		<input type="hidden" name="articlesno" value="${param.articlesno }">
		<div>
			<label>Youtube 스크립트</label>
			<textarea name='youtube' class="form-control" rows="12" style='width: 100%;'>${articlesVO.youtube }</textarea>
		</div>
		<div class="article_body_bottom">
			<button type="submit" class="btn btn-dark btn-sm">저장</button>
			<button type="button" onclick="frm_youtube.youtube.value=''; frm_youtube.submit();" class="btn btn-dark btn-sm">Youtube 삭제</button>
			<button type="button" onclick="history.back();" class="btn btn-dark btn-sm">취소</button>
		</div>
	</form>
	<HR>
	<div style="text-align: center;">
		<h5>[참고] Youtube의 등록 방법</h5>
		<img src='/articles/images/youtube01.jpg' style='width: 60%;'>
		<br>
		<br>
		<img src='/articles/images/youtube02.jpg' style='width: 60%;'>
		<br>
	</div>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>