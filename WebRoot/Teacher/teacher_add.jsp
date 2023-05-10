<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/teacher.css" />
<div id="teacherAddDiv">
	<form id="teacherAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">教师编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherNo" name="teacher.teacherNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_password" name="teacher.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherName" name="teacher.teacherName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherSex" name="teacher.teacherSex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_birthDate" name="teacher.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">教师照片:</span>
			<span class="inputControl">
				<input id="teacherPhotoFile" name="teacherPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">教师职称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_zhicheng" name="teacher.zhicheng" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_telephone" name="teacher.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师介绍:</span>
			<span class="inputControl">
				<script name="teacher.teacherDesc" id="teacher_teacherDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div class="operation">
			<a id="teacherAddButton" class="easyui-linkbutton">添加</a>
			<a id="teacherClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Teacher/js/teacher_add.js"></script> 
