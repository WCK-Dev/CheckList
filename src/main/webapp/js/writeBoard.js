function addCheckList() {
	var existingCheck = $('input[name="c_nameList"]').val() + '';
	var splitCheck = existingCheck.split(',');
	var newCheckBox = $("input[name='newCheckBox']").val();
	
	console.log(existingCheck);
	
	if(newCheckBox.trim() == '') {
		alert("공백문자는 체크값으로 입력될 수 없습니다.");
		return false;
		
	} else if (newCheckBox.includes(',')){
		alert("체크박스명에 ,는 포함될 수 없습니다.");
		return false;
		
	} else {
		
		for(i=0; i<splitCheck.length; i++) {
			if(splitCheck[i] == newCheckBox.trim()) {
				alert("동일한 체크리스트는 중복 추가할 수 없습니다.");
				return false;
			}
		}
		
		if(splitCheck.length > 9) {
			alert("체크항목은 최대 10개까지 등록 가능합니다.");
			return false;
		} else {
			if(existingCheck == '') {
				$("input[name='c_nameList']").val(newCheckBox.trim());
			} else {
				$("input[name='c_nameList']").val(existingCheck + "," + newCheckBox.trim());
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