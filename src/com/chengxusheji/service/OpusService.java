package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Subject;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Opus;

import com.chengxusheji.mapper.OpusMapper;
@Service
public class OpusService {

	@Resource OpusMapper opusMapper;
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

    /*添加学生成果记录*/
    public void addOpus(Opus opus) throws Exception {
    	opusMapper.addOpus(opus);
    }

    /*按照查询条件分页查询学生成果记录*/
    public ArrayList<Opus> queryOpus(Subject subjectObj,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != subjectObj && subjectObj.getSubjectId()!= null && subjectObj.getSubjectId()!= 0)  where += " and t_opus.subjectObj=" + subjectObj.getSubjectId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_opus.userObj='" + userObj.getUser_name() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return opusMapper.queryOpus(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Opus> queryOpus(Subject subjectObj,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != subjectObj && subjectObj.getSubjectId()!= null && subjectObj.getSubjectId()!= 0)  where += " and t_opus.subjectObj=" + subjectObj.getSubjectId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_opus.userObj='" + userObj.getUser_name() + "'";
    	return opusMapper.queryOpusList(where);
    }

    /*查询所有学生成果记录*/
    public ArrayList<Opus> queryAllOpus()  throws Exception {
        return opusMapper.queryOpusList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Subject subjectObj,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(null != subjectObj && subjectObj.getSubjectId()!= null && subjectObj.getSubjectId()!= 0)  where += " and t_opus.subjectObj=" + subjectObj.getSubjectId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_opus.userObj='" + userObj.getUser_name() + "'";
        recordNumber = opusMapper.queryOpusCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学生成果记录*/
    public Opus getOpus(int opusId) throws Exception  {
        Opus opus = opusMapper.getOpus(opusId);
        return opus;
    }

    /*更新学生成果记录*/
    public void updateOpus(Opus opus) throws Exception {
        opusMapper.updateOpus(opus);
    }

    /*删除一条学生成果记录*/
    public void deleteOpus (int opusId) throws Exception {
        opusMapper.deleteOpus(opusId);
    }

    /*删除多条学生成果信息*/
    public int deleteOpuss (String opusIds) throws Exception {
    	String _opusIds[] = opusIds.split(",");
    	for(String _opusId: _opusIds) {
    		opusMapper.deleteOpus(Integer.parseInt(_opusId));
    	}
    	return _opusIds.length;
    }
}
