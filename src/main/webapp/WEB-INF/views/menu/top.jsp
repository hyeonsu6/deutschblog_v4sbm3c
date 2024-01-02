<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<style>
.icon_n {
	width: 30px;
}

.top_menu_link:link, .top_menu_link:visited {
	text-decoration: none;
	color: #583E26;
	font-size: 16px;
}

.top_menu_link:hover {
	text-decoration: blink;
	color: #EC9704;
	font-size: 17px;
}

.navbar-brand img {
	transform: rotate(-15deg);
	transition: transform 0.5s ease-in-out;
}

.navbar-brand img:hover {
	transform: rotate(15deg);
}
</style>

<div class='container_main'>
	<div style="text-align: right; margin-right: 5px;">
		<c:choose>
			<c:when test="${sessionScope.id == null}">
				<a class="nav-link top_menu_link" href="/german/login.do" style="display: inline-block;">로그인</a>
				<span style="color: #006400;">|</span>
				<a class="nav-link top_menu_link" href="/german/create.do" style="display: inline-block;">회원가입</a>
			</c:when>
			<c:otherwise>
				<a class="nav-link top_menu_link" href='/german/logout.do'>${sessionScope.id } 로그아웃</a>
			</c:otherwise>
		</c:choose>
	</div>

	<nav class="navbar navbar-expand-md navbar-dark"
		style="background-color: #FDF5E6; padding-left:2%; border-top: 2px solid #583E26; border-bottom: 3px solid #583E26; border-radius: 10px;">
		<a class="navbar-brand" href="/">
			<img src='/css/images/home.png' title="시작페이지" style='display: block; margin-left: 15px; padding-left: 3px;'
				class='icon_n'>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse"
			aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle Navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarCollapse">
			<ul class="navbar-nav mr-auto">
				<%-- 게시판 목록 출력 --%>
				<c:forEach var="topicVO" items="${list_top}">
					<c:set var="topicno" value="${topicVO.topicno }" />
					<c:set var="name" value="${topicVO.name }" />
					<li class="nav-item">
						<%-- 서브 메뉴가 없는 독립메뉴 --%>
						<a class="nav-link top_menu_link" href="/articles/list_by_topicno.do?topicno=${topicVO.topicno }&now_page=1">${topicVO.name }</a>
					</li>
				</c:forEach>

				<li class="nav-item">
					<%-- 서브 메뉴가 없는 독립메뉴 --%>
					<a class="nav-link top_menu_link" href="/topic/list_all_member.do">카테고리🗂️</a>
				</li>

				<li class="nav-item">
					<%-- 서브 메뉴가 없는 독립메뉴 --%>
					<a class="nav-link top_menu_link" href='/calendar/list_all_calendar.do'>Calendar📅</a>
				</li>

				<c:choose>
					<c:when test="${sessionScope.manager_id == null }">
						<li class="nav-item">
							<a class="nav-link top_menu_link" href="/manager/login.do">관리자 로그인</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="nav-item dropdown">
							<%-- 관리자 서브 메뉴 --%>
							<a class="nav-link top_menu_link dropdown-toggle" data-bs-toggle="dropdown" href="#" style="color: #EC9704;">관리자</a>
							<div class="dropdown-menu top_menu_link">
								<a class="dropdown-item top_menu_link" href='/topic/list_all.do'>[관리자] 전체 카테고리 목록</a>
								<a class="dropdown-item top_menu_link" href='/articles/list_all.do'>[관리자] 전체 컨텐츠 목록</a>
								<a class="dropdown-item top_menu_link" href='/calendar/create.do'>[관리자] Calendar 등록</a>
								<a class="dropdown-item top_menu_link" href='/calendar/list_all.do'>[관리자] Calendar 목록</a>
								<a class="dropdown-item top_menu_link" href="/articles/list_all_gallery.do">[관리자] 🖼️ 컨텐츠 갤러리</a>
								<a class="dropdown-item top_menu_link" href='/german/list.do'>[관리자] 회원 목록</a>
								<a class="dropdown-item top_menu_link" href='/login/list_all_alogin.do'>[관리자] 로그인 내역</a>
								<a class="dropdown-item top_menu_link" href='/manager/logout.do'>[관리자] '${sessionScope.manager_id }' 로그아웃</a>
							</div>
						</li>
					</c:otherwise>
				</c:choose>

				<li class="nav-item dropdown">
					<%-- 회원 서브 메뉴 --%>
					<a class="nav-link top_menu_link dropdown-toggle" data-bs-toggle="dropdown" href="#" style="color: #EC9704;">회원</a>
					<div class="dropdown-menu top_menu_link">
						<c:choose>
							<c:when test="${sessionScope.id == null }">
								<a class="dropdown-item top_menu_link" href="/german/create.do">회원 가입</a>
								<a class="dropdown-item top_menu_link" href="#">아이디 찾기</a>
								<a class="dropdown-item top_menu_link" href="#">비밀번호 찾기</a>
							</c:when>
							<c:otherwise>
								<a class="dropdown-item top_menu_link" href="/german/read.do">[회원] 가입 정보</a>
								<a class="dropdown-item top_menu_link" href="/german/read.do">[회원] 정보 수정</a>
								<a class="dropdown-item top_menu_link" href="/german/passwd_update.do">[회원] 비밀번호 변경</a>
								<a class="dropdown-item top_menu_link" href="/german/unsubscribe.do">[회원] 탈퇴</a>
								<a class="dropdown-item top_menu_link" href="/login/list_mlogin_by_memberno.do">[회원] 로그인 내역</a>
							</c:otherwise>
						</c:choose>
					</div>
				</li>
			</ul>
		</div>
	</nav>
	<div class='content_body'>
		<!--  내용 시작 -->