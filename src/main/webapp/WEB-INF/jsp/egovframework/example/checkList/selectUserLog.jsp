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
	$(document).ready(function(){
		var isReadCol = $(".isRead");
		var readDateCol = $(".readDate");
		
	});
</script>

</head>
<body>

	<div class="container wrapper">
	
		<div class="text-right">
			${user.u_name }(${user.u_id })님 어서오세요! 
			<button class="btn btn-danger" type="button" onclick="location.href='logout.do'">로그아웃</button>
		</div>
		
		<h2 style="margin-top: 60px; display: inline-block;" class="text-center">유저 조회이력</h2>
		
		<hr>
		
		<h3>${boardInfo.b_seq}. [${boardInfo.b_title }]</h3>
		
		<!-- table -->
		<table class="table">
			<thead class="black white-text">
				<tr>
					<th class="text-center" scope="col" width="40%">회원아이디</th>
					<th class="text-center" scope="col">조회여부</th>
					<th class="text-center" scope="col" width="30%">최종 조회일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${svoList }" var="show">
				<tr>
					<th class="text-center" scope="row">${show.u_id }</th>
					<td class="text-center" class="isRead">
						<c:forEach items="${lvoList }" var="log">
							<c:if test="${show.u_id == log.u_id}">
								<span style="color: blue">조회함</span>
							</c:if>
						</c:forEach>
					</td>
					<td class="text-center" class="readDate">
						<c:forEach items="${lvoList }" var="log">
							<c:if test="${show.u_id == log.u_id}">
								<fmt:formatDate pattern="yyyy-MM-dd" value="${log.l_readdate }"/>
							</c:if>
						</c:forEach>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!-- Paging -->
		
		<div class="text-right">
			<button type="button" class="btn btn-dark" onclick="">관리자 메인</button>
		</div>
	</div>
</body>
</html>