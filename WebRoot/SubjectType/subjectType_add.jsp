<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/subjectType.css" />
<div id="subjectTypeAddDiv">
	<form id="subjectTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subjectType_typeName" name="subjectType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="subjectTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="subjectTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/SubjectType/js/subjectType_add.js"></script> 
