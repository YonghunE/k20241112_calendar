<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.mbcit.myCalendar.MyCalendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만년 달력</title>

<style type="text/css">

	table {
		/* border: 선두께 선종류 선색상 */
		border: 0px solid tomato;
	}

	tr {
		height: 80px; /* 높이 */
		border-width: 0px; /* 선 두께 */
	}
	
	th {
		width: 100px; /* 너비 */
		font-size: 25px; /* 글꼴 크기 */
		border-width: 0px;
	}
	
	th#title {
		font-size: 35px;
		font-family: D2Coding; /* 글꼴 이름 */
		font-weight: bold; /* 굵게 */
		color: tomato; /* 글꼴 색상 */
	}
	
	td {
		text-align: right; /* 수평 정렬 */
		vertical-align: top; /* 수직 정렬 */
		font-weight: bold;
		border: 1px solid black;
		border-radius: 10px; /* 모서리가 둥근 사각형 */
	}
	
	/* th#sunday와 td.sun에 같은 스타일이 적용되므로 ","로 나열해서 스타일을 지정할 수 있다. */
	th#sunday, td.sun {
		color: red;
	}
	
	/* th#saturday와 td.sat에 같은 스타일이 적용되므로 ","로 나열해서 스타일을 지정할 수 있다. */
	th#saturday, td.sat {
		color: blue;
	}

	td#choice {
		text-align: center;
		vertical-align: middle;
		border-width: 0px;
	}

	td#beforesun {
		color: red;
		font-size: 12px;
		background-color: lavender;
	}

	td.before {
		font-size: 12px;
		background-color: lavender;
	}

	td#aftersat {
		color: blue;
		font-size: 12px;
		background-color: yellowgreen;
	}

	td.after {
		font-size: 12px;
		background-color: yellowgreen;
	}

	td.holiday {
		color: white;
		background-color: red;
	}
	
	span {
		font-size: 10px;
	}

	/*
	하이퍼링크 스타일 지정하기
	link: 1번도 클릭하지 않은 하이퍼링크
	visited: 1번 이상 클릭한 하이퍼링크
	hover: 하이퍼링크 위에 마우스를 올리고 있을 때
	active: 하이퍼링크를 마우스로 누르고 있을 떼
	text-decoration: 글자 장식
	
	a:link {
		color: black;
		text-decoration: none;
	}

	a:visited {
		color: black;
		text-decoration: none;
	}
	
	a:link와 a:visited에 같은 스타일이 적용되므로 ","로 나열해서 스타일을 지정할 수 있다.
	a:link, a:visited {
		color: black;
		text-decoration: none;
	}
	*/
	
	a {
		color: black;
		text-decoration: none;
	}
	
	a:hover {
		color: hotpink;
		text-decoration: none;
	}
	
	a:active {
		color: yellowgreen;
		text-decoration: none;
	}

	.button {
		background-color: #04AA6D; /* Green */
		border: none;
		color: white;
		padding: 10px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 16px;
		margin: 4px 2px;
		transition-duration: 0.4s;
		cursor: pointer;
	}
	
	.button1 {
		background-color: white; 
		color: black; 
		border: 2px solid #04AA6D;
	}
	
	.button1:hover {
		background-color: #04AA6D;
		color: white;
	}

	.button2 {
		background-color: white; 
		color: black; 
		border: 2px solid #008CBA;
	}
	
	.button2:hover {
		background-color: #008CBA;
		color: white;
	}

	.select {
		width: 100px;
		height: 30px;
	}

</style>

</head>
<body>

<%
//	달력 메소드 테스트
//	out.println(MyCalendar.isLeapYear(2024));
//	out.println(MyCalendar.lastDay(2024, 2));
//	out.println(MyCalendar.totalDay(2024, 11, 11));
//	out.println(MyCalendar.weekDay(2024, 11, 11));

//	컴퓨터 시스템의 년, 월을 얻어온다.
//	Date date = new Date();
//	int year = date.getYear() + 1900;
//	int month = date.getMonth() + 1;
	Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;
//	out.println(year + "년 " + month + "월");

//	이전달, 다음달 하이퍼링크 또는 버튼을 클릭하면 get 방식으로 넘어오는 달력을 출력할 년, 월을 받는다.
//	달력이 처음 실행되면 이전 페이지가 존재하지 않아서 넘어오는 데이터가 없기 때문에 year와 month는 null이다.
//	null은 parseInt()를 실행하면 NumberFormatException이 발생되기 때문에 예외 처리를 해야한다.
	try {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		
		// month에 13이 넘어오면 달력에 다음해 1월을 출력해야 하고 month에 0이 넘어왔으면 전년도 12월을
		// 달력에 출력해야 한다.
		if (month >= 13) {
			year++;
			month = 1;
		} else if (month <= 0) {
			year--;
			month = 12;
		}
	} catch (NumberFormatException e) {
		
	}
