<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/subSelect.css" />
<div id="subSelect_editDiv">
	<form id="subSelectEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">选题id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subSelect_selectId_edit" name="subSelect.selectId" value="<%=request.getParameter("selectId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">论文题目:</span>
			<span class="inputControl">
				<input class="textbox"  id="subSelect_subjectObj_subjectId_edit" name="subSelect.subjectObj.subjectId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">选题学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="subSelect_userObj_user_name_edit" name="subSelect.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">选题时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subSelect_selectTime_edit" name="subSelect.selectTime" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="subSelect_shenHeState_edit" name="subSelect.shenHeState" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="subSelectModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/SubSelect/js/subSelect_modify.js"></script> 
