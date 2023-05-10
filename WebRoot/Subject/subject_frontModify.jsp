<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Subject" %>
<%@ page import="com.chengxusheji.po.SubjectType" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的subjectTypeObj信息
    List<SubjectType> subjectTypeList = (List<SubjectType>)request.getAttribute("subjectTypeList");
    //获取所有的teacherObj信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    Subject subject = (Subject)request.getAttribute("subject");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改论文题目信息</TITLE>
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
  		<li class="active">论文题目信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="subjectEditForm" id="subjectEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="subject_subjectId_edit" class="col-md-3 text-right">题目id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="subject_subjectId_edit" name="subject.subjectId" class="form-control" placeholder="请输入题目id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="subject_subjectName_edit" class="col-md-3 text-right">题目名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="subject_subjectName_edit" name="subject.subjectName" class="form-control" placeholder="请输入题目名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subject_subjectTypeObj_typeId_edit" class="col-md-3 text-right">题目类型:</label>
		  	 <div class="col-md-9">
			    <select id="subject_subjectTypeObj_typeId_edit" name="subject.subjectTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subject_sujectContent_edit" class="col-md-3 text-right">题目内容:</label>
		  	 <div class="col-md-9">
			    <script name="subject.sujectContent" id="subject_sujectContent_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subject_taskFile_edit" class="col-md-3 text-right">任务书文件:</label>
		  	 <div class="col-md-9">
			    <a id="subject_taskFileImg" width="200px" border="0px"></a><br/>
			    <input type="hidden" id="subject_taskFile" name="subject.taskFile"/>
			    <input id="taskFileFile" name="taskFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subject_otherFile_edit" class="col-md-3 text-right">其他资料文件:</label>
		  	 <div class="col-md-9">
			    <a id="subject_otherFileImg" width="200px" border="0px"></a><br/>
			    <input type="hidden" id="subject_otherFile" name="subject.otherFile"/>
			    <input id="otherFileFile" name="otherFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subject_personNum_edit" class="col-md-3 text-right">限选人数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="subject_personNum_edit" name="subject.personNum" class="form-control" placeholder="请输入限选人数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subject_teacherObj_teacherNo_edit" class="col-md-3 text-right">指导老师:</label>
		  	 <div class="col-md-9">
			    <select id="subject_teacherObj_teacherNo_edit" name="subject.teacherObj.teacherNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subject_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date subject_addTime_edit col-md-12" data-link-field="subject_addTime_edit">
                    <input class="form-control" id="subject_addTime_edit" name="subject.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSubjectModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#subjectEditForm .form-group {margin-bottom:5px;}  </style>
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
var subject_sujectContent_editor = UE.getEditor('subject_sujectContent_edit'); //题目内容编辑框
var basePath = "<%=basePath%>";
/*弹出修改论文题目界面并初始化数据*/
function subjectEdit(subjectId) {
  subject_sujectContent_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(subjectId);
  });
}
 function ajaxModifyQuery(subjectId) {
	$.ajax({
		url :  basePath + "Subject/" + subjectId + "/update",
		type : "get",
		dataType: "json",
		success : function (subject, response, status) {
			if (subject) {
				$("#subject_subjectId_edit").val(subject.subjectId);
				$("#subject_subjectName_edit").val(subject.subjectName);
				$.ajax({
					url: basePath + "SubjectType/listAll",
					type: "get",
					success: function(subjectTypes,response,status) { 
						$("#subject_subjectTypeObj_typeId_edit").empty();
						var html="";
		        		$(subjectTypes).each(function(i,subjectType){
		        			html += "<option value='" + subjectType.typeId + "'>" + subjectType.typeName + "</option>";
		        		});
		        		$("#subject_subjectTypeObj_typeId_edit").html(html);
		        		$("#subject_subjectTypeObj_typeId_edit").val(subject.subjectTypeObjPri);
					}
				});
				subject_sujectContent_editor.setContent(subject.sujectContent, false);
				$("#subject_taskFileA").val(subject.taskFile);
				$("#subject_taskFileA").attr("href", basePath +　subject.taskFile);
				$("#subject_otherFileA").val(subject.otherFile);
				$("#subject_otherFileA").attr("href", basePath +　subject.otherFile);
				$("#subject_personNum_edit").val(subject.personNum);
				$.ajax({
					url: basePath + "Teacher/listAll",
					type: "get",
					success: function(teachers,response,status) { 
						$("#subject_teacherObj_teacherNo_edit").empty();
						var html="";
		        		$(teachers).each(function(i,teacher){
		        			html += "<option value='" + teacher.teacherNo + "'>" + teacher.teacherName + "</option>";
		        		});
		        		$("#subject_teacherObj_teacherNo_edit").html(html);
		        		$("#subject_teacherObj_teacherNo_edit").val(subject.teacherObjPri);
					}
				});
				$("#subject_addTime_edit").val(subject.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交论文题目信息表单给服务器端修改*/
function ajaxSubjectModify() {
	$.ajax({
		url :  basePath + "Subject/" + $("#subject_subjectId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#subjectEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#subjectQueryForm").submit();
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
    /*发布时间组件*/
    $('.subject_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    subjectEdit("<%=request.getParameter("subjectId")%>");
 })
 </script> 
</body>
</html>

