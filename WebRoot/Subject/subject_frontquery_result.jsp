<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Subject" %>
<%@ page import="com.chengxusheji.po.SubjectType" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Subject> subjectList = (List<Subject>)request.getAttribute("subjectList");
    //获取所有的subjectTypeObj信息
    List<SubjectType> subjectTypeList = (List<SubjectType>)request.getAttribute("subjectTypeList");
    //获取所有的teacherObj信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String subjectName = (String)request.getAttribute("subjectName"); //题目名称查询关键字
    SubjectType subjectTypeObj = (SubjectType)request.getAttribute("subjectTypeObj");
    Teacher teacherObj = (Teacher)request.getAttribute("teacherObj");
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>论文题目查询</title>
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
			    	<li role="presentation" class="active"><a href="#subjectListPanel" aria-controls="subjectListPanel" role="tab" data-toggle="tab">论文题目列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Subject/subject_frontAdd.jsp" style="display:none;">添加论文题目</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="subjectListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>题目id</td><td>题目名称</td><td>题目类型</td><td>任务书文件</td><td>其他资料文件</td><td>限选人数</td><td>指导老师</td><td>发布时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<subjectList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Subject subject = subjectList.get(i); //获取到论文题目对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=subject.getSubjectId() %></td>
 											<td><%=subject.getSubjectName() %></td>
 											<td><%=subject.getSubjectTypeObj().getTypeName() %></td>
 											<td><%=subject.getTaskFile().equals("")?"暂无文件":"<a href='" + basePath + subject.getTaskFile() + "' target='_blank'>" + subject.getTaskFile() + "</a>"%>
 											<td><%=subject.getOtherFile().equals("")?"暂无文件":"<a href='" + basePath + subject.getOtherFile() + "' target='_blank'>" + subject.getOtherFile() + "</a>"%>
 											<td><%=subject.getPersonNum() %></td>
 											<td><%=subject.getTeacherObj().getTeacherName() %></td>
 											<td><%=subject.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Subject/<%=subject.getSubjectId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="subjectEdit('<%=subject.getSubjectId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="subjectDelete('<%=subject.getSubjectId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>论文题目查询</h1>
		</div>
		<form name="subjectQueryForm" id="subjectQueryForm" action="<%=basePath %>Subject/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="subjectName">题目名称:</label>
				<input type="text" id="subjectName" name="subjectName" value="<%=subjectName %>" class="form-control" placeholder="请输入题目名称">
			</div>






            <div class="form-group">
            	<label for="subjectTypeObj_typeId">题目类型：</label>
                <select id="subjectTypeObj_typeId" name="subjectTypeObj.typeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(SubjectType subjectTypeTemp:subjectTypeList) {
	 					String selected = "";
 					if(subjectTypeObj!=null && subjectTypeObj.getTypeId()!=null && subjectTypeObj.getTypeId().intValue()==subjectTypeTemp.getTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=subjectTypeTemp.getTypeId() %>" <%=selected %>><%=subjectTypeTemp.getTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="teacherObj_teacherNo">指导老师：</label>
                <select id="teacherObj_teacherNo" name="teacherObj.teacherNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Teacher teacherTemp:teacherList) {
	 					String selected = "";
 					if(teacherObj!=null && teacherObj.getTeacherNo()!=null && teacherObj.getTeacherNo().equals(teacherTemp.getTeacherNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=teacherTemp.getTeacherNo() %>" <%=selected %>><%=teacherTemp.getTeacherName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择发布时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="subjectEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;论文题目信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="subject.sujectContent" id="subject_sujectContent_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subject_taskFile_edit" class="col-md-3 text-right">任务书文件:</label>
		  	 <div class="col-md-9">
			    <a id="subject_taskFileA" target="_blank"></a><br/>
			    <input type="hidden" id="subject_taskFile" name="subject.taskFile"/>
			    <input id="taskFileFile" name="taskFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="subject_otherFile_edit" class="col-md-3 text-right">其他资料文件:</label>
		  	 <div class="col-md-9">
			    <a id="subject_otherFileA" target="_blank"></a><br/>
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
		</form> 
	    <style>#subjectEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSubjectModify();">提交</button>
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
var subject_sujectContent_edit = UE.getEditor('subject_sujectContent_edit'); //题目内容编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.subjectQueryForm.currentPage.value = currentPage;
    document.subjectQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.subjectQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.subjectQueryForm.currentPage.value = pageValue;
    documentsubjectQueryForm.submit();
}

/*弹出修改论文题目界面并初始化数据*/
function subjectEdit(subjectId) {
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
				subject_sujectContent_edit.setContent(subject.sujectContent, false);
				$("#subject_taskFile").val(subject.taskFile);
				$("#subject_taskFileA").text(subject.taskFile);
				$("#subject_taskFileA").attr("href", basePath +　subject.taskFile);
				$("#subject_otherFile").val(subject.otherFile);
				$("#subject_otherFileA").text(subject.otherFile);
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
				$('#subjectEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除论文题目信息*/
function subjectDelete(subjectId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Subject/deletes",
			data : {
				subjectIds : subjectId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#subjectQueryForm").submit();
					//location.href= basePath + "Subject/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

