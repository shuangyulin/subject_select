<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/video.css" /> 

<div id="video_manage"></div>
<div id="video_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="video_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="video_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="video_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="video_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="video_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="videoQueryForm" method="post">
			论文题目：<input class="textbox" type="text" id="subjectObj_subjectId_query" name="subjectObj.subjectId" style="width: auto"/>
			答辩学生：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			答辩日期：<input type="text" id="videoDate" name="videoDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="video_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="videoEditDiv">
	<form id="videoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">视频id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_videoId_edit" name="video.videoId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">论文题目:</span>
			<span class="inputControl">
				<input class="textbox"  id="video_subjectObj_subjectId_edit" name="video.subjectObj.subjectId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">答辩学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="video_userObj_user_name_edit" name="video.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">答辩视频:</span>
			<span class="inputControl">
				<a id="video_videoFileA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="video_videoFile" name="video.videoFile"/>
				<input id="videoFileFile" name="videoFileFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">视频时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_videoTime_edit" name="video.videoTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">答辩日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_videoDate_edit" name="video.videoDate" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<script name="video.videoMemo" id="video_videoMemo_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var video_videoMemo_editor = UE.getEditor('video_videoMemo_edit'); //附加信息编辑器
</script>
<script type="text/javascript" src="Video/js/video_manage.js"></script> 
