package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Subject {
    /*题目id*/
    private Integer subjectId;
    public Integer getSubjectId(){
        return subjectId;
    }
    public void setSubjectId(Integer subjectId){
        this.subjectId = subjectId;
    }

    /*题目名称*/
    @NotEmpty(message="题目名称不能为空")
    private String subjectName;
    public String getSubjectName() {
        return subjectName;
    }
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    /*题目类型*/
    private SubjectType subjectTypeObj;
    public SubjectType getSubjectTypeObj() {
        return subjectTypeObj;
    }
    public void setSubjectTypeObj(SubjectType subjectTypeObj) {
        this.subjectTypeObj = subjectTypeObj;
    }

    /*题目内容*/
    @NotEmpty(message="题目内容不能为空")
    private String sujectContent;
    public String getSujectContent() {
        return sujectContent;
    }
    public void setSujectContent(String sujectContent) {
        this.sujectContent = sujectContent;
    }

    /*任务书文件*/
    private String taskFile;
    public String getTaskFile() {
        return taskFile;
    }
    public void setTaskFile(String taskFile) {
        this.taskFile = taskFile;
    }

    /*其他资料文件*/
    private String otherFile;
    public String getOtherFile() {
        return otherFile;
    }
    public void setOtherFile(String otherFile) {
        this.otherFile = otherFile;
    }

    /*限选人数*/
    @NotNull(message="必须输入限选人数")
    private Integer personNum;
    public Integer getPersonNum() {
        return personNum;
    }
    public void setPersonNum(Integer personNum) {
        this.personNum = personNum;
    }

    /*指导老师*/
    private Teacher teacherObj;
    public Teacher getTeacherObj() {
        return teacherObj;
    }
    public void setTeacherObj(Teacher teacherObj) {
        this.teacherObj = teacherObj;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSubject=new JSONObject(); 
		jsonSubject.accumulate("subjectId", this.getSubjectId());
		jsonSubject.accumulate("subjectName", this.getSubjectName());
		jsonSubject.accumulate("subjectTypeObj", this.getSubjectTypeObj().getTypeName());
		jsonSubject.accumulate("subjectTypeObjPri", this.getSubjectTypeObj().getTypeId());
		jsonSubject.accumulate("sujectContent", this.getSujectContent());
		jsonSubject.accumulate("taskFile", this.getTaskFile());
		jsonSubject.accumulate("otherFile", this.getOtherFile());
		jsonSubject.accumulate("personNum", this.getPersonNum());
		jsonSubject.accumulate("teacherObj", this.getTeacherObj().getTeacherName());
		jsonSubject.accumulate("teacherObjPri", this.getTeacherObj().getTeacherNo());
		jsonSubject.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonSubject;
    }}