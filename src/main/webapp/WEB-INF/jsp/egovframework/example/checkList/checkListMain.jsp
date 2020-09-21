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
<title>갤러리 메인</title>
<%@include file="../cmmn/common_top.jsp"%>

<style>
* { font-family: 'Noto Sans KR', sans-serif; }
* { box-shadow: 0 0!important;}
.wrapper { min-height: 70vh;}
.contents { float: left; width: 100%; box-sizing: border-box; text-align: center; margin-bottom: 50px; min-height: 500px;} 
.content_box { display: inline-block; display: inline-block; width: 250px; height: 25%; position: relative; overflow: hidden; margin: 10px; min-width: 180px; color: black; text-align: center; font-size: 16px; border: 2px solid lightgray; border-radius: 10px; }
.content_box img { display:block; width: 250px; height:150px; align: center}
.tag_Rank { position: absolute; left: 85%; top: 30%; text-align: center;}
.tag_Rank tr { height: 40px; border: 1px solid lightgray;}
.tag_Rank td { width: 150px;}
.text-right { clear: both;}
</style>

<script>
</script>

</head>
<body>
체크리스트 메인페이지
</body>
</html>