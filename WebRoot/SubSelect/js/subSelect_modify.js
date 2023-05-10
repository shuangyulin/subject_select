$(function () {
	$.ajax({
		url : "SubSelect/" + $("#subSelect_selectId_edit").val() + "/update",
		type : "get",
		data : {
			//selectId : $("#subSelect_selectId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (subSelect, response, status) {
			$.messager.progress("close");
			if (subSelect) { 
				$("#subSelect_selectId_edit").val(subSelect.selectId);
				$("#subSelect_selectId_edit").validatebox({
					required : true,
					missingMessage : "请输入选题id",
					editable: false
				});
				$("#subSelect_subjectObj_subjectId_edit").combobox({
					url:"Subject/listAll",
					valueField:"subjectId",
					textField:"subjectName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#subSelect_subjectObj_subjectId_edit").combobox("select", subSelect.subjectObjPri);
						//var data = $("#subSelect_subjectObj_subjectId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#subSelect_subjectObj_subjectId_edit").combobox("select", data[0].subjectId);
						//}
					}
				});
				$("#subSelect_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#subSelect_userObj_user_name_edit").combobox("select", subSelect.userObjPri);
						//var data = $("#subSelect_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#subSelect_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#subSelect_selectTime_edit").datetimebox({
					value: subSelect.selectTime,
					required: true,
					showSeconds: true,
				});
				$("#subSelect_shenHeState_edit").val(subSelect.shenHeState);
				$("#subSelect_shenHeState_edit").validatebox({
					required : true,
					missingMessage : "请输入审核状态",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#subSelectModifyButton").click(function(){ 
		if ($("#subSelectEditForm").form("validate")) {
			$("#subSelectEditForm").form({
			    url:"SubSelect/" +  $("#subSelect_selectId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#subSelectEditForm").form("validate"))  {
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
			$("#subSelectEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
