package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Subject;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.SubSelect;

import com.chengxusheji.mapper.SubSelectMapper;
@Service
public class SubSelectService {

	@Resource SubSelectMapper subSelectMapper;
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

    /*添加学生选题记录*/
    public void addSubSelect(SubSelect subSelect) throws Exception {
    	subSelectMapper.addSubSelect(subSelect);
    }

    /*按照查询条件分页查询学生选题记录*/
    public ArrayList<SubSelect> querySubSelect(Subject subjectObj,UserInfo userObj,String selectTime,String shenHeState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != subjectObj && subjectObj.getSubjectId()!= null && subjectObj.getSubjectId()!= 0)  where += " and t_subSelect.subjectObj=" + subjectObj.getSubjectId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_subSelect.userObj='" + userObj.getUser_name() + "'";
    	if(!selectTime.equals("")) where = where + " and t_subSelect.selectTime like '%" + selectTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_subSelect.shenHeState like '%" + shenHeState + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return subSelectMapper.querySubSelect(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<SubSelect> querySubSelect(Subject subjectObj,UserInfo userObj,String selectTime,String shenHeState) throws Exception  { 
     	String where = "where 1=1";
    	if(null != subjectObj && subjectObj.getSubjectId()!= null && subjectObj.getSubjectId()!= 0)  where += " and t_subSelect.subjectObj=" + subjectObj.getSubjectId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_subSelect.userObj='" + userObj.getUser_name() + "'";
    	if(!selectTime.equals("")) where = where + " and t_subSelect.selectTime like '%" + selectTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_subSelect.shenHeState like '%" + shenHeState + "%'";
    	return subSelectMapper.querySubSelectList(where);
    }

    /*查询所有学生选题记录*/
    public ArrayList<SubSelect> queryAllSubSelect()  throws Exception {
        return subSelectMapper.querySubSelectList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Subject subjectObj,UserInfo userObj,String selectTime,String shenHeState) throws Exception {
     	String where = "where 1=1";
    	if(null != subjectObj && subjectObj.getSubjectId()!= null && subjectObj.getSubjectId()!= 0)  where += " and t_subSelect.subjectObj=" + subjectObj.getSubjectId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_subSelect.userObj='" + userObj.getUser_name() + "'";
    	if(!selectTime.equals("")) where = where + " and t_subSelect.selectTime like '%" + selectTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_subSelect.shenHeState like '%" + shenHeState + "%'";
        recordNumber = subSelectMapper.querySubSelectCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学生选题记录*/
    public SubSelect getSubSelect(int selectId) throws Exception  {
        SubSelect subSelect = subSelectMapper.getSubSelect(selectId);
        return subSelect;
    }

    /*更新学生选题记录*/
    public void updateSubSelect(SubSelect subSelect) throws Exception {
        subSelectMapper.updateSubSelect(subSelect);
    }

    /*删除一条学生选题记录*/
    public void deleteSubSelect (int selectId) throws Exception {
        subSelectMapper.deleteSubSelect(selectId);
    }

    /*删除多条学生选题信息*/
    public int deleteSubSelects (String selectIds) throws Exception {
    	String _selectIds[] = selectIds.split(",");
    	for(String _selectId: _selectIds) {
    		subSelectMapper.deleteSubSelect(Integer.parseInt(_selectId));
    	}
    	return _selectIds.length;
    }
}
