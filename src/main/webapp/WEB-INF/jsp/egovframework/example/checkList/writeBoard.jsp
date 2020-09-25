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

<script type="text/javascript" src="${pageContext.request.contextPath }/js/writeBoard.js"></script></head>
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