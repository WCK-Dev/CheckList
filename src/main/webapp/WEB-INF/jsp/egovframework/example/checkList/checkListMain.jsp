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

<script>
	function openBoardModal(b_seq) {
		
		$.ajax({
			type : 'POST',
			url : "readCheckList.do",
			async : false,
			dataType : "json",
			data : {"b_seq": b_seq},
			
			success : function (result) {
				
				/* Modal Box 안에 들어갈 값들을 세팅 */
				var b_title = result.bvo.b_title;
				var b_writer = result.bvo.b_writer;
				var b_regdate = getFormatDate(new Date(result.bvo.b_regdate));
				var b_comment = result.bvo.b_comment;
				var b_modifier = result.bvo.b_modifier;
				var b_modifydate = result.bvo.b_modifydate;
	
				if(b_modifydate != null) {
					b_modifydate = getFormatDate(new Date(result.bvo.b_modifydate));
				}
				
				/* 체크리스트 항목, 기존 체크항목 */
				var c_List = result.cvoList;
				var a_List = result.avoList;
				
				// Model Box 안에 값을 출력
				$('#b_title').text(b_title);
				$('#b_writer').text(b_writer);
				
				if(b_modifier != null) $("#b_writer").append("<span style='color:gray; margin-left: 10px;'>(" + b_modifier + "가 수정함)</span>")  
					
				$('#b_regdate').text(b_regdate);
				if(b_modifydate != null) $("#b_regdate").append("<span style='color:gray; margin-left: 10px;'>(" + b_modifydate + "에 수정됨)</span>")  
				
				//체크리스트 항목 추가
				for(i=0; i<c_List.length; i++) {
					if(i == 0) $("#c_List").html("<input type='checkbox' value='Y' id='chk" + i + "' class='ml-3 mt-3'/><input type='hidden' value='" + c_List[i].c_seq + "'><label for='chk" + i + "' class='pl-2'>" + c_List[i].c_name + "</label><br>");
					
					else $("#c_List").append("<input type='checkbox' value='Y' id='chk" + i + "' class='ml-3'/><input type='hidden' value='" + c_List[i].c_seq + "'><label for='chk" + i + "' class='pl-2'>" + c_List[i].c_name + "</label><br>");
				}
				
				//체크리스트 체크 여부 검사
				for(i=0; i<a_List.length; i++) {
					if(a_List[i].a_checked == "Y") {
						$('input[type="hidden"][value=' + a_List[i].c_seq +']').prev().prop('checked', true);
					}
				}
				
				$('#b_comment').text(b_comment);
				
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
	
	function checkSave() {
		var chkList = $("#c_List").find('input[type="checkbox"]');
		var c_seq = "";
		var a_checked = "";
		
		var jsonArr = new Array();
		var a_json = new Object();
		
		for(i=0; i<chkList.length; i++) {
			if($(chkList[i]).prop("checked")) a_checked = "Y";
			else a_checked = "N";
			
			c_seq = $(chkList[i]).next().val();
			
			a_json = {
				"c_seq" : c_seq,
				"a_checked" : a_checked
			}
			
			jsonArr.push(a_json);
		}
		
		var send_Json = JSON.stringify(jsonArr);
		
		console.log(send_Json);
		
		 $.ajax({
		        type : 'post',
		        url : "saveAnswer.do",
		        contentType : 'application/json; charset=utf-8',
		        dataType :'text',
		        data : send_Json,
		        traditional : true,
		        
		        success : function (result) {
		        	alert("체크리스트 답변항목이 저장되었습니다.");
		        	$("#cancelBtn").click();
		        }
		 });		        
	}
	
	function fn_link_page(pageNo){
		location.href="checkListMain.do?pageIndex=" + pageNo;
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
							<p id="b_comment">
							</p>
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
		
		<h2 style="margin-top: 60px; display: inline-block;">체크리스트 사용자 페이지</h2>
		
		<hr>
		
		<h3>상단노출 체크리스트</h3>
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
		
		<h3>내 체크리스트</h3>
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