$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('teacher_teacherDesc_edit');
	var teacher_teacherDesc_edit = UE.getEditor('teacher_teacherDesc_edit'); //教师介绍编辑器
	teacher_teacherDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Teacher/" + $("#teacher_teacherNo_edit").val() + "/update",
		type : "get",
		data : {
			//teacherNo : $("#teacher_teacherNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (teacher, response, status) {
			$.messager.progress("close");
			if (teacher) { 
				$("#teacher_teacherNo_edit").val(teacher.teacherNo);
				$("#teacher_teacherNo_edit").validatebox({
					required : true,
					missingMessage : "请输入教师编号",
					editable: false
				});
				$("#teacher_password_edit").val(teacher.password);
				$("#teacher_password_edit").validatebox({
					required : true,
					missingMessage : "请输入登录密码",
				});
				$("#teacher_teacherName_edit").val(teacher.teacherName);
				$("#teacher_teacherName_edit").validatebox({
					required : true,
					missingMessage : "请输入教师姓名",
				});
				$("#teacher_teacherSex_edit").val(teacher.teacherSex);
				$("#teacher_teacherSex_edit").validatebox({
					required : true,
					missingMessage : "请输入教师性别",
				});
				$("#teacher_birthDate_edit").datebox({
					value: teacher.birthDate,
					required: true,
					showSeconds: true,
				});
				$("#teacher_teacherPhoto").val(teacher.teacherPhoto);
				$("#teacher_teacherPhotoImg").attr("src", teacher.teacherPhoto);
				$("#teacher_zhicheng_edit").val(teacher.zhicheng);
				$("#teacher_zhicheng_edit").validatebox({
					required : true,
					missingMessage : "请输入教师职称",
				});
				$("#teacher_telephone_edit").val(teacher.telephone);
				$("#teacher_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				teacher_teacherDesc_edit.setContent(teacher.teacherDesc);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#teacherModifyButton").click(function(){ 
		if ($("#teacherEditForm").form("validate")) {
			$("#teacherEditForm").form({
			    url:"Teacher/" +  $("#teacher_teacherNo_edit").val() + "/update",
			    onSubmit: function(){
					if($("#teacherEditForm").form("validate"))  {
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
			$("#teacherEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
