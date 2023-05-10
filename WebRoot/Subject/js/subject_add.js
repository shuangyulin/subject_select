$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('subject_sujectContent');
	var subject_sujectContent_editor = UE.getEditor('subject_sujectContent'); //题目内容编辑框
	$("#subject_subjectName").validatebox({
		required : true, 
		missingMessage : '请输入题目名称',
	});

	$("#subject_subjectTypeObj_typeId").combobox({
	    url:'SubjectType/listAll',
	    valueField: "typeId",
	    textField: "typeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#subject_subjectTypeObj_typeId").combobox("getData"); 
            if (data.length > 0) {
                $("#subject_subjectTypeObj_typeId").combobox("select", data[0].typeId);
            }
        }
	});
	$("#subject_personNum").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入限选人数',
		invalidMessage : '限选人数输入不对',
	});

	$("#subject_teacherObj_teacherNo").combobox({
	    url:'Teacher/listAll',
	    valueField: "teacherNo",
	    textField: "teacherName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#subject_teacherObj_teacherNo").combobox("getData"); 
            if (data.length > 0) {
                $("#subject_teacherObj_teacherNo").combobox("select", data[0].teacherNo);
            }
        }
	});
	$("#subject_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#subjectAddButton").click(function () {
		if(subject_sujectContent_editor.getContent() == "") {
			alert("请输入题目内容");
			return;
		}
		//验证表单 
		if(!$("#subjectAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#subjectAddForm").form({
			    url:"Subject/add",
			    onSubmit: function(){
					if($("#subjectAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#subjectAddForm").form("clear");
                        subject_sujectContent_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#subjectAddForm").submit();
		}
	});

	//单击清空按钮
	$("#subjectClearButton").click(function () { 
		$("#subjectAddForm").form("clear"); 
	});
});