%>

<table width="700" border="1" align="center" cellpadding="5" cellspacing="0">
	<tr>
		<th>
			<!--
			<a> 태그가 설정된 문자열을 클릭하면 href 속성에 지정된 곳으로 이동한다.
			href 속성에 "#(해시)"뒤에 id를 지정하면 현재 문서에 id 속성이 지정된 요소로 이동(책갈피)하고
			url(주소)이 지정되면 지정된 url로 이동한다.
			"?"뒤에 이동하려는 페이지로 데이터를 넘겨줄 수 있는데 이 때 넘겨줄 데이터가 2건 이상이라면
			데이터와 데이터 사이에 "&"를 넣어서 구분한다.
			"?" 뒤에는 절대로 띄어쓰기를 하면 안된다.
			-->
			<%-- <a href="?year=<%=year%>&month=<%=month - 1%>">이전달</a> --%>
			<input class="button button1" type="button" value="이전달" onclick="location.href='?year=<%=year%>&month=<%=month - 1%>'">
		</th>
		<th id="title" colspan="5">
			<%=year%>년 <%=month%>월
		</th>
		<th>
			<%-- <a href="?year=<%=year%>&month=<%=month + 1%>">다음달</a> --%>
			<button class="button button2" type="button" onclick="location.href='?year=<%=year%>&month=<%=month + 1%>'">다음달</button>
		</th>
	</tr>
	<tr>
		<th id="sunday">일</th>
		<th>월</th>
		<th>화</th>
		<th>수</th>
		<th>목</th>
		<th>금</th>
		<th id="saturday">토</th>
	</tr>
	<!-- 달력에 날짜를 출력한다. -->
	<tr>
<%
	int week = MyCalendar.weekDay(year, month, 1);
	
//	1일이 출력될 위치(요일)을 맞추기 위해 달력을 출력할 달 1일의 요일만큼 반복하며 빈 칸을 출력한다.
//	for (int i = 0; i < week; i++) {
//		out.println("<td>&nbsp;</td>");
//	}

//	빈 칸에 출력할 전달 날짜의 시작일을 계산한다.
	int start = 0;
	if (month == 1) {
		// start = MyCalendar.lastDay(year - 1, 12) - week; // 1월
		start = 31 - week;
	} else {
		start = MyCalendar.lastDay(year, month - 1) - week; // 2 ~ 12월
	}

