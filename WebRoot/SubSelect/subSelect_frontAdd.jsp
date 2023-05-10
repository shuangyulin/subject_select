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
<title>学生选题添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>SubSelect/frontlist">学生选题列表</a></li>
			    	<li role="presentation" class="active"><a href="#subSelectAdd" aria-controls="subSelectAdd" role="tab" data-toggle="tab">添加学生选题</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="subSelectList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="subSelectAdd"> 
				      	<form class="form-horizontal" name="subSelectAddForm" id="subSelectAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="subSelect_subjectObj_subjectId" class="col-md-2 text-right">论文题目:</label>
						  	 <div class="col-md-8">
							    <select id="subSelect_subjectObj_subjectId" name="subSelect.subjectObj.subjectId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="subSelect_userObj_user_name" class="col-md-2 text-right">选题学生:</label>
						  	 <div class="col-md-8">
							    <select id="subSelect_userObj_user_name" name="subSelect.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="subSelect_selectTimeDiv" class="col-md-2 text-right">选题时间:</label>
						  	 <div class="col-md-8">
				                <div id="subSelect_selectTimeDiv" class="input-group date subSelect_selectTime col-md-12" data-link-field="subSelect_selectTime">
				                    <input class="form-control" id="subSelect_selectTime" name="subSelect.selectTime" size="16" type="text" value="" placeholder="请选择选题时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="subSelect_shenHeState" class="col-md-2 text-right">审核状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="subSelect_shenHeState" name="subSelect.shenHeState" class="form-control" placeholder="请输入审核状态">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxSubSelectAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#subSelectAddForm .form-group {margin:10px;}  </style>
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
	//提交添加学生选题信息
	function ajaxSubSelectAdd() { 
		//提交之前先验证表单
		$("#subSelectAddForm").data('bootstrapValidator').validate();
		if(!$("#subSelectAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "SubSelect/add",
			dataType : "json" , 
			data: new FormData($("#subSelectAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#subSelectAddForm").find("input").val("");
					$("#subSelectAddForm").find("textarea").val("");
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
	//验证学生选题添加表单字段
	$('#subSelectAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"subSelect.selectTime": {
				validators: {
					notEmpty: {
						message: "选题时间不能为空",
					}
				}
			},
			"subSelect.shenHeState": {
				validators: {
					notEmpty: {
						message: "审核状态不能为空",
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
			$("#subSelect_subjectObj_subjectId").empty();
			var html="";
    		$(subjects).each(function(i,subject){
    			html += "<option value='" + subject.subjectId + "'>" + subject.subjectName + "</option>";
    		});
    		$("#subSelect_subjectObj_subjectId").html(html);
    	}
	});
	//初始化选题学生下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#subSelect_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#subSelect_userObj_user_name").html(html);
    	}
	});
	//选题时间组件
	$('#subSelect_selectTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#subSelectAddForm').data('bootstrapValidator').updateStatus('subSelect.selectTime', 'NOT_VALIDATED',null).validateField('subSelect.selectTime');
	});
})
</script>
</body>
</html>
