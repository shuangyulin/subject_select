<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/subject.css" />
<div id="subjectAddDiv">
	<form id="subjectAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">题目名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subject_subjectName" name="subject.subjectName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">题目类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subject_subjectTypeObj_typeId" name="subject.subjectTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">题目内容:</span>
			<span class="inputControl">
				<script name="subject.sujectContent" id="subject_sujectContent" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">任务书文件:</span>
			<span class="inputControl">
				<input id="taskFileFile" name="taskFileFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">其他资料文件:</span>
			<span class="inputControl">
				<input id="otherFileFile" name="otherFileFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">限选人数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subject_personNum" name="subject.personNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">指导老师:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subject_teacherObj_teacherNo" name="subject.teacherObj.teacherNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subject_addTime" name="subject.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="subjectAddButton" class="easyui-linkbutton">添加</a>
			<a id="subjectClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Subject/js/subject_add.js"></script> 
