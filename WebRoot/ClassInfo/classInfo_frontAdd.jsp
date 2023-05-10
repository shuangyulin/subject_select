<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>班级添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>ClassInfo/frontlist">班级列表</a></li>
			    	<li role="presentation" class="active"><a href="#classInfoAdd" aria-controls="classInfoAdd" role="tab" data-toggle="tab">添加班级</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="classInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="classInfoAdd"> 
				      	<form class="form-horizontal" name="classInfoAddForm" id="classInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
							 <label for="classInfo_classNo" class="col-md-2 text-right">班级编号:</label>
							 <div class="col-md-8"> 
							 	<input type="text" id="classInfo_classNo" name="classInfo.classNo" class="form-control" placeholder="请输入班级编号">
							 </div>
						  </div> 
						  <div class="form-group">
						  	 <label for="classInfo_className" class="col-md-2 text-right">班级名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="classInfo_className" name="classInfo.className" class="form-control" placeholder="请输入班级名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="classInfo_college" class="col-md-2 text-right">所属学院:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="classInfo_college" name="classInfo.college" class="form-control" placeholder="请输入所属学院">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="classInfo_specialName" class="col-md-2 text-right">所属专业:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="classInfo_specialName" name="classInfo.specialName" class="form-control" placeholder="请输入所属专业">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="classInfo_bornDateDiv" class="col-md-2 text-right">成立日期:</label>
						  	 <div class="col-md-8">
				                <div id="classInfo_bornDateDiv" class="input-group date classInfo_bornDate col-md-12" data-link-field="classInfo_bornDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="classInfo_bornDate" name="classInfo.bornDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="classInfo_mainTeacher" class="col-md-2 text-right">班主任:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="classInfo_mainTeacher" name="classInfo.mainTeacher" class="form-control" placeholder="请输入班主任">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="classInfo_classMemo" class="col-md-2 text-right">班级备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="classInfo_classMemo" name="classInfo.classMemo" rows="8" class="form-control" placeholder="请输入班级备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxClassInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#classInfoAddForm .form-group {margin:10px;}  </style>
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
	//提交添加班级信息
	function ajaxClassInfoAdd() { 
		//提交之前先验证表单
		$("#classInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#classInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "ClassInfo/add",
			dataType : "json" , 
			data: new FormData($("#classInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#classInfoAddForm").find("input").val("");
					$("#classInfoAddForm").find("textarea").val("");
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
	//验证班级添加表单字段
	$('#classInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"classInfo.classNo": {
				validators: {
					notEmpty: {
						message: "班级编号不能为空",
					}
				}
			},
			"classInfo.className": {
				validators: {
					notEmpty: {
						message: "班级名称不能为空",
					}
				}
			},
			"classInfo.college": {
				validators: {
					notEmpty: {
						message: "所属学院不能为空",
					}
				}
			},
			"classInfo.specialName": {
				validators: {
					notEmpty: {
						message: "所属专业不能为空",
					}
				}
			},
			"classInfo.bornDate": {
				validators: {
					notEmpty: {
						message: "成立日期不能为空",
					}
				}
			},
			"classInfo.mainTeacher": {
				validators: {
					notEmpty: {
						message: "班主任不能为空",
					}
				}
			},
		}
	}); 
	//成立日期组件
	$('#classInfo_bornDateDiv').datetimepicker({
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
		$('#classInfoAddForm').data('bootstrapValidator').updateStatus('classInfo.bornDate', 'NOT_VALIDATED',null).validateField('classInfo.bornDate');
	});
})
</script>
</body>
</html>
