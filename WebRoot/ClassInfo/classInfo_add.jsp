<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/classInfo.css" />
<div id="classInfoAddDiv">
	<form id="classInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">班级编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_classNo" name="classInfo.classNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">班级名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_className" name="classInfo.className" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所属学院:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_college" name="classInfo.college" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所属专业:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_specialName" name="classInfo.specialName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_bornDate" name="classInfo.bornDate" />

			</span>

		</div>
		<div>
			<span class="label">班主任:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_mainTeacher" name="classInfo.mainTeacher" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">班级备注:</span>
			<span class="inputControl">
				<textarea id="classInfo_classMemo" name="classInfo.classMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="classInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="classInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ClassInfo/js/classInfo_add.js"></script> 
