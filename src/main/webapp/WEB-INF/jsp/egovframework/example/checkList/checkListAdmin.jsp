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

<script>
	$(document).ready(function() {
		if('${bSeqErrorMsg}' == 'true'){
			alert("글번호가 존재하지 않습니다.");
		}
	});

	function openBoardModal(b_seq) {
		
		$.ajax({
			
			type : 'POST',
			url : "readBoard.do",
			async : false,
			dataType : "json",
			data : {"b_seq": b_seq},
			
			success : function (result) {
				
				/* Modal Box 안에 들어갈 값들을 세팅 */
				var b_seq = result.bvo.b_seq;
				var b_title = result.bvo.b_title;
				var b_writer = result.bvo.b_writer;
				var b_regdate = getFormatDate(new Date(result.bvo.b_regdate));
				var b_comment = result.bvo.b_comment;
				var b_modifier = result.bvo.b_modifier;
				var b_modifydate = result.bvo.b_modifydate;

				if(b_modifydate != null) {
					b_modifydate = getFormatDate(new Date(result.bvo.b_modifydate));
				}
				
				/* 체크리스트 항목, 조회허용 유저 목록 */
				var c_List = result.cvoList;
				var s_List = result.svoList;
				
				// Model Box 안에 값을 출력
				$('input[name="b_seq"]').val(b_seq);
				$('#b_title').text(b_title);
				$('#b_writer').text(b_writer);
				
				if(b_modifier != null) $("#b_writer").append("<span style='color:gray; margin-left: 10px;'>(" + b_modifier + "가 수정함)</span>")  
					
				$('#b_regdate').text(b_regdate);
				if(b_modifydate != null) $("#b_regdate").append("<span style='color:gray; margin-left: 10px;'>(" + b_modifydate + "에 수정됨)</span>")  
				
				//체크리스트 항목 추가
				for(i=0; i<c_List.length; i++) {
					if(i == 0) $("#c_name").html("<li>" + c_List[i].c_name + "</li>");
					
					else $("#c_name").append("<li>" + c_List[i].c_name + "</li>");
				}
				
				$('#b_comment').text(b_comment);
				
				//조회허용 유저 목록 추가
				for(i=0; i<s_List.length; i++) {
					if(i == 0) $("#b_showList").text(s_List[i].u_id);
					
					else $("#b_showList").append(" , " + s_List[i].u_id);
				}
			}
		});
		
	}
	
	function getFormatDate(date){
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
	}
	
	function selectUserLog() {
		var b_seq = $("input[name='b_seq']").val();
		
		location.href="selectUserLog.do?b_seq=" + b_seq;
	}
	
	function selectUserAnswer() {
		var b_seq = $("input[name='b_seq']").val();
		
		location.href="selectUserAnswer.do?b_seq=" + b_seq;
	}
	
	function modifyBoard() {
		var b_seq = $('input[name="b_seq"]').val();
		
		location.href="modifyBoard.do?b_seq=" + b_seq;
	}
	
	function deleteBoard() {
		var b_seq = $('input[name="b_seq"]').val();
		
		if(confirm("체크리스트를 삭제하면 해당 글의 유저 답변도 모두 삭제됩니다.\r\n정말 게시글을 삭제하시겠습니까?")) {
			$.ajax({
				
				type : 'POST',
				url : "deleteBoard.do",
				dataType : "text",
				data : {"b_seq": b_seq},
				success : function (result) {
					alert("해당 체크리스트 게시글이 삭제되었습니다.");
					location.reload(true);
				}
				
			});
		};
	}
	
	function fn_link_page(pageNo){
		location.href="checkListAdmin.do?pageIndex=" + pageNo;
	}
</script>

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
						<input type="hidden" name="b_seq" value="">
						<div class="form-control text-left" id="b_title"></div>
		    
					    <!-- writer -->
					    <div class="text-left mt-3"><i class="fas fa-user prefix mr-2"></i><b id="b_writer"></b></div>
					    
						<!-- RedDate -->
					    <div class="text-left mt-3"><i class="fas fa-clock mr-2"></i><b id="b_regdate"></b></div>
					    
					    <!-- checkList 항목 -->
					    <div class="text-left mt-3"><i class="fas fa-list"></i> 체크리스트 항목
								<ul id="c_name"></ul>
						</div>
						
						<hr>
					    
					    <!-- Comment -->
					    <div class="text-left">
							<pre id="b_comment" style="white-space: pre-wrap;"></pre>
					    </div>
					    
					    <hr>
					    
					    <div class="text-left"><i class="fas fa-address-book"></i> 조회가능 유저 목록
							<p id="b_showList">
								
							</p>
					    </div>
						
					</div>	
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="selectUserLog();">유저조회이력</button>
						<button type="button" class="btn btn-warning" onclick="modifyBoard();">수정</button>
						<button type="button" class="btn btn-danger" onclick="deleteBoard();">삭제</button>
					</div>
				</div>
			</div>
		</div>
	
		<div class="text-right">
			${user.u_name }(${user.u_id })님 어서오세요! 
			<button class="btn btn-danger" type="button" onclick="location.href='logout.do'">로그아웃</button>
		</div>
		
		<h2 style="margin-top: 60px; display: inline-block;" class="text-center">체크리스트 관리페이지</h2>
		
		<hr>
		
		<h3>상단고정 체크리스트</h3>
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
				<c:forEach items="${boardTopListAll }" var="boardTop">
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
		
		<h3>일반 체크리스트</h3>
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
		<ul class="pagination" style="width: 100%; text-align:center;">
   			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_link_page" />
       	</ul>
       	<form >
		
		<div class="text-right">
			<button type="button" class="btn btn-dark" onclick="location.href='writeBoard.do'">새 체크리스트 작성</button>
		</div>
	</div>
</body>
</html>