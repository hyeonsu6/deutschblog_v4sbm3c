<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>http://localhost:9092/</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body>
	<span class="top_menu_label" style="margin-top: 3px; margin-left: 75px;">DeutschBlog Version 4.0</span>
	<div class="top_img"></div>

	<c:import url="/menu/top.do" />


	<div style="width: 45%; margin: 15px auto;">
		<img src="/images/index_main.jpg" style="width: 100%;">
	</div>

	<jsp:include page="./menu/bottom.jsp" flush='false' />
</body>
</html>