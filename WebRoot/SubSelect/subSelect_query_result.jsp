<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/subSelect.css" /> 

<div id="subSelect_manage"></div>
<div id="subSelect_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="subSelect_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="subSelect_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="subSelect_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="subSelect_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="subSelect_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="subSelectQueryForm" method="post">
			论文题目：<input class="textbox" type="text" id="subjectObj_subjectId_query" name="subjectObj.subjectId" style="width: auto"/>
			选题学生：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			选题时间：<input type="text" id="selectTime" name="selectTime" class="easyui-datebox" editable="false" style="width:100px">
			审核状态：<input type="text" class="textbox" id="shenHeState" name="shenHeState" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="subSelect_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="subSelectEditDiv">
	<form id="subSelectEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">选题id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subSelect_selectId_edit" name="subSelect.selectId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">论文题目:</span>
			<span class="inputControl">
				<input class="textbox"  id="subSelect_subjectObj_subjectId_edit" name="subSelect.subjectObj.subjectId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">选题学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="subSelect_userObj_user_name_edit" name="subSelect.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">选题时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subSelect_selectTime_edit" name="subSelect.selectTime" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subSelect_shenHeState_edit" name="subSelect.shenHeState" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="SubSelect/js/subSelect_manage.js"></script> 
