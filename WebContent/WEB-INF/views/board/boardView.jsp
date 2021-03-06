<%@page import="member.model.vo.Member"%>
<%@page import="board.model.vo.Board"%>
<%@page import="board.model.vo.BoardComment"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    
    Board b = (Board)request.getAttribute("b");
    ArrayList<BoardComment> list = (ArrayList<BoardComment>)request.getAttribute("list");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	.view-photo{
		text-align: center;
	}
	#photo{
		border-bottom: none;
	}
	.view-photo>img{
		width : 750px;
		margin : 0 auto;
	}
	.title{
		text-align: center;
		width : 40%;
	}
	.writer{
		width : 30%;
	}
	.date{
		text-align: right;
		width : 30%;
	}	
	.list{
		text-align: right;
	}
	li{
		list-style-type: none;
		margin-left: 5px;
	}
	.profile{
		width: 100px;
        height: 100px;
	}
	.commentWrap{
		display : flex;
	}
	.btn-box{
		display: flex;
		align-items: flex-end;
	}
	
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<br><br><br>
	<div class="container">
		<fieldset>
			<legend>자유게시판</legend>
			<table class="table" id="boardView" style="width:100%;">
				<tr class="table-info">
					<th colspan="4"><%=b.getBoardTitle() %></th>
				</tr>	
				<tr class="table-light">
					<th>작성자</th>
					<th><%=b.getBoardMember() %></th>
					<th>작성일</th>
					<th><%=b.getDate() %></th>
				</tr>
				<tr class="table-light">
					<th>첨부파일</th>
					<th colspan="3">
						<%if(b.getFileName()!=null) {%>						
						<img src="/img/file.png" width="16px">
						<a href="/fileDown?boardNo=<%=b.getBoardNo()%>"><%=b.getFileName() %></a>						
						<%} %>
					</th>
				</tr>
				<tr class="table-light">
					<th>내용</th>
					<th colspan="3">
						<%=b.getBoardContent() %>
					</th>
				</tr>
				<tr class="table-light">
					<th colspan="4" style="text-align:center;">
						<button class="btn btn-info" onclick="history.go(-1);">이전화면</button>
						<%if(m!=null && m.getMemberId().equals(b.getBoardMember())){ %>
						<a class="btn btn-info" href="/boardUpdateFrm?boardNo=<%=b.getBoardNo() %>">수정하기</a>
						<a class="btn btn-info" href="/boardDelete?boardNo=<%=b.getBoardNo() %>">삭제하기</a>
						<%} %>
					</th>
				</tr>
			</table>
		</fieldset>
		<%if(m!=null) { %>
		<div class="inputCommentBox">
			<form action="/galleryInsertComment" method="post">
				<ul class="commentWrap">
					<li>
						<img class="profile" src="/img/user3.png">
					</li>
					<li>
						<input type="hidden" name="galleryCommentLevel" value="1">
						<input type="hidden" name="galleryCommentWriter" value="<%=m.getMemberName() %>">
						<input type="hidden" name="galleryNo" value="<%=b.getBoardNo() %>">
						<input type="hidden" name="galleryCommentRef" value="0">
						<textarea class="form-control" name="galleryCommentContent" style = "resize: none; width: 900px; height: 100px"></textarea>
					</li>
					<li class="btn-box">
						<button type="submit" class="btn btn-primary btn-lg btn btn-block down-btn">등록</button>
					</li>
				</ul>
			</form>
		</div>
		<%} %>
		<%--댓글 출력 시작 --%>
		<div class="commentBox">
			<%for(BoardComment bc : list) {%>
			<%if(bc.getLevel() == 1) {%>
			<ul class="comments">
				<li>
					<i class="far fa-user fa-3x"></i>
					<p><%=bc.getCommentWriter()%></p>
					<p><%=bc.getDate()%></p>
				</li>
				<li>
					<p><%=bc.getCommentContentBr()%></p>
					<textarea name="bcContent" class="form-control" style="display:none;"><%=bc.getCommentContent() %></textarea>
					<p class="commentsBtn">
					<%if(m != null) {%>
						<%if(m.getMemberId().equals(bc.getCommentWriter())) {%>
							<a href="javascript:void(0)" onclick="modifyComment(this,'<%=bc.getCommentNo()%>','<%=b.getBoardNo()%>');">수정</a>
							<a href="javascript:void(0)" onclick="deleteComment(this,'<%=bc.getCommentNo()%>','<%=b.getBoardNo()%>');">삭제</a>
						<%} //댓글 작성자와 로그인 회원이 일치하는 경우 %>
						<a href="javascript:void(0)" class="recShow">답글달기</a>
					<%} //로그인 되어있는경우 %>
					</p>
					<%if(m != null) {%>
					<form action = "/insertComment" class="recoment">
						<input type="hidden" name="bcLevel" value="2">
						<input type="hidden" name="bcWriter" value="<%=m.getMemberId() %>">
						<input type="hidden" name="boardRef" value="<%=b.getBoardNo() %>">
						<input type="hidden" name="bcRef" value="<%=bc.getCommentNo()%>">
						<textarea class="form-control" name="bcContent"></textarea>
						<div>
							<button type="submit" class="btn btn-outline-primary">등록</button>
							<button type="button" class="btn btn-outline-primary recCancel">취소</button>
						</div>
					</form>
					<%} %>
				</li>
			</ul>
				<%for(BoardComment bcc : list){ %>
					<%if(bcc.getLevel()== 2 && bcc.getBcRef()== bc.getCommentNo()) {%>
						<ul class="recomments">
							<li>
								<i class="fas fa-angle-double-right fa-3x"></i>
							</li>
							<li>
								<i class="far fa-user fa-3x"></i>
								<p><%=bcc.getCommentWriter() %></p>
								<p><%=bcc.getDate() %></p>
							</li>
							<li>
								<p><%=bcc.getCommentContentBr()%></p>
								<textarea name="bcContent" class="form-control" style="display:none;"><%=bcc.getCommentContent() %></textarea>
								<p class="commentsBtn">
									<%if(m!=null && m.getMemberId().equals(bcc.getCommentWriter())) {%>
									<a href="javascript:void(0)" onclick="modifyComment(this,'<%=bcc.getCommentNo()%>','<%=b.getBoardNo()%>');">수정</a>
									<a href="javascript:void(0)" onclick="deleteComment(this,'<%=bcc.getCommentNo()%>','<%=b.getBoardNo()%>');">삭제</a>
									<%} %>
								</p>
							</li>
						</ul>
					<%} %>
				<%}//대댓글 반복문 끝나는 지점 %>
			<%} %>
			<%} //전체댓글 반복문 끝나는 지점%>
		</div>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp" %>
	<script>
		$(".recShow").click(function(){
			var idx = $(".recShow").index(this);	//클릭한게 몇번째 답글달기 버튼인지 구하는 코드
			$(this).hide();
			$(".recoment").eq(idx).css("display","flex");
		});
		$(".recCancel").click(function(){
			var idx = $(".recCancel").index(this);
			$(".recoment").eq(idx).css("display","none");
			$(".recShow").eq(idx).show();
		});
		function modifyComment(obj,bcNo,boardNo){
			//textarea를 보여줌
			$(obj).parent().prev().show();
			//기존본문내용을 숨김
			$(obj).parent().prev().prev().hide();
			//수정 -> 수정완료
			$(obj).html('수정완료');
			$(obj).attr("onclick","modifyComplete(this,'"+bcNo+"','"+boardNo+"')");
			//삭제 -> 수정취소
			$(obj).next().html("수정취소");
			$(obj).next().attr("onclick","modifyCancel(this,'"+bcNo+"','"+boardNo+"')");
			//답글달기 버튼 삭제
			$(obj).next().next().hide();
		}
		function modifyCancel(obj,bcNo,boardNo){
			//textarea 숨김
			$(obj).parent().prev().hide();
			//기존본문내용 다시 보여줌
			$(obj).parent().prev().prev().show();
			//수정완료 -> 수정 
			$(obj).prev().html("수정");
			$(obj).prev().attr("onclick","modifyComment(this,'"+bcNo+"','"+boardNo+"')");
			//수정 취소 -> 삭제
			$(obj).html("삭제");
			$(obj).attr("onclick","deleteComment(this,'"+bcNo+"','"+boardNo+"')");
			//답글달기버튼 보이게
			$(obj).next().show();
		}
		function modifyComplete(obj,bcNo,boardNo){
			var form = $("<form action='/boardCommentUpdate' method='post'></form>");
			form.append($("<input type='text' name='bcNo' value='"+bcNo+"'>"));
			form.append($("<input type='text' name='boardNo' value='"+boardNo+"'>"));
			form.append($(obj).parent().prev());
			$("body").append(form);
			form.submit();
		}
		function deleteComment(obj,bcNo,boardNo){
			if(confirm("댓글을 삭제하시겠습니까?")){
				location.href="/boardCommentDelete?bcNo="+bcNo+"&boardNo="+boardNo;
			}
		}
	</script>
	
</body>
</html>









