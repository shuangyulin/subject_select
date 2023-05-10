<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/subject.css" />
<div id="subject_editDiv">
	<form id="subjectEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">题目id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subject_subjectId_edit" name="subject.subjectId" value="<%=request.getParameter("subjectId") %>" style="width:200px" />
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
				<script id="subject_sujectContent_edit" name="subject.sujectContent" type="text/plain"   style="width:750px;height:500px;"></script>

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
		<div class="operation">
			<a id="subjectModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Subject/js/subject_modify.js"></script> 
