var subject_manage_tool = null; 
$(function () { 
	initSubjectManageTool(); //建立Subject管理对象
	subject_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#subject_manage").datagrid({
		url : 'Subject/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "subjectId",
		sortOrder : "desc",
		toolbar : "#subject_manage_tool",
		columns : [[
			{
				field : "subjectId",
				title : "题目id",
				width : 70,
			},
			{
				field : "subjectName",
				title : "题目名称",
				width : 140,
			},
			{
				field : "subjectTypeObj",
				title : "题目类型",
				width : 140,
			},
			{
				field : "taskFile",
				title : "任务书文件",
				width : "350px",
				formatter: function(val,row) {
 					if(val == "") return "暂无文件";
					return "<a href='" + val + "' target='_blank' style='color:red;'>" + val + "</a>";
				}
 			},
			{
				field : "otherFile",
				title : "其他资料文件",
				width : "350px",
				formatter: function(val,row) {
 					if(val == "") return "暂无文件";
					return "<a href='" + val + "' target='_blank' style='color:red;'>" + val + "</a>";
				}
 			},
			{
				field : "personNum",
				title : "限选人数",
				width : 70,
			},
			{
				field : "teacherObj",
				title : "指导老师",
				width : 140,
			},
			{
				field : "addTime",
				title : "发布时间",
				width : 140,
			},
		]],
	});

	$("#subjectEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#subjectEditForm").form("validate")) {
					//验证表单 
					if(!$("#subjectEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#subjectEditForm").form({
						    url:"Subject/" + $("#subject_subjectId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#subjectEditDiv").dialog("close");
			                        subject_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#subjectEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#subjectEditDiv").dialog("close");
				$("#subjectEditForm").form("reset"); 
			},
		}],
	});
});

function initSubjectManageTool() {
	subject_manage_tool = {
		init: function() {
			$.ajax({
				url : "SubjectType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#subjectTypeObj_typeId_query").combobox({ 
					    valueField:"typeId",
					    textField:"typeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{typeId:0,typeName:"不限制"});
					$("#subjectTypeObj_typeId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Teacher/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#teacherObj_teacherNo_query").combobox({ 
					    valueField:"teacherNo",
					    textField:"teacherName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{teacherNo:"",teacherName:"不限制"});
					$("#teacherObj_teacherNo_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#subject_manage").datagrid("reload");
		},
		redo : function () {
			$("#subject_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#subject_manage").datagrid("options").queryParams;
			queryParams["subjectName"] = $("#subjectName").val();
			queryParams["subjectTypeObj.typeId"] = $("#subjectTypeObj_typeId_query").combobox("getValue");
			queryParams["teacherObj.teacherNo"] = $("#teacherObj_teacherNo_query").combobox("getValue");
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			$("#subject_manage").datagrid("options").queryParams=queryParams; 
			$("#subject_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#subjectQueryForm").form({
			    url:"Subject/OutToExcel",
			});
			//提交表单
			$("#subjectQueryForm").submit();
		},
		remove : function () {
			var rows = $("#subject_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var subjectIds = [];
						for (var i = 0; i < rows.length; i ++) {
							subjectIds.push(rows[i].subjectId);
						}
						$.ajax({
							type : "POST",
							url : "Subject/deletes",
							data : {
								subjectIds : subjectIds.join(","),
							},
							beforeSend : function () {
								$("#subject_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#subject_manage").datagrid("loaded");
									$("#subject_manage").datagrid("load");
									$("#subject_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#subject_manage").datagrid("loaded");
									$("#subject_manage").datagrid("load");
									$("#subject_manage").datagrid("unselectAll");
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
			var rows = $("#subject_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Subject/" + rows[0].subjectId +  "/update",
					type : "get",
					data : {
						//subjectId : rows[0].subjectId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (subject, response, status) {
						$.messager.progress("close");
						if (subject) { 
							$("#subjectEditDiv").dialog("open");
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
							subject_sujectContent_editor.setContent(subject.sujectContent, false);
							$("#subject_taskFile").val(subject.taskFile);
							if(subject.taskFile == "") $("#subject_taskFileA").html("暂无文件");
							else $("#subject_taskFileA").html(subject.taskFile);
							$("#subject_taskFileA").attr("href", subject.taskFile);
							$("#subject_otherFile").val(subject.otherFile);
							if(subject.otherFile == "") $("#subject_otherFileA").html("暂无文件");
							else $("#subject_otherFileA").html(subject.otherFile);
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
