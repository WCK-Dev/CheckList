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