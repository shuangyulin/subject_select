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
import com.chengxusheji.service.OpusService;
import com.chengxusheji.po.Opus;
import com.chengxusheji.service.SubjectService;
import com.chengxusheji.po.Subject;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Opus管理控制层
@Controller
@RequestMapping("/Opus")
public class OpusController extends BaseController {

    /*业务层对象*/
    @Resource OpusService opusService;

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
	@InitBinder("opus")
	public void initBinderOpus(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("opus.");
	}
	/*跳转到添加Opus视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Opus());
		/*查询所有的Subject信息*/
		List<Subject> subjectList = subjectService.queryAllSubject();
		request.setAttribute("subjectList", subjectList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Opus_add";
	}

	/*客户端ajax方式提交添加学生成果信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Opus opus, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		opus.setKtbg(this.handleFileUpload(request, "ktbgFile"));
		opus.setWwwx(this.handleFileUpload(request, "wwwxFile"));
		opus.setLwcg(this.handleFileUpload(request, "lwcgFile"));
		opus.setLwzg(this.handleFileUpload(request, "lwzgFile"));
		opus.setOtherFile(this.handleFileUpload(request, "otherFileFile"));
        opusService.addOpus(opus);
        message = "学生成果添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询学生成果信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("subjectObj") Subject subjectObj,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)opusService.setRows(rows);
		List<Opus> opusList = opusService.queryOpus(subjectObj, userObj, page);
	    /*计算总的页数和总的记录数*/
	    opusService.queryTotalPageAndRecordNumber(subjectObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = opusService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = opusService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Opus opus:opusList) {
			JSONObject jsonOpus = opus.getJsonObject();
			jsonArray.put(jsonOpus);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询学生成果信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Opus> opusList = opusService.queryAllOpus();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Opus opus:opusList) {
			JSONObject jsonOpus = new JSONObject();
			jsonOpus.accumulate("opusId", opus.getOpusId());
			jsonArray.put(jsonOpus);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询学生成果信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("subjectObj") Subject subjectObj,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<Opus> opusList = opusService.queryOpus(subjectObj, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    opusService.queryTotalPageAndRecordNumber(subjectObj, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = opusService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = opusService.getRecordNumber();
	    request.setAttribute("opusList",  opusList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("subjectObj", subjectObj);
	    request.setAttribute("userObj", userObj);
	    List<Subject> subjectList = subjectService.queryAllSubject();
	    request.setAttribute("subjectList", subjectList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Opus/opus_frontquery_result"; 
	}

     /*前台查询Opus信息*/
	@RequestMapping(value="/{opusId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer opusId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键opusId获取Opus对象*/
        Opus opus = opusService.getOpus(opusId);

        List<Subject> subjectList = subjectService.queryAllSubject();
        request.setAttribute("subjectList", subjectList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("opus",  opus);
        return "Opus/opus_frontshow";
	}

	/*ajax方式显示学生成果修改jsp视图页*/
	@RequestMapping(value="/{opusId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer opusId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键opusId获取Opus对象*/
        Opus opus = opusService.getOpus(opusId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonOpus = opus.getJsonObject();
		out.println(jsonOpus.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新学生成果信息*/
	@RequestMapping(value = "/{opusId}/update", method = RequestMethod.POST)
	public void update(@Validated Opus opus, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String ktbgFileName = this.handleFileUpload(request, "ktbgFile");
		if(!ktbgFileName.equals(""))opus.setKtbg(ktbgFileName);
		String wwwxFileName = this.handleFileUpload(request, "wwwxFile");
		if(!wwwxFileName.equals(""))opus.setWwwx(wwwxFileName);
		String lwcgFileName = this.handleFileUpload(request, "lwcgFile");
		if(!lwcgFileName.equals(""))opus.setLwcg(lwcgFileName);
		String lwzgFileName = this.handleFileUpload(request, "lwzgFile");
		if(!lwzgFileName.equals(""))opus.setLwzg(lwzgFileName);
		String otherFileFileName = this.handleFileUpload(request, "otherFileFile");
		if(!otherFileFileName.equals(""))opus.setOtherFile(otherFileFileName);
		try {
			opusService.updateOpus(opus);
			message = "学生成果更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "学生成果更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除学生成果信息*/
	@RequestMapping(value="/{opusId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer opusId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  opusService.deleteOpus(opusId);
	            request.setAttribute("message", "学生成果删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "学生成果删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条学生成果记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String opusIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = opusService.deleteOpuss(opusIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出学生成果信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("subjectObj") Subject subjectObj,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<Opus> opusList = opusService.queryOpus(subjectObj,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Opus信息记录"; 
        String[] headers = { "成果id","论文题目","提交学生","论文成绩","老师评价"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<opusList.size();i++) {
        	Opus opus = opusList.get(i); 
        	dataset.add(new String[]{opus.getOpusId() + "",opus.getSubjectObj().getSubjectName(),opus.getUserObj().getName(),opus.getChengji(),opus.getEvaluate()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Opus.xls");//filename是下载的xls的名，建议最好用英文 
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
