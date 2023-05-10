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
import com.chengxusheji.service.VideoService;
import com.chengxusheji.po.Video;
import com.chengxusheji.service.SubjectService;
import com.chengxusheji.po.Subject;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Video管理控制层
@Controller
@RequestMapping("/Video")
public class VideoController extends BaseController {

    /*业务层对象*/
    @Resource VideoService videoService;

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
	@InitBinder("video")
	public void initBinderVideo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("video.");
	}
	/*跳转到添加Video视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Video());
		/*查询所有的Subject信息*/
		List<Subject> subjectList = subjectService.queryAllSubject();
		request.setAttribute("subjectList", subjectList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Video_add";
	}

	/*客户端ajax方式提交添加答辩视频信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Video video, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		video.setVideoFile(this.handleFileUpload(request, "videoFileFile"));
        videoService.addVideo(video);
        message = "答辩视频添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询答辩视频信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("subjectObj") Subject subjectObj,@ModelAttribute("userObj") UserInfo userObj,String videoDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (videoDate == null) videoDate = "";
		if(rows != 0)videoService.setRows(rows);
		List<Video> videoList = videoService.queryVideo(subjectObj, userObj, videoDate, page);
	    /*计算总的页数和总的记录数*/
	    videoService.queryTotalPageAndRecordNumber(subjectObj, userObj, videoDate);
	    /*获取到总的页码数目*/
	    int totalPage = videoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = videoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Video video:videoList) {
			JSONObject jsonVideo = video.getJsonObject();
			jsonArray.put(jsonVideo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询答辩视频信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Video> videoList = videoService.queryAllVideo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Video video:videoList) {
			JSONObject jsonVideo = new JSONObject();
			jsonVideo.accumulate("videoId", video.getVideoId());
			jsonArray.put(jsonVideo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询答辩视频信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("subjectObj") Subject subjectObj,@ModelAttribute("userObj") UserInfo userObj,String videoDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (videoDate == null) videoDate = "";
		List<Video> videoList = videoService.queryVideo(subjectObj, userObj, videoDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    videoService.queryTotalPageAndRecordNumber(subjectObj, userObj, videoDate);
	    /*获取到总的页码数目*/
	    int totalPage = videoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = videoService.getRecordNumber();
	    request.setAttribute("videoList",  videoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("subjectObj", subjectObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("videoDate", videoDate);
	    List<Subject> subjectList = subjectService.queryAllSubject();
	    request.setAttribute("subjectList", subjectList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Video/video_frontquery_result"; 
	}

     /*前台查询Video信息*/
	@RequestMapping(value="/{videoId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer videoId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键videoId获取Video对象*/
        Video video = videoService.getVideo(videoId);

        List<Subject> subjectList = subjectService.queryAllSubject();
        request.setAttribute("subjectList", subjectList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("video",  video);
        return "Video/video_frontshow";
	}

	/*ajax方式显示答辩视频修改jsp视图页*/
	@RequestMapping(value="/{videoId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer videoId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键videoId获取Video对象*/
        Video video = videoService.getVideo(videoId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonVideo = video.getJsonObject();
		out.println(jsonVideo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新答辩视频信息*/
	@RequestMapping(value = "/{videoId}/update", method = RequestMethod.POST)
	public void update(@Validated Video video, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String videoFileFileName = this.handleFileUpload(request, "videoFileFile");
		if(!videoFileFileName.equals(""))video.setVideoFile(videoFileFileName);
		try {
			videoService.updateVideo(video);
			message = "答辩视频更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "答辩视频更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除答辩视频信息*/
	@RequestMapping(value="/{videoId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer videoId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  videoService.deleteVideo(videoId);
	            request.setAttribute("message", "答辩视频删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "答辩视频删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条答辩视频记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String videoIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = videoService.deleteVideos(videoIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出答辩视频信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("subjectObj") Subject subjectObj,@ModelAttribute("userObj") UserInfo userObj,String videoDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(videoDate == null) videoDate = "";
        List<Video> videoList = videoService.queryVideo(subjectObj,userObj,videoDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Video信息记录"; 
        String[] headers = { "视频id","论文题目","答辩学生","视频时间","答辩日期"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<videoList.size();i++) {
        	Video video = videoList.get(i); 
        	dataset.add(new String[]{video.getVideoId() + "",video.getSubjectObj().getSubjectName(),video.getUserObj().getName(),video.getVideoTime(),video.getVideoDate()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Video.xls");//filename是下载的xls的名，建议最好用英文 
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
