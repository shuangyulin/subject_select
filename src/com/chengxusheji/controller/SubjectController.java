package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.SubjectService;
import com.chengxusheji.po.Subject;
import com.chengxusheji.service.SubjectTypeService;
import com.chengxusheji.po.SubjectType;
import com.chengxusheji.service.TeacherService;
import com.chengxusheji.po.Teacher;

//Subject管理控制层
@Controller
@RequestMapping("/Subject")
public class SubjectController extends BaseController {

    /*业务层对象*/
    @Resource SubjectService subjectService;

    @Resource SubjectTypeService subjectTypeService;
    @Resource TeacherService teacherService;
	@InitBinder("subjectTypeObj")
	public void initBindersubjectTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("subjectTypeObj.");
	}
	@InitBinder("teacherObj")
	public void initBinderteacherObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("teacherObj.");
	}
	@InitBinder("subject")
	public void initBinderSubject(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("subject.");
	}
	/*跳转到添加Subject视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Subject());
		/*查询所有的SubjectType信息*/
		List<SubjectType> subjectTypeList = subjectTypeService.queryAllSubjectType();
		request.setAttribute("subjectTypeList", subjectTypeList);
		/*查询所有的Teacher信息*/
		List<Teacher> teacherList = teacherService.queryAllTeacher();
		request.setAttribute("teacherList", teacherList);
		return "Subject_add";
	}

	/*客户端ajax方式提交添加论文题目信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Subject subject, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		subject.setTaskFile(this.handleFileUpload(request, "taskFileFile"));
		subject.setOtherFile(this.handleFileUpload(request, "otherFileFile"));
        subjectService.addSubject(subject);
        message = "论文题目添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询论文题目信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String subjectName,@ModelAttribute("subjectTypeObj") SubjectType subjectTypeObj,@ModelAttribute("teacherObj") Teacher teacherObj,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (subjectName == null) subjectName = "";
		if (addTime == null) addTime = "";
		if(rows != 0)subjectService.setRows(rows);
		List<Subject> subjectList = subjectService.querySubject(subjectName, subjectTypeObj, teacherObj, addTime, page);
	    /*计算总的页数和总的记录数*/
	    subjectService.queryTotalPageAndRecordNumber(subjectName, subjectTypeObj, teacherObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = subjectService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = subjectService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Subject subject:subjectList) {
			JSONObject jsonSubject = subject.getJsonObject();
			jsonArray.put(jsonSubject);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询论文题目信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Subject> subjectList = subjectService.queryAllSubject();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Subject subject:subjectList) {
			JSONObject jsonSubject = new JSONObject();
			jsonSubject.accumulate("subjectId", subject.getSubjectId());
			jsonSubject.accumulate("subjectName", subject.getSubjectName());
			jsonArray.put(jsonSubject);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询论文题目信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String subjectName,@ModelAttribute("subjectTypeObj") SubjectType subjectTypeObj,@ModelAttribute("teacherObj") Teacher teacherObj,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (subjectName == null) subjectName = "";
		if (addTime == null) addTime = "";
		List<Subject> subjectList = subjectService.querySubject(subjectName, subjectTypeObj, teacherObj, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    subjectService.queryTotalPageAndRecordNumber(subjectName, subjectTypeObj, teacherObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = subjectService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = subjectService.getRecordNumber();
	    request.setAttribute("subjectList",  subjectList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("subjectName", subjectName);
	    request.setAttribute("subjectTypeObj", subjectTypeObj);
	    request.setAttribute("teacherObj", teacherObj);
	    request.setAttribute("addTime", addTime);
	    List<SubjectType> subjectTypeList = subjectTypeService.queryAllSubjectType();
	    request.setAttribute("subjectTypeList", subjectTypeList);
	    List<Teacher> teacherList = teacherService.queryAllTeacher();
	    request.setAttribute("teacherList", teacherList);
		return "Subject/subject_frontquery_result"; 
	}

     /*前台查询Subject信息*/
	@RequestMapping(value="/{subjectId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer subjectId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键subjectId获取Subject对象*/
        Subject subject = subjectService.getSubject(subjectId);

        List<SubjectType> subjectTypeList = subjectTypeService.queryAllSubjectType();
        request.setAttribute("subjectTypeList", subjectTypeList);
        List<Teacher> teacherList = teacherService.queryAllTeacher();
        request.setAttribute("teacherList", teacherList);
        request.setAttribute("subject",  subject);
        return "Subject/subject_frontshow";
	}

	/*ajax方式显示论文题目修改jsp视图页*/
	@RequestMapping(value="/{subjectId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer subjectId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键subjectId获取Subject对象*/
        Subject subject = subjectService.getSubject(subjectId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSubject = subject.getJsonObject();
		out.println(jsonSubject.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新论文题目信息*/
	@RequestMapping(value = "/{subjectId}/update", method = RequestMethod.POST)
	public void update(@Validated Subject subject, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String taskFileFileName = this.handleFileUpload(request, "taskFileFile");
		if(!taskFileFileName.equals(""))subject.setTaskFile(taskFileFileName);
		String otherFileFileName = this.handleFileUpload(request, "otherFileFile");
		if(!otherFileFileName.equals(""))subject.setOtherFile(otherFileFileName);
		try {
			subjectService.updateSubject(subject);
			message = "论文题目更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "论文题目更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除论文题目信息*/
	@RequestMapping(value="/{subjectId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer subjectId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  subjectService.deleteSubject(subjectId);
	            request.setAttribute("message", "论文题目删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "论文题目删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条论文题目记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String subjectIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = subjectService.deleteSubjects(subjectIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出论文题目信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String subjectName,@ModelAttribute("subjectTypeObj") SubjectType subjectTypeObj,@ModelAttribute("teacherObj") Teacher teacherObj,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(subjectName == null) subjectName = "";
        if(addTime == null) addTime = "";
        List<Subject> subjectList = subjectService.querySubject(subjectName,subjectTypeObj,teacherObj,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Subject信息记录"; 
        String[] headers = { "题目id","题目名称","题目类型","限选人数","指导老师","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<subjectList.size();i++) {
        	Subject subject = subjectList.get(i); 
        	dataset.add(new String[]{subject.getSubjectId() + "",subject.getSubjectName(),subject.getSubjectTypeObj().getTypeName(),subject.getPersonNum() + "",subject.getTeacherObj().getTeacherName(),subject.getAddTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Subject.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
