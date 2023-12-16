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
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<c:import url="/menu/top.do" />
	<div class='title_line'>회원 목록(관리자)</div>
	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
		<span class='menu_divide'>│</span>
		<a href='./create.do'>회원 가입</a>
		<span class='menu_divide'>│</span>
		<a href='./list.do'>목록</a>
	</aside>
	<div class='menu_line'></div>
	<table class="table table-striped" style='width: 100%;'>
		<colgroup>
			<col style='width: 5%;' />
			<col style='width: 10%;' />
			<col style='width: 15%;' />
			<col style='width: 15%;' />
			<col style='width: 30%;' />
			<col style='width: 15%;' />
			<col style='width: 10%;' />
		</colgroup>
		<tr>
			<TH class='th_bs'></TH>
			<TH class='th_bs'>ID</TH>
			<TH class='th_bs'>성명</TH>
			<TH class='th_bs'>전화번호</TH>
			<TH class='th_bs'>주소</TH>
			<TH class='th_bs'>가입일</TH>
			<TH class='th_bs'></TH>
		</tr>
		<c:forEach var="germanVO" items="${list }">
			<c:set var="germanno" value="${germanVO.germanno}" />
			<c:set var="grade" value="${germanVO.grade}" />
			<c:set var="id" value="${germanVO.id}" />
			<c:set var="mname" value="${germanVO.mname}" />
			<c:set var="tel" value="${germanVO.tel}" />
			<c:set var="address1" value="${germanVO.address1}" />
			<c:set var="mdate" value="${germanVO.mdate}" />
			<tr>
				<td class='td_basic'>
					<c:choose>
						<c:when test="${grade >= 1 and grade <= 10}">
							<img src='/german/images/manager.png' title="관리자" class="icon">
							<a href="https://www.flaticon.com/kr/free-icons/" title="아이콘  제작자: Vitaly Gorbachev - Flaticon"></a>
						</c:when>
						<c:when test="${grade >= 11 and grade <= 20}">
							<img src='/german/images/user.png' title="회원" class="icon">
							<a href="https://www.flaticon.com/kr/free-icons/" title="아이콘  제작자: Vitaly Gorbachev - Flaticon"></a>
						</c:when>
						<c:when test="${grade >= 30 and grade <= 39}">
							<img src='/german/images/pause.png' title="정지 회원" class="icon">
							<a href="https://www.flaticon.com/kr/free-icons/" title="아이콘  제작자: Vitaly Gorbachev - Flaticon"></a>
						</c:when>
						<c:when test="${grade >= 40 and grade <= 49}">
							<img src='/german/images/x.png' title="탈퇴 회원" class="icon">
							<a href="https://www.flaticon.com/kr/free-icons/" title="아이콘  제작자: Vitaly Gorbachev - Flaticon"></a>
						</c:when>
					</c:choose>
				</td>
				<td class='td_left'>
					<a href="./read.do?germanno=${germanno}">${id}</a>
				</td>
				<td class='td_left'>
					<a href="./read.do?germanno=${germanno}">${mname}</a>
				</td>
				<td class='td_basic'>${tel}</td>
				<td class='td_left'>
					<c:choose>
						<c:when test="${address1.length() > 15 }">
							<%-- 긴 주소 처리 --%>
            ${address1.substring(0, 15) }...
          </c:when>
						<c:otherwise>
            ${address1}
          </c:otherwise>
					</c:choose>
				</td>
				<td class='td_basic'>${mdate.substring(0, 10)}</td>
				<%-- 년월일 --%>
				<td class='td_basic'>
				<a href="./passwd_update.do?germanno=${germanno}"><img src='/german/images/passwd.png' title='패스워드변경' class="icon">
					</a>
					<a href="./read.do?germanno=${germanno}"><img src='/german/images/update.png' title='수정' class="icon">
					</a>
					<a href="./delete.do?germanno=${germanno}"><img src='/german/images/delete.png' title='삭제' class="icon">
					</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>