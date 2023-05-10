<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Teacher" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Teacher teacher = (Teacher)request.getAttribute("teacher");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改教师信息</TITLE>
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
  		<li class="active">教师信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="teacherEditForm" id="teacherEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="teacher_teacherNo_edit" class="col-md-3 text-right">教师编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="teacher_teacherNo_edit" name="teacher.teacherNo" class="form-control" placeholder="请输入教师编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="teacher_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_password_edit" name="teacher.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherName_edit" class="col-md-3 text-right">教师姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_teacherName_edit" name="teacher.teacherName" class="form-control" placeholder="请输入教师姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherSex_edit" class="col-md-3 text-right">教师性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_teacherSex_edit" name="teacher.teacherSex" class="form-control" placeholder="请输入教师性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_birthDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date teacher_birthDate_edit col-md-12" data-link-field="teacher_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="teacher_birthDate_edit" name="teacher.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherPhoto_edit" class="col-md-3 text-right">教师照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="teacher_teacherPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="teacher_teacherPhoto" name="teacher.teacherPhoto"/>
			    <input id="teacherPhotoFile" name="teacherPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_zhicheng_edit" class="col-md-3 text-right">教师职称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_zhicheng_edit" name="teacher.zhicheng" class="form-control" placeholder="请输入教师职称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_telephone_edit" name="teacher.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherDesc_edit" class="col-md-3 text-right">教师介绍:</label>
		  	 <div class="col-md-9">
			    <script name="teacher.teacherDesc" id="teacher_teacherDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxTeacherModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#teacherEditForm .form-group {margin-bottom:5px;}  </style>
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
var teacher_teacherDesc_editor = UE.getEditor('teacher_teacherDesc_edit'); //教师介绍编辑框
var basePath = "<%=basePath%>";
/*弹出修改教师界面并初始化数据*/
function teacherEdit(teacherNo) {
  teacher_teacherDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(teacherNo);
  });
}
 function ajaxModifyQuery(teacherNo) {
	$.ajax({
		url :  basePath + "Teacher/" + teacherNo + "/update",
		type : "get",
		dataType: "json",
		success : function (teacher, response, status) {
			if (teacher) {
				$("#teacher_teacherNo_edit").val(teacher.teacherNo);
				$("#teacher_password_edit").val(teacher.password);
				$("#teacher_teacherName_edit").val(teacher.teacherName);
				$("#teacher_teacherSex_edit").val(teacher.teacherSex);
				$("#teacher_birthDate_edit").val(teacher.birthDate);
				$("#teacher_teacherPhoto").val(teacher.teacherPhoto);
				$("#teacher_teacherPhotoImg").attr("src", basePath +　teacher.teacherPhoto);
				$("#teacher_zhicheng_edit").val(teacher.zhicheng);
				$("#teacher_telephone_edit").val(teacher.telephone);
				teacher_teacherDesc_editor.setContent(teacher.teacherDesc, false);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交教师信息表单给服务器端修改*/
function ajaxTeacherModify() {
	$.ajax({
		url :  basePath + "Teacher/" + $("#teacher_teacherNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#teacherEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#teacherQueryForm").submit();
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
    /*出生日期组件*/
    $('.teacher_birthDate_edit').datetimepicker({
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
    teacherEdit("<%=request.getParameter("teacherNo")%>");
 })
 </script> 
</body>
</html>

