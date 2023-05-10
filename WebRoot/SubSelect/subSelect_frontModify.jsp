<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SubSelect" %>
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
    SubSelect subSelect = (SubSelect)request.getAttribute("subSelect");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改学生选题信息</TITLE>
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
  		<li class="active">学生选题信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="subSelectEditForm" id="subSelectEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="subSelect_selectId_edit" class="col-md-3 text-right">选题id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="subSelect_selectId_edit" name="subSelect.selectId" class="form-control" placeholder="请输入选题id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="subSelect_subjectObj_subjectId_edit" class="col-md-3 text-right">论文题目:</label>
		  	 <div class="col-md-9">
			    <select id="subSelect_subjectObj_subjectId_edit" name="subSelect.subjectObj.subjectId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subSelect_userObj_user_name_edit" class="col-md-3 text-right">选题学生:</label>
		  	 <div class="col-md-9">
			    <select id="subSelect_userObj_user_name_edit" name="subSelect.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subSelect_selectTime_edit" class="col-md-3 text-right">选题时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date subSelect_selectTime_edit col-md-12" data-link-field="subSelect_selectTime_edit">
                    <input class="form-control" id="subSelect_selectTime_edit" name="subSelect.selectTime" size="16" type="text" value="" placeholder="请选择选题时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subSelect_shenHeState_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="subSelect_shenHeState_edit" name="subSelect.shenHeState" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSubSelectModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#subSelectEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改学生选题界面并初始化数据*/
function subSelectEdit(selectId) {
	$.ajax({
		url :  basePath + "SubSelect/" + selectId + "/update",
		type : "get",
		dataType: "json",
		success : function (subSelect, response, status) {
			if (subSelect) {
				$("#subSelect_selectId_edit").val(subSelect.selectId);
				$.ajax({
					url: basePath + "Subject/listAll",
					type: "get",
					success: function(subjects,response,status) { 
						$("#subSelect_subjectObj_subjectId_edit").empty();
						var html="";
		        		$(subjects).each(function(i,subject){
		        			html += "<option value='" + subject.subjectId + "'>" + subject.subjectName + "</option>";
		        		});
		        		$("#subSelect_subjectObj_subjectId_edit").html(html);
		        		$("#subSelect_subjectObj_subjectId_edit").val(subSelect.subjectObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#subSelect_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#subSelect_userObj_user_name_edit").html(html);
		        		$("#subSelect_userObj_user_name_edit").val(subSelect.userObjPri);
					}
				});
				$("#subSelect_selectTime_edit").val(subSelect.selectTime);
				$("#subSelect_shenHeState_edit").val(subSelect.shenHeState);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交学生选题信息表单给服务器端修改*/
function ajaxSubSelectModify() {
	$.ajax({
		url :  basePath + "SubSelect/" + $("#subSelect_selectId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#subSelectEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#subSelectQueryForm").submit();
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
    /*选题时间组件*/
    $('.subSelect_selectTime_edit').datetimepicker({
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
    subSelectEdit("<%=request.getParameter("selectId")%>");
 })
 </script> 
</body>
</html>