//	1일이 출력될 위치(요일)을 맞추기 위해 달력을 출력할 달 1일의 요일만큼 반복하며 전달 날짜를 출력한다.
	for (int i = 0; i < week; i++) {
		if (i == 0) {
			out.println("<td id='beforesun'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
		} else {
			out.println("<td class='before'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
		}
	}

//	1일부터 달력을 출력할 달의 마지막 날짜까지 반복하며 날짜를 출력한다.
	for (int i = 1; i <= MyCalendar.lastDay(year, month); i++) {
		
		// 대체 공휴일
		// 삼일절, 어린이날, 광복절, 개천절, 한글날, 크리스마스가 토요일 또는 일요일과 겹치면
		// 다음 첫 번째 비 공휴일을 대체 공휴일로 한다.
		boolean flag0301 = false;
		int subHoliday0301 = 0;
		if (MyCalendar.weekDay(year, 3, 1) == 6) {
			flag0301 = true;
			subHoliday0301 = 3;
		} else if (MyCalendar.weekDay(year, 3, 1) == 0) {
			flag0301 = true;
			subHoliday0301 = 2;
		}
		
		boolean flag0505 = false;
		int subHoliday0505 = 0;
		if (MyCalendar.weekDay(year, 5, 5) == 6) {
			flag0505 = true;
			subHoliday0505 = 7;
		} else if (MyCalendar.weekDay(year, 5, 5) == 0) {
			flag0505 = true;
			subHoliday0505 = 6;
		}
		
		boolean flag0815 = false;
		int subHoliday0815 = 0;
		if (MyCalendar.weekDay(year, 8, 15) == 6) {
			flag0815 = true;
			subHoliday0815 = 17;
		} else if (MyCalendar.weekDay(year, 8, 15) == 0) {
			flag0815 = true;
			subHoliday0815 = 16;
		}
		
		boolean flag1003 = false;
		int subHoliday1003 = 0;
		if (MyCalendar.weekDay(year, 10, 3) == 6) {
			flag1003 = true;
			subHoliday1003 = 5;
		} else if (MyCalendar.weekDay(year, 10, 3) == 0) {
			flag1003 = true;
			subHoliday1003 = 4;
		}
		
		boolean flag1009 = false;
		int subHoliday1009 = 0;
		if (MyCalendar.weekDay(year, 10, 9) == 6) {
			flag1009 = true;
			subHoliday1009 = 11;
		} else if (MyCalendar.weekDay(year, 10, 9) == 0) {
			flag1009 = true;
			subHoliday1009 = 10;
		}
		
		boolean flag1225 = false;
		int subHoliday1225 = 0;
		if (MyCalendar.weekDay(year, 12, 25) == 6) {
			flag1225 = true;
			subHoliday1225 = 27;
		} else if (MyCalendar.weekDay(year, 12, 25) == 0) {
			flag1225 = true;
			subHoliday1225 = 26;
		}
		
		// 양력 공휴일일 출력한다.
		if (month == 1 && i == 1) {
			out.println("<td class='holiday'>" + i + "<br><span>새해첫날</span></td>");
		} else if (month == 3 && i == 1) {
			out.println("<td class='holiday'>" + i + "<br><span>삼일절</span></td>");
		} else if (month == 5 && i == 1) {
			out.println("<td class='holiday'>" + i + "<br><span>근로자의날</span></td>");
		} else if (month == 5 && i == 5) {
			out.println("<td class='holiday'>" + i + "<br><span>어린이날</span></td>");
		} else if (month == 6 && i == 6) {
			out.println("<td class='holiday'>" + i + "<br><span>현충일</span></td>");
		} else if (month == 8 && i == 15) {
			out.println("<td class='holiday'>" + i + "<br><span>광복절</span></td>");
		} else if (month == 10 && i == 3) {
			out.println("<td class='holiday'>" + i + "<br><span>개천절</span></td>");
		} else if (month == 10 && i == 9) {
			out.println("<td class='holiday'>" + i + "<br><span>한글날</span></td>");
		} else if (month == 12 && i == 25) {
			out.println("<td class='holiday'>" + i + "<br><span>크리스마스</span></td>");
		}
		
		// 대체 공휴일을 출력한다.
		else if (flag0301 && month == 3 && i == subHoliday0301) {
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		} else if (flag0505 && month == 5 && i == subHoliday0505) {
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		} else if (flag0815 && month == 8 && i == subHoliday0815) {
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		} else if (flag1003 && month == 10 && i == subHoliday1003) {
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		} else if (flag1009 && month == 10 && i == subHoliday1009) {
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		} else if (flag1225 && month == 12 && i == subHoliday1225) {
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		}
		
		// 공휴일을 제외한 나머지 날짜를 출력한다.
		else {
			//	<td> 태그에 요일에 따른 class 속성을 부여한다.
			/*
			if (MyCalendar.weekDay(year, month, i) == 0) { // 일요일?
				out.println("<td class='sun'>" + i + "</td>");
			} else if (MyCalendar.weekDay(year, month, i) == 6) { // 토요일?
				out.println("<td class='sat'>" + i + "</td>");
			} else {
				out.println("<td>" + i + "</td>");
			}
			*/
			switch (MyCalendar.weekDay(year, month, i)) {
				case 0:
					out.println("<td class='sun'>" + i + "</td>");
					break;
				case 6:
					out.println("<td class='sat'>" + i + "</td>");
					break;
				default:
					out.println("<td>" + i + "</td>");
					break;
			}
		}
		
		// 출력한 날짜가 토요일이고 그 달의 마지막 날짜가 아니면 줄을 바꾼다.
		if (MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)) {
			out.println("</tr><tr>");
		}
	}

//	날짜를 다 출력하고 남은 빈 칸에 다음달 날짜를 출력한다.
	int last = MyCalendar.weekDay(year, month, MyCalendar.lastDay(year, month));
	for (int i = 1; i <= 6 - last; i++) {
		if (i == 6 - last) {
			out.println("<td id='aftersat'>" + (month == 12 ? 1 : month + 1) + "/" + i + "</td>");
		} else {
			out.println("<td class='after'>" + (month == 12 ? 1 : month + 1) + "/" + i + "</td>");
		}
	}
%>
	</tr>
	<!-- 년, 월을 선택하고 보기 버튼을 클릭하면 선택된 달의 달력으로 한번에 넘어가게 한다. -->
	<tr>
		<td id="choice" colspan="7">
			<form action="?" method="post">
				<select class="select" name="year">
<%
	for (int i = 1900; i <= 2100; i++) {
		if (calendar.get(Calendar.YEAR) == i) {
//		if (year == i) {
			out.println("<option selected='selected'>" + i + "</option>");
		} else {
			out.println("<option>" + i + "</option>");
		}
	}
%>
				</select>년
				<select class="select" name="month">
<%
	for (int i = 1; i <= 12; i++) {
		if (calendar.get(Calendar.MONTH) + 1 == i) {
//		if (month == i) {
			out.println("<option selected='selected'>" + i + "</option>");
		} else {
			out.println("<option>" + i + "</option>");
		}
	}
%>
				</select>월
				<input class="select" type="submit" value="보기">
			</form>
		</td>
	</tr>
</table>

</body>
</html>
























