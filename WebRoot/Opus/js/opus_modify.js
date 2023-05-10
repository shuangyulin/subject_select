$(function () {
	$.ajax({
		url : "Opus/" + $("#opus_opusId_edit").val() + "/update",
		type : "get",
		data : {
			//opusId : $("#opus_opusId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (opus, response, status) {
			$.messager.progress("close");
			if (opus) { 
				$("#opus_opusId_edit").val(opus.opusId);
				$("#opus_opusId_edit").validatebox({
					required : true,
					missingMessage : "请输入成果id",
					editable: false
				});
				$("#opus_subjectObj_subjectId_edit").combobox({
					url:"Subject/listAll",
					valueField:"subjectId",
					textField:"subjectName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#opus_subjectObj_subjectId_edit").combobox("select", opus.subjectObjPri);
						//var data = $("#opus_subjectObj_subjectId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#opus_subjectObj_subjectId_edit").combobox("select", data[0].subjectId);
						//}
					}
				});
				$("#opus_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#opus_userObj_user_name_edit").combobox("select", opus.userObjPri);
						//var data = $("#opus_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#opus_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#opus_ktbg").val(opus.ktbg);
				if(opus.ktbg == "") $("#opus_ktbgA").html("暂无文件");
				$("#opus_ktbgA").attr("href", opus.ktbg);
				$("#opus_wwwx").val(opus.wwwx);
				if(opus.wwwx == "") $("#opus_wwwxA").html("暂无文件");
				$("#opus_wwwxA").attr("href", opus.wwwx);
				$("#opus_lwcg").val(opus.lwcg);
				if(opus.lwcg == "") $("#opus_lwcgA").html("暂无文件");
				$("#opus_lwcgA").attr("href", opus.lwcg);
				$("#opus_lwzg").val(opus.lwzg);
				if(opus.lwzg == "") $("#opus_lwzgA").html("暂无文件");
				$("#opus_lwzgA").attr("href", opus.lwzg);
				$("#opus_otherFile").val(opus.otherFile);
				if(opus.otherFile == "") $("#opus_otherFileA").html("暂无文件");
				$("#opus_otherFileA").attr("href", opus.otherFile);
				$("#opus_chengji_edit").val(opus.chengji);
				$("#opus_evaluate_edit").val(opus.evaluate);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#opusModifyButton").click(function(){ 
		if ($("#opusEditForm").form("validate")) {
			$("#opusEditForm").form({
			    url:"Opus/" +  $("#opus_opusId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#opusEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#opusEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
