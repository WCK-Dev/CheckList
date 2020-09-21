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
<title>새 체크리스트 작성</title>
<%@include file="../cmmn/common_top.jsp"%>

<style>
	.showList { height: 150px; overflow: auto;}
</style>

<script>
	function addCheckList() {
		var existingCheck = $('input[name="c_nameList"]').val() + '';
		var splitCheck = existingCheck.split(',');
		var newCheckBox = $("input[name='newCheckBox']").val();
		
		console.log(existingCheck);
		
		if(newCheckBox.trim() == '') {
			alert("공백문자는 체크값으로 입력될 수 없습니다.");
			return false;
			
		} else {
			
			for(i=0; i<splitCheck.length; i++) {
				if(splitCheck[i] == newCheckBox) {
					alert("동일한 체크리스트는 중복 추가할 수 없습니다.");
					return false;
				}
			}
			
			if(splitCheck.length > 9) {
				alert("체크항목은 최대 10개까지 등록 가능합니다.");
				return false;
			} else {
				if(existingCheck == '') {
					$("input[name='c_nameList']").val(newCheckBox);
				} else {
					$("input[name='c_nameList']").val(existingCheck + "," + newCheckBox);
				}
			}
				$(".checkList").append("<b><span>" + newCheckBox + "</span> <a class='badge badge-pill badge-danger' onclick='deleteThisCheckList(this)'>삭제</a><br></b>");
				$("input[name='newCheckBox']").val('');
		}
	}
	
	function deleteThisCheckList(a_Check) {
		var existingCheck = $('input[name="c_nameList"]').val() + '';
		var splitCheck = existingCheck.split(',');
		var delCheck = $(a_Check).prev().text();
		var newVal = "";
		
		
		
		for(i=0; i<splitCheck.length; i++) {
			if(splitCheck[i] != delCheck) {
				if(newVal == '') {
					newVal = splitCheck[i];
				} else {
					newVal = newVal + "," + splitCheck[i];
				}
			}
		}
		
		$("input[name='c_nameList']").val(newVal);
		
		$(a_Check).parent().remove();
	}
	
	function enterCheckList() {
		if(event.keyCode == 13) {
			event.preventDefault();
			addCheckList();
		}
	}
	
	function validationCheck() {
		var b_title = $('input[name="b_title"]');
		var b_comment = $('textarea[name="b_comment"]');
		var existingCheck = $('input[name="c_nameList"]').val() + '';
	   
	   if($(b_title).val().trim() == "") {
		   alert("체크리스트 제목을 입력해주세요.");
		   b_title.focus();
		   return false;
	   }
	   
	   if(existingCheck == '') {
		   alert("최소한 하나 이상 체크리스트 항목을 입력해주세요.");
		   $('input[name="newCheckBox"]').focus();
		   return false;
	   }
	   
	   if($(b_comment).val().trim() == "") {
		   alert("코멘트를 입력해주세요.");
		   b_comment.focus();
		   return false;
	   }
	   
	}
</script>

</head>
<body>

	<div class="container wrapper">
	<form class="text-center border border-light p-5" action="writeBoard.do" method="post" onsubmit="return validationCheck()">
	
	    <p class="h4 mb-4">체크리스트 추가</p>
	    <input type="hidden" name="c_nameList" value="">
	
	    <!-- Name -->
	    <input type="text" name="b_writer" class="form-control mb-4" placeholder="Writer" value="${user.u_id }" readonly>
	
		<!-- Title -->
	    <input type="text" name="b_title" class="form-control mb-4" placeholder="Title">
	    
	    <!-- TOP YN -->
      	<select name="b_topYN" class="browser-default custom-select mb-4" required>
	        <option selected hidden="true" value="">카테고리 상단 고정 여부</option>
	        <option value="Y">고정함</option>
	        <option value="N">고정하지않음</option>
	    </select>
		
		<hr>
		
		<h5>체크리스트 항목</h5>
		<div class="form-group text-center checkList">
		</div>
		
		<!-- CheckList Add -->
		<div class="row mx-0">
			<input type="text" name="newCheckBox" class="col-9 form-control mt-1" onkeypress="enterCheckList()" placeholder="추가할 체크리스트 항목">
			<button type="button" class="btn btn-primary" onclick="addCheckList()">추가하기</button>
		</div>
		
	    <!-- Content -->
	    <div class="form-group text-left">
	        <textarea id="b_comment" name="b_comment" class="form-control rounded-0 mt-3" style="min-height: 200px" placeholder="Comment"></textarea>
	    </div>
	    
	    <hr>
	    
	    <!-- Show List -->
	   	<h5>조회허용 유저 선택</h5>
		<div class="form-group text-left showList">
			<c:forEach items="${userList }" var="user" varStatus="i">
				<input type="checkbox" id="user${i.index }" name="showU_id" value="${user.u_id }"><label class="ml-3" for="user${i.index }">${user.u_id }</label><br>
			</c:forEach>
		</div>
		
	    <hr>
	    
		<div class="container text-right">
			<button type="submit" style="width: 100px; height:40px; padding:5px;" class="btn btn-dark mb-3">새로 작성</button>
			<button type="button" style="width: 100px; height:40px; padding:5px;" class="btn btn-dark mb-3" onclick="location.href='checkListAdmin.do'">취소</button>
		</div>
	</form>
</div>
</body>
</html>