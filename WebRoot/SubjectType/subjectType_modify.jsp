<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/subjectType.css" />
<div id="subjectType_editDiv">
	<form id="subjectTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类型编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subjectType_typeId_edit" name="subjectType.typeId" value="<%=request.getParameter("typeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subjectType_typeName_edit" name="subjectType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="subjectTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/SubjectType/js/subjectType_modify.js"></script> 
