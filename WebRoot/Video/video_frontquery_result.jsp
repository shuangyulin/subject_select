<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Video" %>
<%@ page import="com.chengxusheji.po.Subject" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Video> videoList = (List<Video>)request.getAttribute("videoList");
    //获取所有的subjectObj信息
    List<Subject> subjectList = (List<Subject>)request.getAttribute("subjectList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Subject subjectObj = (Subject)request.getAttribute("subjectObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String videoDate = (String)request.getAttribute("videoDate"); //答辩日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>答辩视频查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#videoListPanel" aria-controls="videoListPanel" role="tab" data-toggle="tab">答辩视频列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Video/video_frontAdd.jsp" style="display:none;">添加答辩视频</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="videoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>视频id</td><td>论文题目</td><td>答辩学生</td><td>答辩视频</td><td>视频时间</td><td>答辩日期</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<videoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Video video = videoList.get(i); //获取到答辩视频对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=video.getVideoId() %></td>
 											<td><%=video.getSubjectObj().getSubjectName() %></td>
 											<td><%=video.getUserObj().getName() %></td>
 											<td><%=video.getVideoFile().equals("")?"暂无文件":"<a href='" + basePath + video.getVideoFile() + "' target='_blank'>" + video.getVideoFile() + "</a>"%>
 											<td><%=video.getVideoTime() %></td>
 											<td><%=video.getVideoDate() %></td>
 											<td>
 												<a href="<%=basePath  %>Video/<%=video.getVideoId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="videoEdit('<%=video.getVideoId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="videoDelete('<%=video.getVideoId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>答辩视频查询</h1>
		</div>
		<form name="videoQueryForm" id="videoQueryForm" action="<%=basePath %>Video/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="subjectObj_subjectId">论文题目：</label>
                <select id="subjectObj_subjectId" name="subjectObj.subjectId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Subject subjectTemp:subjectList) {
	 					String selected = "";
 					if(subjectObj!=null && subjectObj.getSubjectId()!=null && subjectObj.getSubjectId().intValue()==subjectTemp.getSubjectId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=subjectTemp.getSubjectId() %>" <%=selected %>><%=subjectTemp.getSubjectName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">答辩学生：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="videoDate">答辩日期:</label>
				<input type="text" id="videoDate" name="videoDate" class="form-control"  placeholder="请选择答辩日期" value="<%=videoDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="videoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;答辩视频信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="videoEditForm" id="videoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="video_videoId_edit" class="col-md-3 text-right">视频id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="video_videoId_edit" name="video.videoId" class="form-control" placeholder="请输入视频id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="video_subjectObj_subjectId_edit" class="col-md-3 text-right">论文题目:</label>
		  	 <div class="col-md-9">
			    <select id="video_subjectObj_subjectId_edit" name="video.subjectObj.subjectId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_userObj_user_name_edit" class="col-md-3 text-right">答辩学生:</label>
		  	 <div class="col-md-9">
			    <select id="video_userObj_user_name_edit" name="video.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoFile_edit" class="col-md-3 text-right">答辩视频:</label>
		  	 <div class="col-md-9">
			    <a id="video_videoFileA" target="_blank"></a><br/>
			    <input type="hidden" id="video_videoFile" name="video.videoFile"/>
			    <input id="videoFileFile" name="videoFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoTime_edit" class="col-md-3 text-right">视频时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="video_videoTime_edit" name="video.videoTime" class="form-control" placeholder="请输入视频时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoDate_edit" class="col-md-3 text-right">答辩日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date video_videoDate_edit col-md-12" data-link-field="video_videoDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="video_videoDate_edit" name="video.videoDate" size="16" type="text" value="" placeholder="请选择答辩日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			 	<textarea name="video.videoMemo" id="video_videoMemo_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#videoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxVideoModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
//实例化编辑器
var video_videoMemo_edit = UE.getEditor('video_videoMemo_edit'); //附加信息编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.videoQueryForm.currentPage.value = currentPage;
    document.videoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.videoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.videoQueryForm.currentPage.value = pageValue;
    documentvideoQueryForm.submit();
}

/*弹出修改答辩视频界面并初始化数据*/
function videoEdit(videoId) {
	$.ajax({
		url :  basePath + "Video/" + videoId + "/update",
		type : "get",
		dataType: "json",
		success : function (video, response, status) {
			if (video) {
				$("#video_videoId_edit").val(video.videoId);
				$.ajax({
					url: basePath + "Subject/listAll",
					type: "get",
					success: function(subjects,response,status) { 
						$("#video_subjectObj_subjectId_edit").empty();
						var html="";
		        		$(subjects).each(function(i,subject){
		        			html += "<option value='" + subject.subjectId + "'>" + subject.subjectName + "</option>";
		        		});
		        		$("#video_subjectObj_subjectId_edit").html(html);
		        		$("#video_subjectObj_subjectId_edit").val(video.subjectObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#video_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#video_userObj_user_name_edit").html(html);
		        		$("#video_userObj_user_name_edit").val(video.userObjPri);
					}
				});
				$("#video_videoFile").val(video.videoFile);
				$("#video_videoFileA").text(video.videoFile);
				$("#video_videoFileA").attr("href", basePath +　video.videoFile);
				$("#video_videoTime_edit").val(video.videoTime);
				$("#video_videoDate_edit").val(video.videoDate);
				video_videoMemo_edit.setContent(video.videoMemo, false);
				$('#videoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除答辩视频信息*/
function videoDelete(videoId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Video/deletes",
			data : {
				videoIds : videoId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#videoQueryForm").submit();
					//location.href= basePath + "Video/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交答辩视频信息表单给服务器端修改*/
function ajaxVideoModify() {
	$.ajax({
		url :  basePath + "Video/" + $("#video_videoId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#videoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#videoQueryForm").submit();
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

    /*答辩日期组件*/
    $('.video_videoDate_edit').datetimepicker({
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
})
</script>
</body>
</html>

