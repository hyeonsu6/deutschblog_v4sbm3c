<!-- 사용안함 -->

<%-- <%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="dev.mvc.topic.TopicVO"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>DeutschBlog</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../menu/top.jsp" flush='false' />
	<div class='title_line'>카테고리 조회</div>
	<%
		TopicVO topicVO = (TopicVO) request.getAttribute("topicVO");
	%>
	<div class="container mt-3">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				번호:
				<%=topicVO.getTopicno()%></li>
			<li class="list-group-item">
				이름:
				<%=topicVO.getName()%></li>
			<li class="list-group-item">
				등록글 수:
				<%=topicVO.getCnt()%></li>
			<li class="list-group-item">등록일: ${topicVO.gdate.substring(0, 10)}</li>
		</ul>
	</div>
	<div class="content_body_bottom">
		<button type="button" onclick="location.href='./create.do'" class="btn btn-dark btn-sm">등록</button>
		<button type="button" onclick="location.href='./list_all.do'" class="btn btn-dark btn-sm">목록</button>
	</div>

	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html> --%>