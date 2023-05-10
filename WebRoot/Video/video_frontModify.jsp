<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Video" %>
<%@ page import="com.chengxusheji.po.Subject" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的subjectObj信息
    List<Subject> subjectList = (List<Subject>)request.getAttribute("subjectList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Video video = (Video)request.getAttribute("video");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改答辩视频信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">答辩视频信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="videoEditForm" id="videoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="video_videoId_edit" class="col-md-3 text-right">视频id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="video_videoId_edit" name="video.videoId" class="form-control" placeholder="请输入视频id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="video_subjectObj_subjectId_edit" class="col-md-3 text-right">论文题目:</label>
		  	 <div class="col-md-9">
			    <select id="video_subjectObj_subjectId_edit" name="video.subjectObj.subjectId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_userObj_user_name_edit" class="col-md-3 text-right">答辩学生:</label>
		  	 <div class="col-md-9">
			    <select id="video_userObj_user_name_edit" name="video.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoFile_edit" class="col-md-3 text-right">答辩视频:</label>
		  	 <div class="col-md-9">
			    <a id="video_videoFileImg" width="200px" border="0px"></a><br/>
			    <input type="hidden" id="video_videoFile" name="video.videoFile"/>
			    <input id="videoFileFile" name="videoFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoTime_edit" class="col-md-3 text-right">视频时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="video_videoTime_edit" name="video.videoTime" class="form-control" placeholder="请输入视频时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoDate_edit" class="col-md-3 text-right">答辩日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date video_videoDate_edit col-md-12" data-link-field="video_videoDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="video_videoDate_edit" name="video.videoDate" size="16" type="text" value="" placeholder="请选择答辩日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			    <script name="video.videoMemo" id="video_videoMemo_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxVideoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#videoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var video_videoMemo_editor = UE.getEditor('video_videoMemo_edit'); //附加信息编辑框
var basePath = "<%=basePath%>";
/*弹出修改答辩视频界面并初始化数据*/
function videoEdit(videoId) {
  video_videoMemo_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(videoId);
  });
}
 function ajaxModifyQuery(videoId) {
	$.ajax({
		url :  basePath + "Video/" + videoId + "/update",
		type : "get",
		dataType: "json",
		success : function (video, response, status) {
			if (video) {
				$("#video_videoId_edit").val(video.videoId);
				$.ajax({
					url: basePath + "Subject/listAll",
					type: "get",
					success: function(subjects,response,status) { 
						$("#video_subjectObj_subjectId_edit").empty();
						var html="";
		        		$(subjects).each(function(i,subject){
		        			html += "<option value='" + subject.subjectId + "'>" + subject.subjectName + "</option>";
		        		});
		        		$("#video_subjectObj_subjectId_edit").html(html);
		        		$("#video_subjectObj_subjectId_edit").val(video.subjectObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#video_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#video_userObj_user_name_edit").html(html);
		        		$("#video_userObj_user_name_edit").val(video.userObjPri);
					}
				});
				$("#video_videoFileA").val(video.videoFile);
				$("#video_videoFileA").attr("href", basePath +　video.videoFile);
				$("#video_videoTime_edit").val(video.videoTime);
				$("#video_videoDate_edit").val(video.videoDate);
				video_videoMemo_editor.setContent(video.videoMemo, false);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交答辩视频信息表单给服务器端修改*/
function ajaxVideoModify() {
	$.ajax({
		url :  basePath + "Video/" + $("#video_videoId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#videoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#videoQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*答辩日期组件*/
    $('.video_videoDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    videoEdit("<%=request.getParameter("videoId")%>");
 })
 </script> 
</body>
</html>

