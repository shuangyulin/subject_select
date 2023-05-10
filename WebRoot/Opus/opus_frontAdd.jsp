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
<title>学生成果添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Opus/frontlist">学生成果列表</a></li>
			    	<li role="presentation" class="active"><a href="#opusAdd" aria-controls="opusAdd" role="tab" data-toggle="tab">添加学生成果</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="opusList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="opusAdd"> 
				      	<form class="form-horizontal" name="opusAddForm" id="opusAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="opus_subjectObj_subjectId" class="col-md-2 text-right">论文题目:</label>
						  	 <div class="col-md-8">
							    <select id="opus_subjectObj_subjectId" name="opus.subjectObj.subjectId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="opus_userObj_user_name" class="col-md-2 text-right">提交学生:</label>
						  	 <div class="col-md-8">
							    <select id="opus_userObj_user_name" name="opus.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="opus_ktbg" class="col-md-2 text-right">开题报告:</label>
						  	 <div class="col-md-8">
							    <a id="opus_ktbgImg" border="0px"></a><br/>
							    <input type="hidden" id="opus_ktbg" name="opus.ktbg"/>
							    <input id="ktbgFile" name="ktbgFile" type="file" size="50" />
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="opus_wwwx" class="col-md-2 text-right">外文文献翻译:</label>
						  	 <div class="col-md-8">
							    <a id="opus_wwwxImg" border="0px"></a><br/>
							    <input type="hidden" id="opus_wwwx" name="opus.wwwx"/>
							    <input id="wwwxFile" name="wwwxFile" type="file" size="50" />
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="opus_lwcg" class="col-md-2 text-right">论文初稿:</label>
						  	 <div class="col-md-8">
							    <a id="opus_lwcgImg" border="0px"></a><br/>
							    <input type="hidden" id="opus_lwcg" name="opus.lwcg"/>
							    <input id="lwcgFile" name="lwcgFile" type="file" size="50" />
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="opus_lwzg" class="col-md-2 text-right">论文终稿:</label>
						  	 <div class="col-md-8">
							    <a id="opus_lwzgImg" border="0px"></a><br/>
							    <input type="hidden" id="opus_lwzg" name="opus.lwzg"/>
							    <input id="lwzgFile" name="lwzgFile" type="file" size="50" />
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="opus_otherFile" class="col-md-2 text-right">其他文件:</label>
						  	 <div class="col-md-8">
							    <a id="opus_otherFileImg" border="0px"></a><br/>
							    <input type="hidden" id="opus_otherFile" name="opus.otherFile"/>
							    <input id="otherFileFile" name="otherFileFile" type="file" size="50" />
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="opus_chengji" class="col-md-2 text-right">论文成绩:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="opus_chengji" name="opus.chengji" class="form-control" placeholder="请输入论文成绩">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="opus_evaluate" class="col-md-2 text-right">老师评价:</label>
						  	 <div class="col-md-8">
							    <textarea id="opus_evaluate" name="opus.evaluate" rows="8" class="form-control" placeholder="请输入老师评价"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxOpusAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#opusAddForm .form-group {margin:10px;}  </style>
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
<script>
var basePath = "<%=basePath%>";
	//提交添加学生成果信息
	function ajaxOpusAdd() { 
		//提交之前先验证表单
		$("#opusAddForm").data('bootstrapValidator').validate();
		if(!$("#opusAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Opus/add",
			dataType : "json" , 
			data: new FormData($("#opusAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#opusAddForm").find("input").val("");
					$("#opusAddForm").find("textarea").val("");
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
	//验证学生成果添加表单字段
	$('#opusAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
		}
	}); 
	//初始化论文题目下拉框值 
	$.ajax({
		url: basePath + "Subject/listAll",
		type: "get",
		success: function(subjects,response,status) { 
			$("#opus_subjectObj_subjectId").empty();
			var html="";
    		$(subjects).each(function(i,subject){
    			html += "<option value='" + subject.subjectId + "'>" + subject.subjectName + "</option>";
    		});
    		$("#opus_subjectObj_subjectId").html(html);
    	}
	});
	//初始化提交学生下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#opus_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#opus_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
