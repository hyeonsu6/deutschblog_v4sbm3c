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

<%
	TopicVO topicVO = (TopicVO) request.getAttribute("topicVO");
int topicno = topicVO.getTopicno();
String name = topicVO.getName();
%>
<body>
	<jsp:include page="../menu/top.jsp" flush='false' />
	<div class='title_line'>
		카테고리 > [<%=name%>] 삭제
	</div>
	<div id='panel_delete'
		style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
		<form name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
			<input type="hidden" name="topicno" value="<%=topicno%>">

			<div class="msg_warning">카테고리를 삭제하면 복구 할 수 없습니다.</div>
			<label>카테고리 이름</label>:
			<%=name%>

			<button type="submit" id='submit' class='btn btn-warning btn-sm' style='height: 28px; margin-bottom: 5px;'>삭제</button>
			<button type="button" onclick="location.href='/topic/list_all.do'" class='btn btn-success btn-sm'
				style='height: 28px; margin-bottom: 5px;'>취소</button>
		</FORM>
	</DIV>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html> --%>