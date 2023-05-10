<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/opus.css" /> 

<div id="opus_manage"></div>
<div id="opus_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="opus_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="opus_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="opus_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="opus_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="opus_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="opusQueryForm" method="post">
			论文题目：<input class="textbox" type="text" id="subjectObj_subjectId_query" name="subjectObj.subjectId" style="width: auto"/>
			提交学生：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="opus_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="opusEditDiv">
	<form id="opusEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">成果id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="opus_opusId_edit" name="opus.opusId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Opus/js/opus_manage.js"></script> 
