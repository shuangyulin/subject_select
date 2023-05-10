$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('video_videoMemo');
	var video_videoMemo_editor = UE.getEditor('video_videoMemo'); //附加信息编辑框
	$("#video_subjectObj_subjectId").combobox({
	    url:'Subject/listAll',
	    valueField: "subjectId",
	    textField: "subjectName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#video_subjectObj_subjectId").combobox("getData"); 
            if (data.length > 0) {
                $("#video_subjectObj_subjectId").combobox("select", data[0].subjectId);
            }
        }
	});
	$("#video_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#video_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#video_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#video_videoTime").validatebox({
		required : true, 
		missingMessage : '请输入视频时间',
	});

	$("#video_videoDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#videoAddButton").click(function () {
		//验证表单 
		if(!$("#videoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#videoAddForm").form({
			    url:"Video/add",
			    onSubmit: function(){
					if($("#videoAddForm").form("validate"))  { 
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
                        $("#videoAddForm").form("clear");
                        video_videoMemo_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#videoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#videoClearButton").click(function () { 
		$("#videoAddForm").form("clear"); 
	});
});
