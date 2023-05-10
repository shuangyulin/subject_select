$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('subject_sujectContent_edit');
	var subject_sujectContent_edit = UE.getEditor('subject_sujectContent_edit'); //题目内容编辑器
	subject_sujectContent_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Subject/" + $("#subject_subjectId_edit").val() + "/update",
		type : "get",
		data : {
			//subjectId : $("#subject_subjectId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (subject, response, status) {
			$.messager.progress("close");
			if (subject) { 
				$("#subject_subjectId_edit").val(subject.subjectId);
				$("#subject_subjectId_edit").validatebox({
					required : true,
					missingMessage : "请输入题目id",
					editable: false
				});
				$("#subject_subjectName_edit").val(subject.subjectName);
				$("#subject_subjectName_edit").validatebox({
					required : true,
					missingMessage : "请输入题目名称",
				});
				$("#subject_subjectTypeObj_typeId_edit").combobox({
					url:"SubjectType/listAll",
					valueField:"typeId",
					textField:"typeName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#subject_subjectTypeObj_typeId_edit").combobox("select", subject.subjectTypeObjPri);
						//var data = $("#subject_subjectTypeObj_typeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#subject_subjectTypeObj_typeId_edit").combobox("select", data[0].typeId);
						//}
					}
				});
				subject_sujectContent_edit.setContent(subject.sujectContent);
				$("#subject_taskFile").val(subject.taskFile);
				if(subject.taskFile == "") $("#subject_taskFileA").html("暂无文件");
				$("#subject_taskFileA").attr("href", subject.taskFile);
				$("#subject_otherFile").val(subject.otherFile);
				if(subject.otherFile == "") $("#subject_otherFileA").html("暂无文件");
				$("#subject_otherFileA").attr("href", subject.otherFile);
				$("#subject_personNum_edit").val(subject.personNum);
				$("#subject_personNum_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入限选人数",
					invalidMessage : "限选人数输入不对",
				});
				$("#subject_teacherObj_teacherNo_edit").combobox({
					url:"Teacher/listAll",
					valueField:"teacherNo",
					textField:"teacherName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#subject_teacherObj_teacherNo_edit").combobox("select", subject.teacherObjPri);
						//var data = $("#subject_teacherObj_teacherNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#subject_teacherObj_teacherNo_edit").combobox("select", data[0].teacherNo);
						//}
					}
				});
				$("#subject_addTime_edit").datetimebox({
					value: subject.addTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#subjectModifyButton").click(function(){ 
		if ($("#subjectEditForm").form("validate")) {
			$("#subjectEditForm").form({
			    url:"Subject/" +  $("#subject_subjectId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#subjectEditForm").form("validate"))  {
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
			$("#subjectEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
