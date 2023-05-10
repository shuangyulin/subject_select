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
import com.chengxusheji.service.SubSelectService;
import com.chengxusheji.po.SubSelect;
import com.chengxusheji.service.SubjectService;
import com.chengxusheji.po.Subject;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//SubSelect管理控制层
@Controller
@RequestMapping("/SubSelect")
public class SubSelectController extends BaseController {

    /*业务层对象*/
    @Resource SubSelectService subSelectService;

    @Resource SubjectService subjectService;
    @Resource UserInfoService userInfoService;
	@InitBinder("subjectObj")
	public void initBindersubjectObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("subjectObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("subSelect")
	public void initBinderSubSelect(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("subSelect.");
	}
	/*跳转到添加SubSelect视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new SubSelect());
		/*查询所有的Subject信息*/
		List<Subject> subjectList = subjectService.queryAllSubject();
		request.setAttribute("subjectList", subjectList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "SubSelect_add";
	}

	/*客户端ajax方式提交添加学生选题信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated SubSelect subSelect, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        subSelectService.addSubSelect(subSelect);
        message = "学生选题添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询学生选题信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("subjectObj") Subject subjectObj,@ModelAttribute("userObj") UserInfo userObj,String selectTime,String shenHeState,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (selectTime == null) selectTime = "";
		if (shenHeState == null) shenHeState = "";
		if(rows != 0)subSelectService.setRows(rows);
		List<SubSelect> subSelectList = subSelectService.querySubSelect(subjectObj, userObj, selectTime, shenHeState, page);
	    /*计算总的页数和总的记录数*/
	    subSelectService.queryTotalPageAndRecordNumber(subjectObj, userObj, selectTime, shenHeState);
	    /*获取到总的页码数目*/
	    int totalPage = subSelectService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = subSelectService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(SubSelect subSelect:subSelectList) {
			JSONObject jsonSubSelect = subSelect.getJsonObject();
			jsonArray.put(jsonSubSelect);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询学生选题信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<SubSelect> subSelectList = subSelectService.queryAllSubSelect();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(SubSelect subSelect:subSelectList) {
			JSONObject jsonSubSelect = new JSONObject();
			jsonSubSelect.accumulate("selectId", subSelect.getSelectId());
			jsonArray.put(jsonSubSelect);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询学生选题信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("subjectObj") Subject subjectObj,@ModelAttribute("userObj") UserInfo userObj,String selectTime,String shenHeState,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (selectTime == null) selectTime = "";
		if (shenHeState == null) shenHeState = "";
		List<SubSelect> subSelectList = subSelectService.querySubSelect(subjectObj, userObj, selectTime, shenHeState, currentPage);
	    /*计算总的页数和总的记录数*/
	    subSelectService.queryTotalPageAndRecordNumber(subjectObj, userObj, selectTime, shenHeState);
	    /*获取到总的页码数目*/
	    int totalPage = subSelectService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = subSelectService.getRecordNumber();
	    request.setAttribute("subSelectList",  subSelectList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("subjectObj", subjectObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("selectTime", selectTime);
	    request.setAttribute("shenHeState", shenHeState);
	    List<Subject> subjectList = subjectService.queryAllSubject();
	    request.setAttribute("subjectList", subjectList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "SubSelect/subSelect_frontquery_result"; 
	}

     /*前台查询SubSelect信息*/
	@RequestMapping(value="/{selectId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer selectId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键selectId获取SubSelect对象*/
        SubSelect subSelect = subSelectService.getSubSelect(selectId);

        List<Subject> subjectList = subjectService.queryAllSubject();
        request.setAttribute("subjectList", subjectList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("subSelect",  subSelect);
        return "SubSelect/subSelect_frontshow";
	}

	/*ajax方式显示学生选题修改jsp视图页*/
	@RequestMapping(value="/{selectId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer selectId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键selectId获取SubSelect对象*/
        SubSelect subSelect = subSelectService.getSubSelect(selectId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSubSelect = subSelect.getJsonObject();
		out.println(jsonSubSelect.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新学生选题信息*/
	@RequestMapping(value = "/{selectId}/update", method = RequestMethod.POST)
	public void update(@Validated SubSelect subSelect, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			subSelectService.updateSubSelect(subSelect);
			message = "学生选题更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "学生选题更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除学生选题信息*/
	@RequestMapping(value="/{selectId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer selectId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  subSelectService.deleteSubSelect(selectId);
	            request.setAttribute("message", "学生选题删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "学生选题删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条学生选题记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String selectIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = subSelectService.deleteSubSelects(selectIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出学生选题信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("subjectObj") Subject subjectObj,@ModelAttribute("userObj") UserInfo userObj,String selectTime,String shenHeState, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(selectTime == null) selectTime = "";
        if(shenHeState == null) shenHeState = "";
        List<SubSelect> subSelectList = subSelectService.querySubSelect(subjectObj,userObj,selectTime,shenHeState);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "SubSelect信息记录"; 
        String[] headers = { "选题id","论文题目","选题学生","选题时间","审核状态"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<subSelectList.size();i++) {
        	SubSelect subSelect = subSelectList.get(i); 
        	dataset.add(new String[]{subSelect.getSelectId() + "",subSelect.getSubjectObj().getSubjectName(),subSelect.getUserObj().getName(),subSelect.getSelectTime(),subSelect.getShenHeState()});
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
			response.setHeader("Content-disposition","attachment; filename="+"SubSelect.xls");//filename是下载的xls的名，建议最好用英文 
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
