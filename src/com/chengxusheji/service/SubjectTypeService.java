package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.SubjectType;

import com.chengxusheji.mapper.SubjectTypeMapper;
@Service
public class SubjectTypeService {

	@Resource SubjectTypeMapper subjectTypeMapper;
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

    /*添加题目类型记录*/
    public void addSubjectType(SubjectType subjectType) throws Exception {
    	subjectTypeMapper.addSubjectType(subjectType);
    }

    /*按照查询条件分页查询题目类型记录*/
    public ArrayList<SubjectType> querySubjectType(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return subjectTypeMapper.querySubjectType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<SubjectType> querySubjectType() throws Exception  { 
     	String where = "where 1=1";
    	return subjectTypeMapper.querySubjectTypeList(where);
    }

    /*查询所有题目类型记录*/
    public ArrayList<SubjectType> queryAllSubjectType()  throws Exception {
        return subjectTypeMapper.querySubjectTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = subjectTypeMapper.querySubjectTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取题目类型记录*/
    public SubjectType getSubjectType(int typeId) throws Exception  {
        SubjectType subjectType = subjectTypeMapper.getSubjectType(typeId);
        return subjectType;
    }

    /*更新题目类型记录*/
    public void updateSubjectType(SubjectType subjectType) throws Exception {
        subjectTypeMapper.updateSubjectType(subjectType);
    }

    /*删除一条题目类型记录*/
    public void deleteSubjectType (int typeId) throws Exception {
        subjectTypeMapper.deleteSubjectType(typeId);
    }

    /*删除多条题目类型信息*/
    public int deleteSubjectTypes (String typeIds) throws Exception {
    	String _typeIds[] = typeIds.split(",");
    	for(String _typeId: _typeIds) {
    		subjectTypeMapper.deleteSubjectType(Integer.parseInt(_typeId));
    	}
    	return _typeIds.length;
    }
}
