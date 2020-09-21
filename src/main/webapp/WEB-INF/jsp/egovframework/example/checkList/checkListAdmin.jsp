<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>	
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지</title>
<%@include file="../cmmn/common_top.jsp"%>

</head>
<body>

	<div class="container wrapper">
	
		<!-- Board Modal -->
		<div class="modal" id="selectModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">게시글 상세</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						
					</div>	
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="deleteBoard">수정</button>
						<button type="button" class="btn btn-danger" id="deleteBoard">조회정보</button>
					</div>
				</div>
			</div>
		</div>
	
		<div class="text-right">
			${user.u_name }(${user.u_id })님 어서오세요! 
			<button class="btn btn-danger" type="button" onclick="location.href='logout.do'">로그아웃</button>
		</div>
		
		<h2 style="margin-top: 60px; display: inline-block;">체크리스트 관리페이지</h2>
		
		<hr>
		
		<h3>상단노출 체크리스트</h3>
		<!-- table -->
		<table class="table">
			<thead class="black white-text">
				<tr>
					<th class="text-center" scope="col" width="10%">글번호</th>
					<th scope="col">제목</th>
					<th class="text-center" scope="col" width="15%">작성자</th>
					<th class="text-center" scope="col" width="10%">작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardTopListAll }" var="boardTop">
				<tr>
					<th class="text-center" scope="row">${boardTop.b_seq }</th>
					<td><a onclick="openBoardModal('${board.b_seq}')" data-toggle="modal" data-target="#selectModal">${boardTop.b_title }</a></td>
					<td class="text-center">${boardTop.b_writer }</td>
					<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${boardTop.b_regdate }"/></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

		<hr>
		
		<h3>전체 체크리스트</h3>
		<!-- table -->
		<table class="table">
			<thead class="black white-text">
				<tr>
					<th class="text-center" scope="col" width="10%">글번호</th>
					<th scope="col">제목</th>
					<th class="text-center" scope="col" width="15%">작성자</th>
					<th class="text-center" scope="col" width="10%">작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardListAll }" var="board">
				<tr>
					<th class="text-center" scope="row">${board.b_seq }</th>
					<td><a onclick="openBoardModal('${board.b_seq}')" data-toggle="modal" data-target="#selectModal">${board.b_title }</a></td>
					<td class="text-center">${board.b_writer }</td>
					<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.b_regdate }"/></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!-- Paging -->
		
		<div class="text-right">
			<button type="button" class="btn btn-dark" onclick="location.href='writeBoard.do'">새 체크리스트 작성</button>
		</div>
	</div>
</body>
</html>