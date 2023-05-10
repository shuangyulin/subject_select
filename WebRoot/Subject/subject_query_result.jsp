<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/subject.css" /> 

<div id="subject_manage"></div>
<div id="subject_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="subject_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="subject_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="subject_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="subject_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="subject_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="subjectQueryForm" method="post">
			题目名称：<input type="text" class="textbox" id="subjectName" name="subjectName" style="width:110px" />
			题目类型：<input class="textbox" type="text" id="subjectTypeObj_typeId_query" name="subjectTypeObj.typeId" style="width: auto"/>
			指导老师：<input class="textbox" type="text" id="teacherObj_teacherNo_query" name="teacherObj.teacherNo" style="width: auto"/>
			发布时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="subject_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="subjectEditDiv">
	<form id="subjectEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">题目id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subject_subjectId_edit" name="subject.subjectId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">题目名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subject_subjectName_edit" name="subject.subjectName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">题目类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="subject_subjectTypeObj_typeId_edit" name="subject.subjectTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">题目内容:</span>
			<span class="inputControl">
				<script name="subject.sujectContent" id="subject_sujectContent_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">任务书文件:</span>
			<span class="inputControl">
				<a id="subject_taskFileA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="subject_taskFile" name="subject.taskFile"/>
				<input id="taskFileFile" name="taskFileFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">其他资料文件:</span>
			<span class="inputControl">
				<a id="subject_otherFileA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="subject_otherFile" name="subject.otherFile"/>
				<input id="otherFileFile" name="otherFileFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">限选人数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subject_personNum_edit" name="subject.personNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">指导老师:</span>
			<span class="inputControl">
				<input class="textbox"  id="subject_teacherObj_teacherNo_edit" name="subject.teacherObj.teacherNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subject_addTime_edit" name="subject.addTime" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var subject_sujectContent_editor = UE.getEditor('subject_sujectContent_edit'); //题目内容编辑器
</script>
<script type="text/javascript" src="Subject/js/subject_manage.js"></script> 
