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
  <TITLE>查看学生成果详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Opus/frontlist">学生成果信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">成果id:</div>
		<div class="col-md-10 col-xs-6"><%=opus.getOpusId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">论文题目:</div>
		<div class="col-md-10 col-xs-6"><%=opus.getSubjectObj().getSubjectName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">提交学生:</div>
		<div class="col-md-10 col-xs-6"><%=opus.getUserObj().getName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">开题报告:</div>
		<div class="col-md-10 col-xs-6"><a href="<%=basePath%><%=opus.getKtbg()%>" target="_blank"><%=opus.getKtbg()%></a></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">外文文献翻译:</div>
		<div class="col-md-10 col-xs-6"><a href="<%=basePath%><%=opus.getWwwx()%>" target="_blank"><%=opus.getWwwx()%></a></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">论文初稿:</div>
		<div class="col-md-10 col-xs-6"><a href="<%=basePath%><%=opus.getLwcg()%>" target="_blank"><%=opus.getLwcg()%></a></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">论文终稿:</div>
		<div class="col-md-10 col-xs-6"><a href="<%=basePath%><%=opus.getLwzg()%>" target="_blank"><%=opus.getLwzg()%></a></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">其他文件:</div>
		<div class="col-md-10 col-xs-6"><a href="<%=basePath%><%=opus.getOtherFile()%>" target="_blank"><%=opus.getOtherFile()%></a></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">论文成绩:</div>
		<div class="col-md-10 col-xs-6"><%=opus.getChengji()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">老师评价:</div>
		<div class="col-md-10 col-xs-6"><%=opus.getEvaluate()%></div>
	</div>
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="history.back();" class="btn btn-primary">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 </script> 
</body>
</html>

