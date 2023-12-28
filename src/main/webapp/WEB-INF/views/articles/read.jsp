<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="name" value="${topicVO.name }" />

<c:set var="topicno" value="${articlesVO.topicno }" />
<c:set var="articlesno" value="${articlesVO.articlesno }" />
<c:set var="title" value="${articlesVO.title }" />
<c:set var="thumb1" value="${articlesVO.thumb1 }" />
<c:set var="file1saved" value="${articlesVO.file1saved }" />
<c:set var="article" value="${articlesVO.article }" />
<c:set var="gdate" value="${articlesVO.gdate }" />
<c:set var="youtube" value="${articlesVO.youtube }" />
<c:set var="map" value="${articlesVO.map }" />
<c:set var="file1" value="${articlesVO.file1 }" />
<c:set var="size1_label" value="${articlesVO.size1_label }" />
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
		> 콘텐츠 파일 수정
	</div>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_topicno.do?topicno=${topicno }&now_page=${param.now_page}&word=${param.word }">목록형</a>
		<span class='menu_divide'>│</span>
		<a href="./list_by_topicno_grid.do?topicno=${topicno }&now_page=${param.now_page}&word=${param.word }">갤러리형</a>

		<%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
		<c:if test="${sessionScope.manager_id != null }">
			<%--
      http://localhost:9093/articles/create.do?topicno=1
      http://localhost:9093/articles/create.do?topicno=2
      http://localhost:9093/articles/create.do?topicno=3
      --%>
			<span class='menu_divide'>│</span>
			<a href="./create.do?topicno=${topicno }">콘텐츠 등록</a>
			<span class='menu_divide'>│</span>
			<a href="./update_text.do?articlesno=${articlesno}&now_page=${param.now_page}&word=${param.word }">콘텐츠 수정</a>
			<span class='menu_divide'>│</span>
			<a href="./update_file.do?articlesno=${articlesno}&now_page=${param.now_page}">콘텐츠 파일 수정</a>
			<span class='menu_divide'>│</span>
			<a href="./map.do?topicno=${topicno }&articlesno=${articlesno}">Map</a>
			<span class='menu_divide'>│</span>
			<a href="./youtube.do?topicno=${topicno }&articlesno=${articlesno}">Youtube</a>
			<span class='menu_divide'>│</span>
			<a href="./delete.do?articlesno=${articlesno}&now_page=${param.now_page}&topicno=${topicno}">콘텐츠 삭제</a>
		</c:if>
	</aside>

	<div style="text-align: right; clear: both;">
		<form name='frm' id='frm' method='get' action='./list_by_topicno.do'>
			<input type='hidden' name='topicno' value='${param.topicno }'>
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


	<fieldset class="fieldset_basic">
		<ul>
			<li class="li_none">
				<div style="width: 100%; word-break: break-all;">

					<span style="font-size: 28px; margin-right: 5px;">🟡 ${title}</span>
					<span style="font-size: 0.6em; margin-right: 50px;">| 🔔 등록일: (${gdate.substring(0, 10)})</span>
					<br> <br>
					<span style="font-size: 15px; margin-bottom: 10px;">${article}</span>
				</div>
			</li>

			<c:choose>
				<c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
					<%-- /static/articles/storage/ --%>
					<div style="text-align: center; margin-bottom: 10px;">
						<img src="/articles/storage/${file1saved }"
							style='width: 35%; margin: 0 auto; margin-top: 0.5%; margin-right: 5%;'>
					</div>

				</c:when>
				<c:otherwise>
					<!-- 기본 이미지 출력 -->
					<img src="/articles/images/none1.png"
						style='width: 35%; display: block; margin: 0 auto; margin-top: 0.5%; margin-right: 5%;'>
				</c:otherwise>
			</c:choose>

			<li class="li_none" style="clear: both; padding-top: 5px; padding-bottom: 5px;">
				<c:if test="${youtube.trim().length() > 0 }">
					<div style="text-align: center; margin-right: 10px;">${youtube }
						<c:if test="${map.trim().length() > 0 }">
							<div style="text-align: center; margin-right: 10px;">${map }</div>
						</c:if>
					</div>
				</c:if>
			</li>

			<li class="li_none" style="clear: both;">
				<br>
				<span style="font-size: 0.4em;">검색어(키워드): ${word }</span>
			</li>

			<li class="li_none">
				<div>
					<span style="font-size: 0.4em;">
						<c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <a href='/download?dir=/articles/storage&filename=${file1saved}&downname=${file1}'
								style="color: #9ACD32;">${file1}</a> (${size1_label}) 
            <a onclick="if (confirm('이미지 다운로드 하시겠습니까?') == false ) { return false; }"
								href='/download?dir=/articles/storage&filename=${file1saved}&downname=${file1}'>
								<img src="/articles/images/download.png" style="margin-left: 10px; margin-bottom: 5px; width: 20px;">
							</a>
						</c:if>
					</span>
				</div>
			</li>
		</ul>
	</fieldset>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>

