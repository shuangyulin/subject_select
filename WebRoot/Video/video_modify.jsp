<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/video.css" />
<div id="video_editDiv">
	<form id="videoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">视频id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_videoId_edit" name="video.videoId" value="<%=request.getParameter("videoId") %>" style="width:200px" />
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
				<script id="video_videoMemo_edit" name="video.videoMemo" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div class="operation">
			<a id="videoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Video/js/video_modify.js"></script> 
