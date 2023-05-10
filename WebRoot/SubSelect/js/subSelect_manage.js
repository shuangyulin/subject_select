var subSelect_manage_tool = null; 
$(function () { 
	initSubSelectManageTool(); //建立SubSelect管理对象
	subSelect_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#subSelect_manage").datagrid({
		url : 'SubSelect/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "selectId",
		sortOrder : "desc",
		toolbar : "#subSelect_manage_tool",
		columns : [[
			{
				field : "selectId",
				title : "选题id",
				width : 70,
			},
			{
				field : "subjectObj",
				title : "论文题目",
				width : 140,
			},
			{
				field : "userObj",
				title : "选题学生",
				width : 140,
			},
			{
				field : "selectTime",
				title : "选题时间",
				width : 140,
			},
			{
				field : "shenHeState",
				title : "审核状态",
				width : 140,
			},
		]],
	});

	$("#subSelectEditDiv").dialog({
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
				if ($("#subSelectEditForm").form("validate")) {
					//验证表单 
					if(!$("#subSelectEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#subSelectEditForm").form({
						    url:"SubSelect/" + $("#subSelect_selectId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#subSelectEditDiv").dialog("close");
			                        subSelect_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#subSelectEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#subSelectEditDiv").dialog("close");
				$("#subSelectEditForm").form("reset"); 
			},
		}],
	});
});

function initSubSelectManageTool() {
	subSelect_manage_tool = {
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
			$("#subSelect_manage").datagrid("reload");
		},
		redo : function () {
			$("#subSelect_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#subSelect_manage").datagrid("options").queryParams;
			queryParams["subjectObj.subjectId"] = $("#subjectObj_subjectId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["selectTime"] = $("#selectTime").datebox("getValue"); 
			queryParams["shenHeState"] = $("#shenHeState").val();
			$("#subSelect_manage").datagrid("options").queryParams=queryParams; 
			$("#subSelect_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#subSelectQueryForm").form({
			    url:"SubSelect/OutToExcel",
			});
			//提交表单
			$("#subSelectQueryForm").submit();
		},
		remove : function () {
			var rows = $("#subSelect_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var selectIds = [];
						for (var i = 0; i < rows.length; i ++) {
							selectIds.push(rows[i].selectId);
						}
						$.ajax({
							type : "POST",
							url : "SubSelect/deletes",
							data : {
								selectIds : selectIds.join(","),
							},
							beforeSend : function () {
								$("#subSelect_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#subSelect_manage").datagrid("loaded");
									$("#subSelect_manage").datagrid("load");
									$("#subSelect_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#subSelect_manage").datagrid("loaded");
									$("#subSelect_manage").datagrid("load");
									$("#subSelect_manage").datagrid("unselectAll");
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
			var rows = $("#subSelect_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "SubSelect/" + rows[0].selectId +  "/update",
					type : "get",
					data : {
						//selectId : rows[0].selectId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (subSelect, response, status) {
						$.messager.progress("close");
						if (subSelect) { 
							$("#subSelectEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
