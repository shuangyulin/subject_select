package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Opus {
    /*成果id*/
    private Integer opusId;
    public Integer getOpusId(){
        return opusId;
    }
    public void setOpusId(Integer opusId){
        this.opusId = opusId;
    }

    /*论文题目*/
    private Subject subjectObj;
    public Subject getSubjectObj() {
        return subjectObj;
    }
    public void setSubjectObj(Subject subjectObj) {
        this.subjectObj = subjectObj;
    }

    /*提交学生*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*开题报告*/
    private String ktbg;
    public String getKtbg() {
        return ktbg;
    }
    public void setKtbg(String ktbg) {
        this.ktbg = ktbg;
    }

    /*外文文献翻译*/
    private String wwwx;
    public String getWwwx() {
        return wwwx;
    }
    public void setWwwx(String wwwx) {
        this.wwwx = wwwx;
    }

    /*论文初稿*/
    private String lwcg;
    public String getLwcg() {
        return lwcg;
    }
    public void setLwcg(String lwcg) {
        this.lwcg = lwcg;
    }

    /*论文终稿*/
    private String lwzg;
    public String getLwzg() {
        return lwzg;
    }
    public void setLwzg(String lwzg) {
        this.lwzg = lwzg;
    }

    /*其他文件*/
    private String otherFile;
    public String getOtherFile() {
        return otherFile;
    }
    public void setOtherFile(String otherFile) {
        this.otherFile = otherFile;
    }

    /*论文成绩*/
    private String chengji;
    public String getChengji() {
        return chengji;
    }
    public void setChengji(String chengji) {
        this.chengji = chengji;
    }

    /*老师评价*/
    private String evaluate;
    public String getEvaluate() {
        return evaluate;
    }
    public void setEvaluate(String evaluate) {
        this.evaluate = evaluate;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOpus=new JSONObject(); 
		jsonOpus.accumulate("opusId", this.getOpusId());
		jsonOpus.accumulate("subjectObj", this.getSubjectObj().getSubjectName());
		jsonOpus.accumulate("subjectObjPri", this.getSubjectObj().getSubjectId());
		jsonOpus.accumulate("userObj", this.getUserObj().getName());
		jsonOpus.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonOpus.accumulate("ktbg", this.getKtbg());
		jsonOpus.accumulate("wwwx", this.getWwwx());
		jsonOpus.accumulate("lwcg", this.getLwcg());
		jsonOpus.accumulate("lwzg", this.getLwzg());
		jsonOpus.accumulate("otherFile", this.getOtherFile());
		jsonOpus.accumulate("chengji", this.getChengji());
		jsonOpus.accumulate("evaluate", this.getEvaluate());
		return jsonOpus;
    }}