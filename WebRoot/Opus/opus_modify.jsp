<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/opus.css" />
<div id="opus_editDiv">
	<form id="opusEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">成果id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="opus_opusId_edit" name="opus.opusId" value="<%=request.getParameter("opusId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">论文题目:</span>
			<span class="inputControl">
				<input class="textbox"  id="opus_subjectObj_subjectId_edit" name="opus.subjectObj.subjectId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">提交学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="opus_userObj_user_name_edit" name="opus.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">开题报告:</span>
			<span class="inputControl">
				<a id="opus_ktbgA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="opus_ktbg" name="opus.ktbg"/>
				<input id="ktbgFile" name="ktbgFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">外文文献翻译:</span>
			<span class="inputControl">
				<a id="opus_wwwxA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="opus_wwwx" name="opus.wwwx"/>
				<input id="wwwxFile" name="wwwxFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">论文初稿:</span>
			<span class="inputControl">
				<a id="opus_lwcgA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="opus_lwcg" name="opus.lwcg"/>
				<input id="lwcgFile" name="lwcgFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">论文终稿:</span>
			<span class="inputControl">
				<a id="opus_lwzgA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="opus_lwzg" name="opus.lwzg"/>
				<input id="lwzgFile" name="lwzgFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">其他文件:</span>
			<span class="inputControl">
				<a id="opus_otherFileA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="opus_otherFile" name="opus.otherFile"/>
				<input id="otherFileFile" name="otherFileFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">论文成绩:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="opus_chengji_edit" name="opus.chengji" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">老师评价:</span>
			<span class="inputControl">
				<textarea id="opus_evaluate_edit" name="opus.evaluate" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="opusModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Opus/js/opus_modify.js"></script> 
