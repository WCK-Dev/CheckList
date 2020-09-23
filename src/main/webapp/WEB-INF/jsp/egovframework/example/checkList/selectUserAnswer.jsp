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
<title>유저 조회이력 확인</title>
<%@include file="../cmmn/common_top.jsp"%>

<script>
	function readUserAnswer(u_id) {
		var b_seq = $('input[name="b_seq"]').val();
		
		$.ajax({
			type : 'POST',
			url : "readUserAnswer.do",
			async : false,
			dataType : "json",
			data : {"b_seq": b_seq
				   ,"u_id" : u_id},
				   
		   success : function (result) {
			   	/* 체크리스트 항목, 기존 체크항목 */
				var c_List = result.cvoList;
				var a_List = result.avoList;
				
				for(i=0; i<c_List.length; i++) {
					if(i == 0) $("#c_List").html("<input type='checkbox' value='Y' id='chk" + i + "' class='ml-3 mt-3'/><input type='hidden' value='" + c_List[i].c_seq + "'><label for='chk" + i + "' class='pl-2'>" + c_List[i].c_name + "</label><br>");
					
					else $("#c_List").append("<input type='checkbox' value='Y' id='chk" + i + "' class='ml-3'/><input type='hidden' value='" + c_List[i].c_seq + "'><label for='chk" + i + "' class='pl-2'>" + c_List[i].c_name + "</label><br>");
				}
				
				for(i=0; i<a_List.length; i++) {
					if(a_List[i].a_checked == "Y") {
						$('input[type="hidden"][value=' + a_List[i].c_seq +']').prev().prop('checked', true);
					}
				}
			}
		})
	}
</script>

</head>
<body>

	<div class="container wrapper">
	
		<!-- Read Modal -->
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
						<div class="form-control text-left" id="b_title">${boardInfo.b_title }</div>
		    
					    <!-- writer -->
					    <div class="text-left mt-3">
					    	<i class="fas fa-user prefix mr-2"></i>
					    	<b id="b_writer">
					    		${boardInfo.b_writer }
						    	<c:if test="${boardInfo.b_modifier != null }">
						    		<span style='color:gray; margin-left: 10px;'>(${boardInfo.b_modifier }가 수정함)</span>
						    	</c:if>
					    	</b>
					    </div>
					    
						<!-- RedDate -->
					    <div class="text-left mt-3">
					    	<i class="fas fa-clock mr-2"></i>
					    	<b id="b_regdate">
					    		<fmt:formatDate value="${boardInfo.b_regdate }" pattern="yyyy-MM-dd"/>
					    		<c:if test="${boardInfo.b_modifydate != null }">
						    		<span style='color:gray; margin-left: 10px;'>(<fmt:formatDate value="${boardInfo.b_modifydate }" pattern="yyyy-MM-dd"/>에 수정됨)</span>
						    	</c:if>
					    	</b>
					    </div>
					    
					    <!-- checkList 항목 -->
					    <div class="text-left mt-3"><i class="fas fa-list"></i> 체크리스트 항목
					    	<div id="c_List">
					    	
					    	</div>
						</div>
						
						<hr>
					    
					    <!-- Comment -->
					    <div class="text-left">
							<p id="b_comment">
								${boardInfo.b_comment }
							</p>
					    </div>
						
					</div>	
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" id="cancelBtn" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	
		<div class="text-right">
			${user.u_name }(${user.u_id })님 어서오세요! 
			<button class="btn btn-danger" type="button" onclick="location.href='logout.do'">로그아웃</button>
		</div>
		
		<h2 style="margin-top: 60px; display: inline-block;" class="text-center">유저 체크리스트 조회</h2>
		
		<hr>
		
		<h3>${boardInfo.b_seq}. [${boardInfo.b_title }]</h3>
		<input type="hidden" name="b_seq" value="${boardInfo.b_seq }">
		
		<!-- table -->
		<table class="table">
			<thead class="black white-text">
				<tr>
					<th class="text-center" scope="col" width="25%">회원아이디</th>
					<th class="text-center" scope="col">최초답변일</th>
					<th class="text-center" scope="col" width="25%">최종 수정일</th>
					<th class="text-center" scope="col" width="25%">체크확인</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${userAnswerList }" var="userAnswer">					
					<tr>
						<th class="text-center align-middle" scope="row">${userAnswer.u_id }</th>
						<td class="text-center align-middle"><fmt:formatDate value="${userAnswer.a_regdate}" pattern="yyyy-MM-dd"/></td>
						<td class="text-center align-middle"><fmt:formatDate value="${userAnswer.a_modifydate}" pattern="yyyy-MM-dd"/></td>
						<td class="text-center"><button type="button" onclick="readUserAnswer('${userAnswer.u_id}')" class="btn btn-primary" data-toggle="modal" data-target="#selectModal">답변 확인</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!-- Paging -->
		
		<div class="text-right">
			<button type="button" class="btn btn-dark" onclick="history.back();">이전 페이지</button>
		</div>
	</div>
</body>
</html>