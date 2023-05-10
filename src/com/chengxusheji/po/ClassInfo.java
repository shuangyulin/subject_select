package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ClassInfo {
    /*班级编号*/
    @NotEmpty(message="班级编号不能为空")
    private String classNo;
    public String getClassNo(){
        return classNo;
    }
    public void setClassNo(String classNo){
        this.classNo = classNo;
    }

    /*班级名称*/
    @NotEmpty(message="班级名称不能为空")
    private String className;
    public String getClassName() {
        return className;
    }
    public void setClassName(String className) {
        this.className = className;
    }

    /*所属学院*/
    @NotEmpty(message="所属学院不能为空")
    private String college;
    public String getCollege() {
        return college;
    }
    public void setCollege(String college) {
        this.college = college;
    }

    /*所属专业*/
    @NotEmpty(message="所属专业不能为空")
    private String specialName;
    public String getSpecialName() {
        return specialName;
    }
    public void setSpecialName(String specialName) {
        this.specialName = specialName;
    }

    /*成立日期*/
    @NotEmpty(message="成立日期不能为空")
    private String bornDate;
    public String getBornDate() {
        return bornDate;
    }
    public void setBornDate(String bornDate) {
        this.bornDate = bornDate;
    }

    /*班主任*/
    @NotEmpty(message="班主任不能为空")
    private String mainTeacher;
    public String getMainTeacher() {
        return mainTeacher;
    }
    public void setMainTeacher(String mainTeacher) {
        this.mainTeacher = mainTeacher;
    }

    /*班级备注*/
    private String classMemo;
    public String getClassMemo() {
        return classMemo;
    }
    public void setClassMemo(String classMemo) {
        this.classMemo = classMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonClassInfo=new JSONObject(); 
		jsonClassInfo.accumulate("classNo", this.getClassNo());
		jsonClassInfo.accumulate("className", this.getClassName());
		jsonClassInfo.accumulate("college", this.getCollege());
		jsonClassInfo.accumulate("specialName", this.getSpecialName());
		jsonClassInfo.accumulate("bornDate", this.getBornDate().length()>19?this.getBornDate().substring(0,19):this.getBornDate());
		jsonClassInfo.accumulate("mainTeacher", this.getMainTeacher());
		jsonClassInfo.accumulate("classMemo", this.getClassMemo());
		return jsonClassInfo;
    }}