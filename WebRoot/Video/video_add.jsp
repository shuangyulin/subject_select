<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/video.css" />
<div id="videoAddDiv">
	<form id="videoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">论文题目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_subjectObj_subjectId" name="video.subjectObj.subjectId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">答辩学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_userObj_user_name" name="video.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">答辩视频:</span>
			<span class="inputControl">
				<input id="videoFileFile" name="videoFileFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">视频时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_videoTime" name="video.videoTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">答辩日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="video_videoDate" name="video.videoDate" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<script name="video.videoMemo" id="video_videoMemo" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div class="operation">
			<a id="videoAddButton" class="easyui-linkbutton">添加</a>
			<a id="videoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Video/js/video_add.js"></script> 
