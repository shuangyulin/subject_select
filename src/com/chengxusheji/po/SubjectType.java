package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class SubjectType {
    /*类型编号*/
    private Integer typeId;
    public Integer getTypeId(){
        return typeId;
    }
    public void setTypeId(Integer typeId){
        this.typeId = typeId;
    }

    /*类型名称*/
    @NotEmpty(message="类型名称不能为空")
    private String typeName;
    public String getTypeName() {
        return typeName;
    }
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSubjectType=new JSONObject(); 
		jsonSubjectType.accumulate("typeId", this.getTypeId());
		jsonSubjectType.accumulate("typeName", this.getTypeName());
		return jsonSubjectType;
    }}