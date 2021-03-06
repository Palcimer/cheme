<%@page import="gallery.model.vo.Gallery"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    ArrayList<Gallery> list = (ArrayList<Gallery>)request.getAttribute("list");
    String pageNavi = (String)request.getAttribute("pageNavi");
    int groupId = (Integer)request.getAttribute("groupId");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/bootstrap.min.css">
<title>Insert title here</title>
<style>
	.photoWrapper{
		padding-top : 20px;
		
		display : flex;
		justify-content: space-around;
		flex-wrap : wrap;
	}
	.photo{	
		margin-top : 30px;
		width : 30%;
		height: 300px;
		overflow : hidden;
		
	}
	.photo img{
		width : 100%;
		height : 70%;
	}
	#pageNavi>* {
		justify-content: center !important;
	}
	.write-btn{
		text-align : right;
	}

</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class="container">
		<fieldset>
			<legend>갤러리</legend>
			<%if (m != null ) {%>			
			<div class="write-btn">
				<a class="btn btn-info writeBtn" href="/galleryWriteFrm?groupId=<%=groupId%>">글쓰기</a>
			</div>			
			<%} %>
			<div class="photoWrapper">
				<%for(int i=0;i<list.size();i++) { %>
					<div class="photo">
						<a href="/galleryView?galleryNo=<%=list.get(i).getGalleryNo()%>"><img src="/upload/photo/<%=list.get(i).getGalleryFilepath()%>"></a>
						<table class="table">
						<tr>
						<th colspan="4">제목 : <a href="/galleryView?galleryNo=<%=list.get(i).getGalleryNo()%>"><%=list.get(i).getGalleryTitle()%></a></th>
						</tr>
						<tr>
						<th scope="col">글쓴이 : <%=list.get(i).getGalleryNickName()%></th>
						<th scope="col">작성일 : <%=list.get(i).getGalleryDate()%></th>
						</tr>
						</table>
					</div>
				<%} %>
			</div>
			<br><br><br>
			<div id="pageNavi"><%=pageNavi %></div>
		</fieldset>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>