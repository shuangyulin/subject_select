<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/teacher.css" /> 

<div id="teacher_manage"></div>
<div id="teacher_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="teacher_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="teacher_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="teacher_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="teacher_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="teacher_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="teacherQueryForm" method="post">
			教师编号：<input type="text" class="textbox" id="teacherNo" name="teacherNo" style="width:110px" />
			教师姓名：<input type="text" class="textbox" id="teacherName" name="teacherName" style="width:110px" />
			出生日期：<input type="text" id="birthDate" name="birthDate" class="easyui-datebox" editable="false" style="width:100px">
			教师职称：<input type="text" class="textbox" id="zhicheng" name="zhicheng" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="teacher_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="teacherEditDiv">
	<form id="teacherEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">教师编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherNo_edit" name="teacher.teacherNo" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_password_edit" name="teacher.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherName_edit" name="teacher.teacherName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherSex_edit" name="teacher.teacherSex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_birthDate_edit" name="teacher.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">教师照片:</span>
			<span class="inputControl">
				<img id="teacher_teacherPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="teacher_teacherPhoto" name="teacher.teacherPhoto"/>
				<input id="teacherPhotoFile" name="teacherPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">教师职称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_zhicheng_edit" name="teacher.zhicheng" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_telephone_edit" name="teacher.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师介绍:</span>
			<span class="inputControl">
				<script name="teacher.teacherDesc" id="teacher_teacherDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var teacher_teacherDesc_editor = UE.getEditor('teacher_teacherDesc_edit'); //教师介绍编辑器
</script>
<script type="text/javascript" src="Teacher/js/teacher_manage.js"></script> 
