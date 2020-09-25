$(document).ready(function(){
	var isReadCol = $(".isRead");
	var readDateCol = $(".readDate");
	var regDateCol = $(".regDate");
	var modifyDateCol = $(".modifyDate");
	var readAnswerCol = $(".readAnswer");
	
	$.each(isReadCol, function(index, item) {
		console.log($(item).text());
		
		if($(item).text().trim() == "") {
			$(item).html('<span style="color: red">조회하지 않음</span>')
		}
	});
	
	$.each(readDateCol, function(index, item) {
		console.log($(item).text());
		
		if($(item).text().trim() == "") {
			$(item).html('<span style="color: gray">조회기록 없음</span>')
		}
	});
	
	$.each(regDateCol, function(index, item) {
		console.log($(item).text());
		
		if($(item).text().trim() == "") {
			$(item).html('<span style="color: gray">답변하지 않음</span>')
		}
	});
	
	$.each(modifyDateCol, function(index, item) {
		console.log($(item).text());
		
		if($(item).text().trim() == "") {
			$(item).html('<span style="color: gray">수정기록 없음</span>')
		}
	});
	
	$.each(readAnswerCol, function(index, item) {
		console.log($(item).text());
		
		if($(item).text().trim() == "") {
			
			$(item).html("<button type='button' class='btn btn-danger disabled'>답변 없음</button>")
		}
	});
	
});

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
