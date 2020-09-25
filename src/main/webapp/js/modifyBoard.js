function addDelCheckList(self, c_seq) {
	var delChkList = $('input[name="delCheckList"]');
	
	if($(delChkList).val() == "") {
		$(delChkList).val(c_seq);
	} else {
		$(delChkList).val($(delChkList).val() + "," + c_seq);
	}
	
	$(self).parent().remove();
}

function addCheckList() {
	var newCheckList = $('input[name="newCheckList"]').val();
	var newCheckBox = $("input[name='newCheckBox']").val();
	var chks = $(".chks");
	
	if(newCheckBox.trim() == '') {
		alert("공백문자는 체크값으로 입력될 수 없습니다.");
		return false;
		
	} else if (newCheckBox.includes(',')){
		alert("체크박스명에 ,는 포함될 수 없습니다.");
		return false;
	
	} else {
		
		for(i=0; i<chks.length; i++) {
			if($(chks[i]).html() == newCheckBox) {
				alert("동일한 체크리스트는 중복 추가할 수 없습니다.");
				return false;
			}
		}
		
		if(chks.length > 9) {
			alert("체크항목은 최대 10개까지 등록 가능합니다.");
			return false;
		} else {
			if(newCheckList == '') {
				$("input[name='newCheckList']").val(newCheckBox.trim());
			} else {
				$("input[name='newCheckList']").val(newCheckList + "," + newCheckBox.trim());
			}
		}
			$(".newCheckList").append("<b><span class='chks'>" + newCheckBox + "</span> <a class='badge badge-pill badge-danger' onclick='deleteThisCheckList(this)'>삭제</a><br></b>");
			$("input[name='newCheckBox']").val('');
	}
}

function deleteThisCheckList(a_Check) {
	var newCheckList = $('input[name="newCheckList"]').val() + '';
	var splitCheck = newCheckList.split(',');
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
	
	$("input[name='newCheckList']").val(newVal);
	
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
	var chks = $('.chks');
	
	console.log(chks.length);
   
   if($(b_title).val().trim() == "") {
	   alert("체크리스트 제목을 입력해주세요.");
	   b_title.focus();
	   return false;
   }
   
   if(chks.length < 1) {
	   alert("체크리스트가 최소한 하나 이상 존재해야 합니다.");
	   $('input[name="newCheckBox"]').focus();
	   return false;
   }
   
   if($(b_comment).val().trim() == "") {
	   alert("코멘트를 입력해주세요.");
	   b_comment.focus();
	   return false;
   }
   
}