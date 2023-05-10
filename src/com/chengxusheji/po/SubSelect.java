package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class SubSelect {
    /*选题id*/
    private Integer selectId;
    public Integer getSelectId(){
        return selectId;
    }
    public void setSelectId(Integer selectId){
        this.selectId = selectId;
    }

    /*论文题目*/
    private Subject subjectObj;
    public Subject getSubjectObj() {
        return subjectObj;
    }
    public void setSubjectObj(Subject subjectObj) {
        this.subjectObj = subjectObj;
    }

    /*选题学生*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*选题时间*/
    @NotEmpty(message="选题时间不能为空")
    private String selectTime;
    public String getSelectTime() {
        return selectTime;
    }
    public void setSelectTime(String selectTime) {
        this.selectTime = selectTime;
    }

    /*审核状态*/
    @NotEmpty(message="审核状态不能为空")
    private String shenHeState;
    public String getShenHeState() {
        return shenHeState;
    }
    public void setShenHeState(String shenHeState) {
        this.shenHeState = shenHeState;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSubSelect=new JSONObject(); 
		jsonSubSelect.accumulate("selectId", this.getSelectId());
		jsonSubSelect.accumulate("subjectObj", this.getSubjectObj().getSubjectName());
		jsonSubSelect.accumulate("subjectObjPri", this.getSubjectObj().getSubjectId());
		jsonSubSelect.accumulate("userObj", this.getUserObj().getName());
		jsonSubSelect.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonSubSelect.accumulate("selectTime", this.getSelectTime().length()>19?this.getSelectTime().substring(0,19):this.getSelectTime());
		jsonSubSelect.accumulate("shenHeState", this.getShenHeState());
		return jsonSubSelect;
    }}