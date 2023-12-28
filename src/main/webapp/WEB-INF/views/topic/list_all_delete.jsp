<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog💛 Category</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body>
	<c:import url="/menu/top.do" />

	<div class='title_line'>[ME✨] 카테고리 삭제</div>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
	</aside>

	<div class="menu_line"></div>

	<div id='panel_delete'
		style='margin: 20px auto; padding: 10px 0px 10px 0px; background-color: #F8F8FF; width: 100%; text-align: center;'>

		<form name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
			<input type="hidden" name="topicno" value="${topicVO.topicno }">
			<%-- 삭제할 카테고리 번호 --%>
			<c:choose>
				<c:when test="${count_by_topicno >= 1 }">
					<%-- 자식 레코드가 있는 상황 --%>
					<div class="msg_warning">
						관련 자료 ${count_by_topicno } 건이 발견되었습니다.<br> 관련 콘텐츠와 카테고리를 모두 삭제하시겠습니까?
					</div>

					<label style="margin-right: 5px;">관련 카테고리 이름</label> 
					${topicVO.name } 
					<a href="../articles/list_by_topicno.do?topicno=${topicVO.topicno }&now_page=1" title="관련 카테고리로 이동">
						<img src='/topic/images/link.png' class="icon">
					</a>
					<button type="submit" id='submit' class="btn btn-outline-warning btn-sm" style="background-color: #583E26;">관련
						콘텐츠와 함께 카테고리 삭제</button>

				</c:when>
				<c:otherwise>
					<%-- 자식 레코드가 없는 상황 --%>
					<div class="msg_warning" style="margin-bottom: 10px;">페스티벌 카테고리를 삭제하면 복구할 수 없습니다.</div>
					<label style="margin-right: 10px;">카테고리 이름</label>[ ${topicVO.name } ]
      
          <button type="submit" id='submit' class="btn btn-outline-warning btn-sm" style="background-color: #583E26;">삭제하기</button>
				</c:otherwise>
			</c:choose>

			<button type="button" onclick="location.href='/topic/list_all.do'" class="btn btn-outline-warning btn-sm"
				style="background-color: #583E26;">취소(목록)</button>
		</form>
	</div>

	<table>
		<colgroup>
			<col style='width: 10%;' />
			<col style='width: 40%;' />
			<col style='width: 10%;' />
			<col style='width: 20%;' />
			<col style='width: 20%;' />
		</colgroup>

		<thead>
			<tr style="text-align: center;">
				<th class="th_bs">순서</th>
				<th class="th_bs">카테고리 이름</th>
				<th class="th_bs">등록된 콘텐츠 수</th>
				<th class="th_bs">등록일</th>
				<th class="th_bs"></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="topicVO" items="${list }" varStatus="info">
				<c:set var="topicno" value="${topicVO.topicno }" />

				<tr style="text-align: center;">
					<td>${info.count }</td>

					<td>
						<a href="../articles/list_by_topicno.do?topicno=${topicno }" style="display: block;">${topicVO.name }</a>
					</td>

					<td>${topicVO.cnt }</td>

					<td>${topicVO.gdate.substring(0, 10) }</td>

					<td>
						<a href="../articles/create.do?topicno=${topicno }" title="콘텐츠 등록">
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
							<img src="/topic/images/increase.png" class="icon">
						</a>
						<a href="./update_seqno_backward.do?topicno=${topicno }" title="우선 순위 낮춤">
							<img src="/topic/images/decrease.png" class="icon">
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
