<%@page import="gnotice.model.vo.GNotice"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    boolean isMem = (boolean)request.getAttribute("isMem");
    ArrayList<GNotice> noticeList = (ArrayList<GNotice>)request.getAttribute("noticeList");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
	<div class="container">
	테스트테스트<br>
	아무나 보이는 영역<br>
		<%if(isMem) {%>
		회원만 보이는 영역
		<table>
			<%for(GNotice n : noticeList) {%>
			<tr>
				<td><a href="/gNoticeView?noticeNo=<%=n.getgNoticeNo()%>"><%=n.getgNoticeTitle() %></a></td>
				<td><%=n.getgNoticeDate() %></td>
			</tr>
			<%} %>
		</table>
		<table>
		
		</table>
		<%} %>
	</div>
</body>
</html>