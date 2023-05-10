package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Subject;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Video;

import com.chengxusheji.mapper.VideoMapper;
@Service
public class VideoService {

	@Resource VideoMapper videoMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加答辩视频记录*/
    public void addVideo(Video video) throws Exception {
    	videoMapper.addVideo(video);
    }

    /*按照查询条件分页查询答辩视频记录*/
    public ArrayList<Video> queryVideo(Subject subjectObj,UserInfo userObj,String videoDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != subjectObj && subjectObj.getSubjectId()!= null && subjectObj.getSubjectId()!= 0)  where += " and t_video.subjectObj=" + subjectObj.getSubjectId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_video.userObj='" + userObj.getUser_name() + "'";
    	if(!videoDate.equals("")) where = where + " and t_video.videoDate like '%" + videoDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return videoMapper.queryVideo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Video> queryVideo(Subject subjectObj,UserInfo userObj,String videoDate) throws Exception  { 
     	String where = "where 1=1";
    	if(null != subjectObj && subjectObj.getSubjectId()!= null && subjectObj.getSubjectId()!= 0)  where += " and t_video.subjectObj=" + subjectObj.getSubjectId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_video.userObj='" + userObj.getUser_name() + "'";
    	if(!videoDate.equals("")) where = where + " and t_video.videoDate like '%" + videoDate + "%'";
    	return videoMapper.queryVideoList(where);
    }

    /*查询所有答辩视频记录*/
    public ArrayList<Video> queryAllVideo()  throws Exception {
        return videoMapper.queryVideoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Subject subjectObj,UserInfo userObj,String videoDate) throws Exception {
     	String where = "where 1=1";
    	if(null != subjectObj && subjectObj.getSubjectId()!= null && subjectObj.getSubjectId()!= 0)  where += " and t_video.subjectObj=" + subjectObj.getSubjectId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_video.userObj='" + userObj.getUser_name() + "'";
    	if(!videoDate.equals("")) where = where + " and t_video.videoDate like '%" + videoDate + "%'";
        recordNumber = videoMapper.queryVideoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取答辩视频记录*/
    public Video getVideo(int videoId) throws Exception  {
        Video video = videoMapper.getVideo(videoId);
        return video;
    }

    /*更新答辩视频记录*/
    public void updateVideo(Video video) throws Exception {
        videoMapper.updateVideo(video);
    }

    /*删除一条答辩视频记录*/
    public void deleteVideo (int videoId) throws Exception {
        videoMapper.deleteVideo(videoId);
    }

    /*删除多条答辩视频信息*/
    public int deleteVideos (String videoIds) throws Exception {
    	String _videoIds[] = videoIds.split(",");
    	for(String _videoId: _videoIds) {
    		videoMapper.deleteVideo(Integer.parseInt(_videoId));
    	}
    	return _videoIds.length;
    }
}
