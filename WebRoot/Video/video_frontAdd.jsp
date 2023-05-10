<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Subject" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>答辩视频添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Video/frontlist">答辩视频列表</a></li>
			    	<li role="presentation" class="active"><a href="#videoAdd" aria-controls="videoAdd" role="tab" data-toggle="tab">添加答辩视频</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="videoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="videoAdd"> 
				      	<form class="form-horizontal" name="videoAddForm" id="videoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="video_subjectObj_subjectId" class="col-md-2 text-right">论文题目:</label>
						  	 <div class="col-md-8">
							    <select id="video_subjectObj_subjectId" name="video.subjectObj.subjectId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="video_userObj_user_name" class="col-md-2 text-right">答辩学生:</label>
						  	 <div class="col-md-8">
							    <select id="video_userObj_user_name" name="video.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="video_videoFile" class="col-md-2 text-right">答辩视频:</label>
						  	 <div class="col-md-8">
							    <a id="video_videoFileImg" border="0px"></a><br/>
							    <input type="hidden" id="video_videoFile" name="video.videoFile"/>
							    <input id="videoFileFile" name="videoFileFile" type="file" size="50" />
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="video_videoTime" class="col-md-2 text-right">视频时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="video_videoTime" name="video.videoTime" class="form-control" placeholder="请输入视频时间">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="video_videoDateDiv" class="col-md-2 text-right">答辩日期:</label>
						  	 <div class="col-md-8">
				                <div id="video_videoDateDiv" class="input-group date video_videoDate col-md-12" data-link-field="video_videoDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="video_videoDate" name="video.videoDate" size="16" type="text" value="" placeholder="请选择答辩日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="video_videoMemo" class="col-md-2 text-right">附加信息:</label>
						  	 <div class="col-md-8">
							    <textarea name="video.videoMemo" id="video_videoMemo" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxVideoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#videoAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var video_videoMemo_editor = UE.getEditor('video_videoMemo'); //附加信息编辑器
var basePath = "<%=basePath%>";
	//提交添加答辩视频信息
	function ajaxVideoAdd() { 
		//提交之前先验证表单
		$("#videoAddForm").data('bootstrapValidator').validate();
		if(!$("#videoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Video/add",
			dataType : "json" , 
			data: new FormData($("#videoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#videoAddForm").find("input").val("");
					$("#videoAddForm").find("textarea").val("");
					video_videoMemo_editor.setContent("");
				} else {
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
	//验证答辩视频添加表单字段
	$('#videoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"video.videoTime": {
				validators: {
					notEmpty: {
						message: "视频时间不能为空",
					}
				}
			},
			"video.videoDate": {
				validators: {
					notEmpty: {
						message: "答辩日期不能为空",
					}
				}
			},
		}
	}); 
	//初始化论文题目下拉框值 
	$.ajax({
		url: basePath + "Subject/listAll",
		type: "get",
		success: function(subjects,response,status) { 
			$("#video_subjectObj_subjectId").empty();
			var html="";
    		$(subjects).each(function(i,subject){
    			html += "<option value='" + subject.subjectId + "'>" + subject.subjectName + "</option>";
    		});
    		$("#video_subjectObj_subjectId").html(html);
    	}
	});
	//初始化答辩学生下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#video_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#video_userObj_user_name").html(html);
    	}
	});
	//答辩日期组件
	$('#video_videoDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#videoAddForm').data('bootstrapValidator').updateStatus('video.videoDate', 'NOT_VALIDATED',null).validateField('video.videoDate');
	});
})
</script>
</body>
</html>
