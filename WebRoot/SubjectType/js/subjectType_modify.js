$(function () {
	$.ajax({
		url : "SubjectType/" + $("#subjectType_typeId_edit").val() + "/update",
		type : "get",
		data : {
			//typeId : $("#subjectType_typeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (subjectType, response, status) {
			$.messager.progress("close");
			if (subjectType) { 
				$("#subjectType_typeId_edit").val(subjectType.typeId);
				$("#subjectType_typeId_edit").validatebox({
					required : true,
					missingMessage : "请输入类型编号",
					editable: false
				});
				$("#subjectType_typeName_edit").val(subjectType.typeName);
				$("#subjectType_typeName_edit").validatebox({
					required : true,
					missingMessage : "请输入类型名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#subjectTypeModifyButton").click(function(){ 
		if ($("#subjectTypeEditForm").form("validate")) {
			$("#subjectTypeEditForm").form({
			    url:"SubjectType/" +  $("#subjectType_typeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#subjectTypeEditForm").form("validate"))  {
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
			$("#subjectTypeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
