$(function () {
	$.ajax({
		url : "ClassInfo/" + $("#classInfo_classNo_edit").val() + "/update",
		type : "get",
		data : {
			//classNo : $("#classInfo_classNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (classInfo, response, status) {
			$.messager.progress("close");
			if (classInfo) { 
				$("#classInfo_classNo_edit").val(classInfo.classNo);
				$("#classInfo_classNo_edit").validatebox({
					required : true,
					missingMessage : "请输入班级编号",
					editable: false
				});
				$("#classInfo_className_edit").val(classInfo.className);
				$("#classInfo_className_edit").validatebox({
					required : true,
					missingMessage : "请输入班级名称",
				});
				$("#classInfo_college_edit").val(classInfo.college);
				$("#classInfo_college_edit").validatebox({
					required : true,
					missingMessage : "请输入所属学院",
				});
				$("#classInfo_specialName_edit").val(classInfo.specialName);
				$("#classInfo_specialName_edit").validatebox({
					required : true,
					missingMessage : "请输入所属专业",
				});
				$("#classInfo_bornDate_edit").datebox({
					value: classInfo.bornDate,
					required: true,
					showSeconds: true,
				});
				$("#classInfo_mainTeacher_edit").val(classInfo.mainTeacher);
				$("#classInfo_mainTeacher_edit").validatebox({
					required : true,
					missingMessage : "请输入班主任",
				});
				$("#classInfo_classMemo_edit").val(classInfo.classMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#classInfoModifyButton").click(function(){ 
		if ($("#classInfoEditForm").form("validate")) {
			$("#classInfoEditForm").form({
			    url:"ClassInfo/" +  $("#classInfo_classNo_edit").val() + "/update",
			    onSubmit: function(){
					if($("#classInfoEditForm").form("validate"))  {
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
			$("#classInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
