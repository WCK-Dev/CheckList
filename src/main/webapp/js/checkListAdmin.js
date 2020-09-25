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