<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog Calendar</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
</head>

<body>
	<c:import url="/menu/top.do" />

	<div class='title_line' style="text-align: center;">🔔DeutschBlog Month Event🧡</div>

	<aside class="aside_right">
		<a href="javascript:location.reload();">새로고침</a>
		<c:if test="${sessionScope.manager_id != null }">
			<span class='menu_divide'>│</span>
			<a href="./create.do">일정 등록</a>
			<span class='menu_divide'>│</span>
			<a href="./list_all.do">목록형</a>
		</c:if>
	</aside>

	<div class="menu_line"></div>

	<div id='calendar'></div>

	<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    // 서버에서 받아온 이벤트 데이터(JSON 형식)
	    var events = [
		    <c:forEach var="event" items="${list}" varStatus="loop">
		    {
            	title: '<c:out value="${event.title}"/>',
            	start: '<c:out value="${event.calstart}"/>T00:00:00',
            	end: '<c:out value="${event.calend}"/>T23:59:59',
            	color: getRandomColor()
        	}	<c:if test="${!loop.last}">,</c:if>
   	 		</c:forEach>
		];

		function getRandomColor() {
    		var letters = '0123456789ABCDEF';
    		var color = '#';

    		for (var i = 0; i < 6; i++) {
        		color += letters[Math.floor(Math.random() * 16)];
    		}
    		return color;
		}


	    var isManager = ${sessionScope.manager_id != null}; // 관리자 여부 확인

	    var calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'dayGridMonth',
	        headerToolbar: {
	            left: 'customPrev,customNext today',
	            center: 'title',
	            right: 'dayGridMonth,dayGridWeek,dayGridDay',
	        },

	        customButtons: {
	            customPrev: {
	                text: '<',
	                click: function() {
	                    calendar.prev();
	                }
	            },
	            customNext: {
	                text: '>',
	                click: function() {
	                    calendar.next();
	                }
	            },
	        },

	        titleFormat: function(date) {
	            return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
	        },
	        selectable: true,
	        droppable: true,
	        editable: true,
	        nowIndicator: true,
	        locale: 'ko',
	        contentHeight: 'auto',
	        events: events,
	        eventContent: function(arg) {
	            var title = arg.event.title;
	            return { html: '<div style="font-size: 10px; margin-left: 10px; color: #FF8C00;">' + title + '</div>' };
	        },
	    });

	    // dateClick 핸들러 함수는 calendar 객체 내부에서 정의되어야 함
	    calendar.setOption('dateClick', function(info) {
	        if (!isManager) {
	            // 방문자인 경우 페이지 이동 막기
	            console.log('Clicked on: ' + info.dateStr);
	            // 여기에 방문자가 클릭했을 때 실행할 코드 추가 가능
	        } else {
	            // 관리자인 경우 페이지 이동 허용
	            window.location.href = './create.do';
	        }
	    });

	    calendar.render();
	});
</script>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
