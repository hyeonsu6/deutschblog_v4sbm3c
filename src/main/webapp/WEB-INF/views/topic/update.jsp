<%@ page contentType="text/html; charset=UTF-8"%>
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
	<div class='title_line'>카테고리 수정</div>
	<%
		TopicVO topicVO = (TopicVO) request.getAttribute("topicVO");
	int topicno = topicVO.getTopicno();
	%>
	<form name='frm' method='post' action='/topic/update.do'>
		<input type='hidden' name='topicno' value='<%=topicno%>'>
		<div>
			<label>카테고리 이름</label> <input type="text" name="name" value="<%=topicVO.getName()%>" required="required"
				autofocus="autofocus" class="form-control form-control-sm" style="width: 50%">
		</div>

		<div style="margin-top: 20px;">
			<label>글 수</label> <input type="text" name="cnt" value="<%=topicVO.getCnt()%>" required="required"
				autofocus="autofocus" class="form-control form-control-sm" style="width: 50%">
		</div>

		<div class="content_body_bottom">
			<button type="submit" class="btn btn-dark btn-sm">저장</button>
			<button type="button" onclick="history.back();" class="btn btn-dark btn-sm">취소</button>
		</div>
	</form>

	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>