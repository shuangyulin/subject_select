package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Video {
    /*视频id*/
    private Integer videoId;
    public Integer getVideoId(){
        return videoId;
    }
    public void setVideoId(Integer videoId){
        this.videoId = videoId;
    }

    /*论文题目*/
    private Subject subjectObj;
    public Subject getSubjectObj() {
        return subjectObj;
    }
    public void setSubjectObj(Subject subjectObj) {
        this.subjectObj = subjectObj;
    }

    /*答辩学生*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*答辩视频*/
    private String videoFile;
    public String getVideoFile() {
        return videoFile;
    }
    public void setVideoFile(String videoFile) {
        this.videoFile = videoFile;
    }

    /*视频时间*/
    @NotEmpty(message="视频时间不能为空")
    private String videoTime;
    public String getVideoTime() {
        return videoTime;
    }
    public void setVideoTime(String videoTime) {
        this.videoTime = videoTime;
    }

    /*答辩日期*/
    @NotEmpty(message="答辩日期不能为空")
    private String videoDate;
    public String getVideoDate() {
        return videoDate;
    }
    public void setVideoDate(String videoDate) {
        this.videoDate = videoDate;
    }

    /*附加信息*/
    private String videoMemo;
    public String getVideoMemo() {
        return videoMemo;
    }
    public void setVideoMemo(String videoMemo) {
        this.videoMemo = videoMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonVideo=new JSONObject(); 
		jsonVideo.accumulate("videoId", this.getVideoId());
		jsonVideo.accumulate("subjectObj", this.getSubjectObj().getSubjectName());
		jsonVideo.accumulate("subjectObjPri", this.getSubjectObj().getSubjectId());
		jsonVideo.accumulate("userObj", this.getUserObj().getName());
		jsonVideo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonVideo.accumulate("videoFile", this.getVideoFile());
		jsonVideo.accumulate("videoTime", this.getVideoTime());
		jsonVideo.accumulate("videoDate", this.getVideoDate().length()>19?this.getVideoDate().substring(0,19):this.getVideoDate());
		jsonVideo.accumulate("videoMemo", this.getVideoMemo());
		return jsonVideo;
    }}