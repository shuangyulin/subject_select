<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SubjectType" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
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
<title>论文题目添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Subject/frontlist">论文题目列表</a></li>
			    	<li role="presentation" class="active"><a href="#subjectAdd" aria-controls="subjectAdd" role="tab" data-toggle="tab">添加论文题目</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="subjectList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="subjectAdd"> 
				      	<form class="form-horizontal" name="subjectAddForm" id="subjectAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="subject_subjectName" class="col-md-2 text-right">题目名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="subject_subjectName" name="subject.subjectName" class="form-control" placeholder="请输入题目名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="subject_subjectTypeObj_typeId" class="col-md-2 text-right">题目类型:</label>
						  	 <div class="col-md-8">
							    <select id="subject_subjectTypeObj_typeId" name="subject.subjectTypeObj.typeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="subject_sujectContent" class="col-md-2 text-right">题目内容:</label>
						  	 <div class="col-md-8">
							    <textarea name="subject.sujectContent" id="subject_sujectContent" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="subject_taskFile" class="col-md-2 text-right">任务书文件:</label>
						  	 <div class="col-md-8">
							    <a id="subject_taskFileImg" border="0px"></a><br/>
							    <input type="hidden" id="subject_taskFile" name="subject.taskFile"/>
							    <input id="taskFileFile" name="taskFileFile" type="file" size="50" />
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="subject_otherFile" class="col-md-2 text-right">其他资料文件:</label>
						  	 <div class="col-md-8">
							    <a id="subject_otherFileImg" border="0px"></a><br/>
							    <input type="hidden" id="subject_otherFile" name="subject.otherFile"/>
							    <input id="otherFileFile" name="otherFileFile" type="file" size="50" />
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="subject_personNum" class="col-md-2 text-right">限选人数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="subject_personNum" name="subject.personNum" class="form-control" placeholder="请输入限选人数">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="subject_teacherObj_teacherNo" class="col-md-2 text-right">指导老师:</label>
						  	 <div class="col-md-8">
							    <select id="subject_teacherObj_teacherNo" name="subject.teacherObj.teacherNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="subject_addTimeDiv" class="col-md-2 text-right">发布时间:</label>
						  	 <div class="col-md-8">
				                <div id="subject_addTimeDiv" class="input-group date subject_addTime col-md-12" data-link-field="subject_addTime">
				                    <input class="form-control" id="subject_addTime" name="subject.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxSubjectAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#subjectAddForm .form-group {margin:10px;}  </style>
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
var subject_sujectContent_editor = UE.getEditor('subject_sujectContent'); //题目内容编辑器
var basePath = "<%=basePath%>";
	//提交添加论文题目信息
	function ajaxSubjectAdd() { 
		//提交之前先验证表单
		$("#subjectAddForm").data('bootstrapValidator').validate();
		if(!$("#subjectAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(subject_sujectContent_editor.getContent() == "") {
			alert('题目内容不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Subject/add",
			dataType : "json" , 
			data: new FormData($("#subjectAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#subjectAddForm").find("input").val("");
					$("#subjectAddForm").find("textarea").val("");
					subject_sujectContent_editor.setContent("");
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
	//验证论文题目添加表单字段
	$('#subjectAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"subject.subjectName": {
				validators: {
					notEmpty: {
						message: "题目名称不能为空",
					}
				}
			},
			"subject.personNum": {
				validators: {
					notEmpty: {
						message: "限选人数不能为空",
					},
					integer: {
						message: "限选人数不正确"
					}
				}
			},
			"subject.addTime": {
				validators: {
					notEmpty: {
						message: "发布时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化题目类型下拉框值 
	$.ajax({
		url: basePath + "SubjectType/listAll",
		type: "get",
		success: function(subjectTypes,response,status) { 
			$("#subject_subjectTypeObj_typeId").empty();
			var html="";
    		$(subjectTypes).each(function(i,subjectType){
    			html += "<option value='" + subjectType.typeId + "'>" + subjectType.typeName + "</option>";
    		});
    		$("#subject_subjectTypeObj_typeId").html(html);
    	}
	});
	//初始化指导老师下拉框值 
	$.ajax({
		url: basePath + "Teacher/listAll",
		type: "get",
		success: function(teachers,response,status) { 
			$("#subject_teacherObj_teacherNo").empty();
			var html="";
    		$(teachers).each(function(i,teacher){
    			html += "<option value='" + teacher.teacherNo + "'>" + teacher.teacherName + "</option>";
    		});
    		$("#subject_teacherObj_teacherNo").html(html);
    	}
	});
	//发布时间组件
	$('#subject_addTimeDiv').datetimepicker({
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
		$('#subjectAddForm').data('bootstrapValidator').updateStatus('subject.addTime', 'NOT_VALIDATED',null).validateField('subject.addTime');
	});
})
</script>
</body>
</html>
