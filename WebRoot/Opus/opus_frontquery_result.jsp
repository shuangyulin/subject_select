<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Opus" %>
<%@ page import="com.chengxusheji.po.Subject" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Opus> opusList = (List<Opus>)request.getAttribute("opusList");
    //获取所有的subjectObj信息
    List<Subject> subjectList = (List<Subject>)request.getAttribute("subjectList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Subject subjectObj = (Subject)request.getAttribute("subjectObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>学生成果查询</title>
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
			    	<li role="presentation" class="active"><a href="#opusListPanel" aria-controls="opusListPanel" role="tab" data-toggle="tab">学生成果列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Opus/opus_frontAdd.jsp" style="display:none;">添加学生成果</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="opusListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>成果id</td><td>论文题目</td><td>提交学生</td><td>开题报告</td><td>外文文献翻译</td><td>论文初稿</td><td>论文终稿</td><td>其他文件</td><td>论文成绩</td><td>老师评价</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<opusList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Opus opus = opusList.get(i); //获取到学生成果对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=opus.getOpusId() %></td>
 											<td><%=opus.getSubjectObj().getSubjectName() %></td>
 											<td><%=opus.getUserObj().getName() %></td>
 											<td><%=opus.getKtbg().equals("")?"暂无文件":"<a href='" + basePath + opus.getKtbg() + "' target='_blank'>" + opus.getKtbg() + "</a>"%>
 											<td><%=opus.getWwwx().equals("")?"暂无文件":"<a href='" + basePath + opus.getWwwx() + "' target='_blank'>" + opus.getWwwx() + "</a>"%>
 											<td><%=opus.getLwcg().equals("")?"暂无文件":"<a href='" + basePath + opus.getLwcg() + "' target='_blank'>" + opus.getLwcg() + "</a>"%>
 											<td><%=opus.getLwzg().equals("")?"暂无文件":"<a href='" + basePath + opus.getLwzg() + "' target='_blank'>" + opus.getLwzg() + "</a>"%>
 											<td><%=opus.getOtherFile().equals("")?"暂无文件":"<a href='" + basePath + opus.getOtherFile() + "' target='_blank'>" + opus.getOtherFile() + "</a>"%>
 											<td><%=opus.getChengji() %></td>
 											<td><%=opus.getEvaluate() %></td>
 											<td>
 												<a href="<%=basePath  %>Opus/<%=opus.getOpusId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="opusEdit('<%=opus.getOpusId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="opusDelete('<%=opus.getOpusId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>学生成果查询</h1>
		</div>
		<form name="opusQueryForm" id="opusQueryForm" action="<%=basePath %>Opus/frontlist" class="mar_t15" method="post">
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
            	<label for="userObj_user_name">提交学生：</label>
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
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="opusEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;学生成果信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			    <a id="opus_ktbgA" target="_blank"></a><br/>
			    <input type="hidden" id="opus_ktbg" name="opus.ktbg"/>
			    <input id="ktbgFile" name="ktbgFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_wwwx_edit" class="col-md-3 text-right">外文文献翻译:</label>
		  	 <div class="col-md-9">
			    <a id="opus_wwwxA" target="_blank"></a><br/>
			    <input type="hidden" id="opus_wwwx" name="opus.wwwx"/>
			    <input id="wwwxFile" name="wwwxFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_lwcg_edit" class="col-md-3 text-right">论文初稿:</label>
		  	 <div class="col-md-9">
			    <a id="opus_lwcgA" target="_blank"></a><br/>
			    <input type="hidden" id="opus_lwcg" name="opus.lwcg"/>
			    <input id="lwcgFile" name="lwcgFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_lwzg_edit" class="col-md-3 text-right">论文终稿:</label>
		  	 <div class="col-md-9">
			    <a id="opus_lwzgA" target="_blank"></a><br/>
			    <input type="hidden" id="opus_lwzg" name="opus.lwzg"/>
			    <input id="lwzgFile" name="lwzgFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="opus_otherFile_edit" class="col-md-3 text-right">其他文件:</label>
		  	 <div class="col-md-9">
			    <a id="opus_otherFileA" target="_blank"></a><br/>
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
		</form> 
	    <style>#opusEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxOpusModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.opusQueryForm.currentPage.value = currentPage;
    document.opusQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.opusQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.opusQueryForm.currentPage.value = pageValue;
    documentopusQueryForm.submit();
}

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
				$("#opus_ktbg").val(opus.ktbg);
				$("#opus_ktbgA").text(opus.ktbg);
				$("#opus_ktbgA").attr("href", basePath +　opus.ktbg);
				$("#opus_wwwx").val(opus.wwwx);
				$("#opus_wwwxA").text(opus.wwwx);
				$("#opus_wwwxA").attr("href", basePath +　opus.wwwx);
				$("#opus_lwcg").val(opus.lwcg);
				$("#opus_lwcgA").text(opus.lwcg);
				$("#opus_lwcgA").attr("href", basePath +　opus.lwcg);
				$("#opus_lwzg").val(opus.lwzg);
				$("#opus_lwzgA").text(opus.lwzg);
				$("#opus_lwzgA").attr("href", basePath +　opus.lwzg);
				$("#opus_otherFile").val(opus.otherFile);
				$("#opus_otherFileA").text(opus.otherFile);
				$("#opus_otherFileA").attr("href", basePath +　opus.otherFile);
				$("#opus_chengji_edit").val(opus.chengji);
				$("#opus_evaluate_edit").val(opus.evaluate);
				$('#opusEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除学生成果信息*/
function opusDelete(opusId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Opus/deletes",
			data : {
				opusIds : opusId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#opusQueryForm").submit();
					//location.href= basePath + "Opus/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

