<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/subSelect.css" />
<div id="subSelectAddDiv">
	<form id="subSelectAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">论文题目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subSelect_subjectObj_subjectId" name="subSelect.subjectObj.subjectId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">选题学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subSelect_userObj_user_name" name="subSelect.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">选题时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subSelect_selectTime" name="subSelect.selectTime" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subSelect_shenHeState" name="subSelect.shenHeState" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="subSelectAddButton" class="easyui-linkbutton">添加</a>
			<a id="subSelectClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/SubSelect/js/subSelect_add.js"></script> 
