var opus_manage_tool = null; 
$(function () { 
	initOpusManageTool(); //建立Opus管理对象
	opus_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#opus_manage").datagrid({
		url : 'Opus/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "opusId",
		sortOrder : "desc",
		toolbar : "#opus_manage_tool",
		columns : [[
			{
				field : "opusId",
				title : "成果id",
				width : 70,
			},
			{
				field : "subjectObj",
				title : "论文题目",
				width : 140,
			},
			{
				field : "userObj",
				title : "提交学生",
				width : 140,
			},
			{
				field : "ktbg",
				title : "开题报告",
				width : "350px",
				formatter: function(val,row) {
 					if(val == "") return "暂无文件";
					return "<a href='" + val + "' target='_blank' style='color:red;'>" + val + "</a>";
				}
 			},
			{
				field : "wwwx",
				title : "外文文献翻译",
				width : "350px",
				formatter: function(val,row) {
 					if(val == "") return "暂无文件";
					return "<a href='" + val + "' target='_blank' style='color:red;'>" + val + "</a>";
				}
 			},
			{
				field : "lwcg",
				title : "论文初稿",
				width : "350px",
				formatter: function(val,row) {
 					if(val == "") return "暂无文件";
					return "<a href='" + val + "' target='_blank' style='color:red;'>" + val + "</a>";
				}
 			},
			{
				field : "lwzg",
				title : "论文终稿",
				width : "350px",
				formatter: function(val,row) {
 					if(val == "") return "暂无文件";
					return "<a href='" + val + "' target='_blank' style='color:red;'>" + val + "</a>";
				}
 			},
			{
				field : "otherFile",
				title : "其他文件",
				width : "350px",
				formatter: function(val,row) {
 					if(val == "") return "暂无文件";
					return "<a href='" + val + "' target='_blank' style='color:red;'>" + val + "</a>";
				}
 			},
			{
				field : "chengji",
				title : "论文成绩",
				width : 140,
			},
			{
				field : "evaluate",
				title : "老师评价",
				width : 140,
			},
		]],
	});

	$("#opusEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#opusEditForm").form("validate")) {
					//验证表单 
					if(!$("#opusEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#opusEditForm").form({
						    url:"Opus/" + $("#opus_opusId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#opusEditDiv").dialog("close");
			                        opus_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#opusEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#opusEditDiv").dialog("close");
				$("#opusEditForm").form("reset"); 
			},
		}],
	});
});

function initOpusManageTool() {
	opus_manage_tool = {
		init: function() {
			$.ajax({
				url : "Subject/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#subjectObj_subjectId_query").combobox({ 
					    valueField:"subjectId",
					    textField:"subjectName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{subjectId:0,subjectName:"不限制"});
					$("#subjectObj_subjectId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#opus_manage").datagrid("reload");
		},
		redo : function () {
			$("#opus_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#opus_manage").datagrid("options").queryParams;
			queryParams["subjectObj.subjectId"] = $("#subjectObj_subjectId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#opus_manage").datagrid("options").queryParams=queryParams; 
			$("#opus_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#opusQueryForm").form({
			    url:"Opus/OutToExcel",
			});
			//提交表单
			$("#opusQueryForm").submit();
		},
		remove : function () {
			var rows = $("#opus_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var opusIds = [];
						for (var i = 0; i < rows.length; i ++) {
							opusIds.push(rows[i].opusId);
						}
						$.ajax({
							type : "POST",
							url : "Opus/deletes",
							data : {
								opusIds : opusIds.join(","),
							},
							beforeSend : function () {
								$("#opus_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#opus_manage").datagrid("loaded");
									$("#opus_manage").datagrid("load");
									$("#opus_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#opus_manage").datagrid("loaded");
									$("#opus_manage").datagrid("load");
									$("#opus_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#opus_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Opus/" + rows[0].opusId +  "/update",
					type : "get",
					data : {
						//opusId : rows[0].opusId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (opus, response, status) {
						$.messager.progress("close");
						if (opus) { 
							$("#opusEditDiv").dialog("open");
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
							else $("#opus_ktbgA").html(opus.ktbg);
							$("#opus_ktbgA").attr("href", opus.ktbg);
							$("#opus_wwwx").val(opus.wwwx);
							if(opus.wwwx == "") $("#opus_wwwxA").html("暂无文件");
							else $("#opus_wwwxA").html(opus.wwwx);
							$("#opus_wwwxA").attr("href", opus.wwwx);
							$("#opus_lwcg").val(opus.lwcg);
							if(opus.lwcg == "") $("#opus_lwcgA").html("暂无文件");
							else $("#opus_lwcgA").html(opus.lwcg);
							$("#opus_lwcgA").attr("href", opus.lwcg);
							$("#opus_lwzg").val(opus.lwzg);
							if(opus.lwzg == "") $("#opus_lwzgA").html("暂无文件");
							else $("#opus_lwzgA").html(opus.lwzg);
							$("#opus_lwzgA").attr("href", opus.lwzg);
							$("#opus_otherFile").val(opus.otherFile);
							if(opus.otherFile == "") $("#opus_otherFileA").html("暂无文件");
							else $("#opus_otherFileA").html(opus.otherFile);
							$("#opus_otherFileA").attr("href", opus.otherFile);
							$("#opus_chengji_edit").val(opus.chengji);
							$("#opus_evaluate_edit").val(opus.evaluate);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
