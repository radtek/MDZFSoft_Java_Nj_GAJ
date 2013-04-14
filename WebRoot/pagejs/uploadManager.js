function uploadManagerFormSubmit() {
	var beginTimeVal = document.getElementById('beginTime').value;
	var endTimeVal = document.getElementById('endTime').value;
	var takeTime_begin = document.getElementById('takeTime_begin').value;
	var takeTime_end = document.getElementById('takeTime_end').value;
	var policeTime_begin = document.getElementById('policeTime_begin').value;
	var policeTime_end = document.getElementById('policeTime_end').value;
	if(beginTimeVal=='' && endTimeVal!='') {
		alert("上传日期错误，请选择起始时间或清除结束时间！");
	} else if(beginTimeVal!='' && endTimeVal=='') {
		alert("上传日期错误，请选择结束时间或清除起始时间！");
	}
	else if(takeTime_begin=='' && takeTime_end!='') {
		alert("录制时间错误，请选择起始时间或清除结束时间！");
	} else if(takeTime_begin!='' && takeTime_end=='') {
		alert("录制时间错误，请选择结束时间或清除起始时间！");
	}
	else if(policeTime_begin=='' && policeTime_end!='') {
		alert("接警时间错误，请选择起始时间或清除结束时间！");
	} else if(policeTime_begin!='' && policeTime_end=='') {
		alert("接警时间错误，请选择结束时间或清除起始时间！");
	}
	else{
		return true;
	}
	return false;
}

/**
 * 播放弹出
 * @param assignmentId 需要赋值公告id的id对象名
 * @param assignmentName 需要赋值公告名称的id对象名
 * @param dialogTitle 弹出层的标题
 */
function playDialogShow(assignmentId, assignmentName, dialogTitle, onlyRoot)
{
jQuery(function($) {
	$('#playObj').val(assignmentId);
	$('#videoObj').attr('src', assignmentId);
	$.weeboxs.open('#playShowDiv', {title:dialogTitle, contentType:'selector', width:'600', height:'440'});
});
}

/**
 * flv播放弹出
 * @param assignmentId 需要赋值公告id的id对象名
 * @param assignmentName 需要赋值公告名称的id对象名
 * @param dialogTitle 弹出层的标题
 */
function playFlvDialogShow(assignmentId, assignmentName, dialogTitle, onlyRoot)
{
jQuery(function($) {
	//alert("vcastr22.swf?vcastr_file="+assignmentId);
	//$('#flvplayObj').val("vcastr22.swf?vcastr_file="+assignmentId);
	//$('#flvvideoObj').attr('src', "vcastr22.swf?vcastr_file="+assignmentId);
	//$.weeboxs.open('#playFlvDiv', {title:dialogTitle, contentType:'selector', width:'600', height:'440'});
	
	$.weeboxs.open('#playFlvFrame', {title:dialogTitle, contentType:'selector', width:'600', height:'440'});
	$("#flvPath").val(assignmentId);
	$("#playFlvDivForm").submit();
});
}


/**
 * 放大图片
 * @param assignmentId 需要赋值公告id的id对象名
 * @param assignmentName 需要赋值公告名称的id对象名
 * @param dialogTitle 弹出层的标题
 */
function imageDialogShow(assignmentId, assignmentName, dialogTitle, onlyRoot)
{
jQuery(function($) {
	$('#imgObj').attr('src', assignmentId);
	$('#imgObj').attr('width', 560);
	$('#imgObj').attr('height', 430);
	$.weeboxs.open('#imgShowDiv', {title:dialogTitle, contentType:'selector', width:'600', height:'440'});
});
}

/**
 * wav播放弹出
 * @param assignmentId 需要赋值公告id的id对象名
 * @param assignmentName 需要赋值公告名称的id对象名
 * @param dialogTitle 弹出层的标题
 */
function playWavDialogShow(assignmentId, assignmentName, dialogTitle, onlyRoot)
{
jQuery(function($) {
	$.weeboxs.open('#playWavFrame', {title:dialogTitle, contentType:'selector', width:'460', height:'120'});
	$("#wavPath").val(assignmentId);
	$("#playWavDivForm").submit();
});
}

function detailShow(uploadId)
{
	window.showModalDialog(contextPath()+"/userAction.do?method=fileDetailShow&uploadId="+uploadId+"&timer="+Math.random(),"","dialogwidth:600px;dialogheight:380px; toolbar=no,top=200,left=200, menubar=no, location=no, status=no");
}