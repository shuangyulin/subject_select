<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/teacher.css" />
<div id="teacher_editDiv">
	<form id="teacherEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">教师编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherNo_edit" name="teacher.teacherNo" value="<%=request.getParameter("teacherNo") %>" style="width:200px" />
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
				<script id="teacher_teacherDesc_edit" name="teacher.teacherDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div class="operation">
			<a id="teacherModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Teacher/js/teacher_modify.js"></script> 
