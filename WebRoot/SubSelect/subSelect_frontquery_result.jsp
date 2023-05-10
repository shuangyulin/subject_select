<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SubSelect" %>
<%@ page import="com.chengxusheji.po.Subject" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<SubSelect> subSelectList = (List<SubSelect>)request.getAttribute("subSelectList");
    //获取所有的subjectObj信息
    List<Subject> subjectList = (List<Subject>)request.getAttribute("subjectList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Subject subjectObj = (Subject)request.getAttribute("subjectObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String selectTime = (String)request.getAttribute("selectTime"); //选题时间查询关键字
    String shenHeState = (String)request.getAttribute("shenHeState"); //审核状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>学生选题查询</title>
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
			    	<li role="presentation" class="active"><a href="#subSelectListPanel" aria-controls="subSelectListPanel" role="tab" data-toggle="tab">学生选题列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>SubSelect/subSelect_frontAdd.jsp" style="display:none;">添加学生选题</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="subSelectListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>选题id</td><td>论文题目</td><td>选题学生</td><td>选题时间</td><td>审核状态</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<subSelectList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		SubSelect subSelect = subSelectList.get(i); //获取到学生选题对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=subSelect.getSelectId() %></td>
 											<td><%=subSelect.getSubjectObj().getSubjectName() %></td>
 											<td><%=subSelect.getUserObj().getName() %></td>
 											<td><%=subSelect.getSelectTime() %></td>
 											<td><%=subSelect.getShenHeState() %></td>
 											<td>
 												<a href="<%=basePath  %>SubSelect/<%=subSelect.getSelectId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="subSelectEdit('<%=subSelect.getSelectId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="subSelectDelete('<%=subSelect.getSelectId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>学生选题查询</h1>
		</div>
		<form name="subSelectQueryForm" id="subSelectQueryForm" action="<%=basePath %>SubSelect/frontlist" class="mar_t15" method="post">
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
            	<label for="userObj_user_name">选题学生：</label>
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
				<label for="selectTime">选题时间:</label>
				<input type="text" id="selectTime" name="selectTime" class="form-control"  placeholder="请选择选题时间" value="<%=selectTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="shenHeState">审核状态:</label>
				<input type="text" id="shenHeState" name="shenHeState" value="<%=shenHeState %>" class="form-control" placeholder="请输入审核状态">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="subSelectEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;学生选题信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#subSelectEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSubSelectModify();">提交</button>
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
    document.subSelectQueryForm.currentPage.value = currentPage;
    document.subSelectQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.subSelectQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.subSelectQueryForm.currentPage.value = pageValue;
    documentsubSelectQueryForm.submit();
}

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
				$('#subSelectEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除学生选题信息*/
function subSelectDelete(selectId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "SubSelect/deletes",
			data : {
				selectIds : selectId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#subSelectQueryForm").submit();
					//location.href= basePath + "SubSelect/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

