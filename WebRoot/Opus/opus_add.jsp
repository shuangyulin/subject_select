<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/opus.css" />
<div id="opusAddDiv">
	<form id="opusAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">论文题目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="opus_subjectObj_subjectId" name="opus.subjectObj.subjectId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">提交学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="opus_userObj_user_name" name="opus.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">开题报告:</span>
			<span class="inputControl">
				<input id="ktbgFile" name="ktbgFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">外文文献翻译:</span>
			<span class="inputControl">
				<input id="wwwxFile" name="wwwxFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">论文初稿:</span>
			<span class="inputControl">
				<input id="lwcgFile" name="lwcgFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">论文终稿:</span>
			<span class="inputControl">
				<input id="lwzgFile" name="lwzgFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">其他文件:</span>
			<span class="inputControl">
				<input id="otherFileFile" name="otherFileFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">论文成绩:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="opus_chengji" name="opus.chengji" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">老师评价:</span>
			<span class="inputControl">
				<textarea id="opus_evaluate" name="opus.evaluate" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="opusAddButton" class="easyui-linkbutton">添加</a>
			<a id="opusClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Opus/js/opus_add.js"></script> 
