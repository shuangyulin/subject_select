<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/classInfo.css" /> 

<div id="classInfo_manage"></div>
<div id="classInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="classInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="classInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="classInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="classInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="classInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="classInfoQueryForm" method="post">
			班级编号：<input type="text" class="textbox" id="classNo" name="classNo" style="width:110px" />
			班级名称：<input type="text" class="textbox" id="className" name="className" style="width:110px" />
			所属学院：<input type="text" class="textbox" id="college" name="college" style="width:110px" />
			所属专业：<input type="text" class="textbox" id="specialName" name="specialName" style="width:110px" />
			成立日期：<input type="text" id="bornDate" name="bornDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="classInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="classInfoEditDiv">
	<form id="classInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">班级编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_classNo_edit" name="classInfo.classNo" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">班级名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_className_edit" name="classInfo.className" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所属学院:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_college_edit" name="classInfo.college" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所属专业:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_specialName_edit" name="classInfo.specialName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_bornDate_edit" name="classInfo.bornDate" />

			</span>

		</div>
		<div>
			<span class="label">班主任:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_mainTeacher_edit" name="classInfo.mainTeacher" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">班级备注:</span>
			<span class="inputControl">
				<textarea id="classInfo_classMemo_edit" name="classInfo.classMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="ClassInfo/js/classInfo_manage.js"></script> 
