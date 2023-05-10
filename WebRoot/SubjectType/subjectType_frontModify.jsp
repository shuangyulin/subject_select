<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SubjectType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    SubjectType subjectType = (SubjectType)request.getAttribute("subjectType");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改题目类型信息</TITLE>
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
  		<li class="active">题目类型信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="subjectTypeEditForm" id="subjectTypeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="subjectType_typeId_edit" class="col-md-3 text-right">类型编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="subjectType_typeId_edit" name="subjectType.typeId" class="form-control" placeholder="请输入类型编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="subjectType_typeName_edit" class="col-md-3 text-right">类型名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="subjectType_typeName_edit" name="subjectType.typeName" class="form-control" placeholder="请输入类型名称">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSubjectTypeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#subjectTypeEditForm .form-group {margin-bottom:5px;}  </style>
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
<script>
var basePath = "<%=basePath%>";
/*弹出修改题目类型界面并初始化数据*/
function subjectTypeEdit(typeId) {
	$.ajax({
		url :  basePath + "SubjectType/" + typeId + "/update",
		type : "get",
		dataType: "json",
		success : function (subjectType, response, status) {
			if (subjectType) {
				$("#subjectType_typeId_edit").val(subjectType.typeId);
				$("#subjectType_typeName_edit").val(subjectType.typeName);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交题目类型信息表单给服务器端修改*/
function ajaxSubjectTypeModify() {
	$.ajax({
		url :  basePath + "SubjectType/" + $("#subjectType_typeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#subjectTypeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "SubjectType/frontlist";
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
    subjectTypeEdit("<%=request.getParameter("typeId")%>");
 })
 </script> 
</body>
</html>

