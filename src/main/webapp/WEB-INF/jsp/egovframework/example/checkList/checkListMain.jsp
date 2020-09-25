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
<title>게시판 메인</title>
<%@include file="../cmmn/common_top.jsp"%>

<script type="text/javascript"src="${pageContext.request.contextPath }/js/checkListMain.js"></script>
</head>
<body>

	<div class="container wrapper">
	
		<!-- Board Modal -->
		<div class="modal" id="selectModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">체크리스트 상세</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-control text-left" id="b_title"></div>
		    
					    <!-- writer -->
					    <div class="text-left mt-3"><i class="fas fa-user prefix mr-2"></i><b id="b_writer"></b></div>
					    
						<!-- RedDate -->
					    <div class="text-left mt-3"><i class="fas fa-clock mr-2"></i><b id="b_regdate"></b></div>
					    
					    <!-- checkList 항목 -->
					    <div class="text-left mt-3"><i class="fas fa-list"></i> 체크리스트 항목
					    	<div id="c_List">
					    	
					    	</div>
						</div>
						
						<hr>
					    
					    <!-- Comment -->
					    <div class="text-left">
							<pre id="b_comment" style="white-space: pre-wrap;"></pre>
					    </div>
						
					</div>	
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="checkSave()">저장</button>
						<button type="button" class="btn btn-danger" id="cancelBtn" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	
		<div class="text-right">
			${user.u_name }(${user.u_id })님 어서오세요! 
			<button class="btn btn-danger" type="button" onclick="location.href='logout.do'">로그아웃</button>
		</div>
		
		<h2 style="margin-top: 60px; display: inline-block;">${user.u_id }님의 체크리스트</h2>
		
		<hr>
		
		<h4 class="mt-4">상단고정 체크리스트</h4>
		<!-- table -->
		<table class="table">
			<thead class="blue white-text">
				<tr>
					<th class="text-center" scope="col" width="10%">글번호</th>
					<th scope="col">제목</th>
					<th class="text-center" scope="col" width="15%">작성자</th>
					<th class="text-center" scope="col" width="10%">작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardTopList }" var="boardTop">
				<tr>
					<th class="text-center" scope="row">${boardTop.b_seq }</th>
					<td><a onclick="openBoardModal('${boardTop.b_seq }')" data-toggle="modal" data-target="#selectModal">${boardTop.b_title }</a></td>
					<td class="text-center">${boardTop.b_writer }</td>
					<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${boardTop.b_regdate }"/></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

		<hr>
		
		<h4 class="mt-5">일반 체크리스트</h4>
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
				<c:forEach items="${boardList }" var="board">
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
		<ul class="pagination" style="width: 100%; text-align:center;">
   			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_link_page" />
       	</ul>
	</div>
	
</body>
</html>