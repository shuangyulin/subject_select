<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Opus" %>
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
    Opus opus = (Opus)request.getAttribute("opus");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改学生成果信息</TITLE>
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
  		<li class="active">学生成果信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="opusEditForm" id="opusEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="opus_opusId_edit" class="col-md-3 text-right">成果id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="opus_opusId_edit" name="opus.opusId" class="form-control" placeholder="请输入成果id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="opus_subjectObj_subjectId_edit" class="col-md-3 text-right">论文题目:</label>
		  	 <div class="col-md-9">
			    <select id="opus_subjectObj_subjectId_edit" name="opus.subjectObj.subjectId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_userObj_user_name_edit" class="col-md-3 text-right">提交学生:</label>
		  	 <div class="col-md-9">
			    <select id="opus_userObj_user_name_edit" name="opus.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_ktbg_edit" class="col-md-3 text-right">开题报告:</label>
		  	 <div class="col-md-9">
			    <a id="opus_ktbgImg" width="200px" border="0px"></a><br/>
			    <input type="hidden" id="opus_ktbg" name="opus.ktbg"/>
			    <input id="ktbgFile" name="ktbgFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_wwwx_edit" class="col-md-3 text-right">外文文献翻译:</label>
		  	 <div class="col-md-9">
			    <a id="opus_wwwxImg" width="200px" border="0px"></a><br/>
			    <input type="hidden" id="opus_wwwx" name="opus.wwwx"/>
			    <input id="wwwxFile" name="wwwxFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_lwcg_edit" class="col-md-3 text-right">论文初稿:</label>
		  	 <div class="col-md-9">
			    <a id="opus_lwcgImg" width="200px" border="0px"></a><br/>
			    <input type="hidden" id="opus_lwcg" name="opus.lwcg"/>
			    <input id="lwcgFile" name="lwcgFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_lwzg_edit" class="col-md-3 text-right">论文终稿:</label>
		  	 <div class="col-md-9">
			    <a id="opus_lwzgImg" width="200px" border="0px"></a><br/>
			    <input type="hidden" id="opus_lwzg" name="opus.lwzg"/>
			    <input id="lwzgFile" name="lwzgFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_otherFile_edit" class="col-md-3 text-right">其他文件:</label>
		  	 <div class="col-md-9">
			    <a id="opus_otherFileImg" width="200px" border="0px"></a><br/>
			    <input type="hidden" id="opus_otherFile" name="opus.otherFile"/>
			    <input id="otherFileFile" name="otherFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_chengji_edit" class="col-md-3 text-right">论文成绩:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="opus_chengji_edit" name="opus.chengji" class="form-control" placeholder="请输入论文成绩">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_evaluate_edit" class="col-md-3 text-right">老师评价:</label>
		  	 <div class="col-md-9">
			    <textarea id="opus_evaluate_edit" name="opus.evaluate" rows="8" class="form-control" placeholder="请输入老师评价"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxOpusModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#opusEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改学生成果界面并初始化数据*/
function opusEdit(opusId) {
	$.ajax({
		url :  basePath + "Opus/" + opusId + "/update",
		type : "get",
		dataType: "json",
		success : function (opus, response, status) {
			if (opus) {
				$("#opus_opusId_edit").val(opus.opusId);
				$.ajax({
					url: basePath + "Subject/listAll",
					type: "get",
					success: function(subjects,response,status) { 
						$("#opus_subjectObj_subjectId_edit").empty();
						var html="";
		        		$(subjects).each(function(i,subject){
		        			html += "<option value='" + subject.subjectId + "'>" + subject.subjectName + "</option>";
		        		});
		        		$("#opus_subjectObj_subjectId_edit").html(html);
		        		$("#opus_subjectObj_subjectId_edit").val(opus.subjectObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#opus_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#opus_userObj_user_name_edit").html(html);
		        		$("#opus_userObj_user_name_edit").val(opus.userObjPri);
					}
				});
				$("#opus_ktbgA").val(opus.ktbg);
				$("#opus_ktbgA").attr("href", basePath +　opus.ktbg);
				$("#opus_wwwxA").val(opus.wwwx);
				$("#opus_wwwxA").attr("href", basePath +　opus.wwwx);
				$("#opus_lwcgA").val(opus.lwcg);
				$("#opus_lwcgA").attr("href", basePath +　opus.lwcg);
				$("#opus_lwzgA").val(opus.lwzg);
				$("#opus_lwzgA").attr("href", basePath +　opus.lwzg);
				$("#opus_otherFileA").val(opus.otherFile);
				$("#opus_otherFileA").attr("href", basePath +　opus.otherFile);
				$("#opus_chengji_edit").val(opus.chengji);
				$("#opus_evaluate_edit").val(opus.evaluate);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交学生成果信息表单给服务器端修改*/
function ajaxOpusModify() {
	$.ajax({
		url :  basePath + "Opus/" + $("#opus_opusId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#opusEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#opusQueryForm").submit();
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
    opusEdit("<%=request.getParameter("opusId")%>");
 })
 </script> 
</body>
</html>

