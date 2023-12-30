<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" />
<title>DeutschBlog Calendar</title>
<link rel="shortcut icon" href="/images/germany.png" />
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script>
	var originalOrder; // 원래 순서를 저장할 변수

	function sortTable(column) {
		console.log("Function called");

		var table, rows, switching, i, x, y, shouldSwitch;
		table = document.getElementById("calendarTable");
		switching = true;

		// 원래 순서 저장
		if (!originalOrder) {
			originalOrder = Array.from(table.rows).slice(1); // 첫 번째 행은 헤더이므로 제외
		}

		while (switching) {
			switching = false;
			rows = table.rows;

			for (i = 1; i < rows.length - 1; i++) {
				shouldSwitch = false;
				x = rows[i].getElementsByTagName("td")[column];
				y = rows[i + 1].getElementsByTagName("td")[column];

				var dateX = new Date(x.innerHTML);
				var dateY = new Date(y.innerHTML);

				console.log("Comparing dates:", dateX, dateY, dateX > dateY);

				if (dateX > dateY) {
					shouldSwitch = true;
					break;
				}
			}

			if (shouldSwitch) {
				rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
				switching = true;
			}
		}
	}

	// 정렬 취소 함수
	function cancelSort() {
		var table = document.getElementById("calendarTable");
		var tbody = table.getElementsByTagName("tbody")[0];

		// 원래 순서로 복원
		tbody.innerHTML = "";
		originalOrder.forEach(function(row) {
			tbody.appendChild(row);
		});

		// 원래 순서 초기화
		originalOrder = null;
	}

	function toggleColumn(colIndex) {
		const checkboxes = document
				.querySelectorAll(`input[name="col${colIndex}"]`);
		const headerCheckbox = document
				.querySelector(`th:nth-child(${colIndex + 1}) input[type="checkbox"]`);

		if (!headerCheckbox) {
			console.error(`Header checkbox for column ${colIndex} not found.`);
			return;
		}

		const checked = headerCheckbox.checked;

		checkboxes.forEach(function(checkbox) {
			checkbox.checked = !checked;
		});
	}

	function toggleAllColumns() {
		for (let i = 0; i <= 5; i++) {
			toggleColumn(i);
		}
	}
</script>
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
			<a href="./list_all_calendar.do">달력형</a>
		</c:if>
	</aside>

	<div class="menu_line"></div>

	<button onclick="sortTable(3)" class="btn btn-outline-warning btn-sm"
		style="background-color: #583E26; margin-bottom: 5px;">시작일 정렬</button>
	<button onclick="cancelSort()" class="btn btn-outline-warning btn-sm"
		style="background-color: #583E26; margin-bottom: 5px;">정렬 취소</button>

	<c:if test="${not empty list}">
		<table id="calendarTable">
			<colgroup>
				<col style="width: 10%;"></col>
				<col style="width: 30%;"></col>
				<col style="width: 30%;"></col>
				<col style="width: 10%;"></col>
				<col style="width: 10%;"></col>
				<col style="width: 10%;"></col>
			</colgroup>

			<thead>
				<tr style="text-align: center;">
					<th onclick="sortTable(0)">번호</th>
					<th onclick="sortTable(1)">제목</th>
					<th onclick="sortTable(2)">메모</th>
					<th onclick="sortTable(3)">시작일</th>
					<th onclick="sortTable(4)">종료일</th>
					<th onclick="sortTable(5)"></th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="calVO" items="${list}">
					<c:set var="calno" value="${calVO.calno }" />
					<c:set var="title" value="${calVO.title }" />
					<c:set var="memo" value="${calVO.memo }" />
					<c:set var="calstart" value="${calVO.calstart }" />
					<c:set var="calend" value="${calVO.calend }" />

					<tr style="cursor: pointer; text-align: center;">
						<td>${calno}</td>
						<td>
							<a href="./read.do?calno=${calno}" style="cursor: pointer; text-align: center;">${title}</a>
						</td>
						<td>
							<c:choose>
								<c:when test="${memo.length() > 120 }">${memo.substring(0, 120) }...</c:when>
								<c:otherwise>
								${memo}
							</c:otherwise>
							</c:choose>
						</td>
						<td>
							${calstart}
						</td>
						<td>
							${calend}
						</td>
						<td>
							<a href="/calendar/delete.do?calno=${calno }" title="삭제">
								<img src="/articles/images/delete.png" class="icon">
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<div class='menu_line'></div>
	<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>