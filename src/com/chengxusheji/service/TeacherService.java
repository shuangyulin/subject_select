package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Teacher;

import com.chengxusheji.mapper.TeacherMapper;
@Service
public class TeacherService {

	@Resource TeacherMapper teacherMapper;
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

    /*添加教师记录*/
    public void addTeacher(Teacher teacher) throws Exception {
    	teacherMapper.addTeacher(teacher);
    }

    /*按照查询条件分页查询教师记录*/
    public ArrayList<Teacher> queryTeacher(String teacherNo,String teacherName,String birthDate,String zhicheng,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!teacherNo.equals("")) where = where + " and t_teacher.teacherNo like '%" + teacherNo + "%'";
    	if(!teacherName.equals("")) where = where + " and t_teacher.teacherName like '%" + teacherName + "%'";
    	if(!birthDate.equals("")) where = where + " and t_teacher.birthDate like '%" + birthDate + "%'";
    	if(!zhicheng.equals("")) where = where + " and t_teacher.zhicheng like '%" + zhicheng + "%'";
    	if(!telephone.equals("")) where = where + " and t_teacher.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return teacherMapper.queryTeacher(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Teacher> queryTeacher(String teacherNo,String teacherName,String birthDate,String zhicheng,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!teacherNo.equals("")) where = where + " and t_teacher.teacherNo like '%" + teacherNo + "%'";
    	if(!teacherName.equals("")) where = where + " and t_teacher.teacherName like '%" + teacherName + "%'";
    	if(!birthDate.equals("")) where = where + " and t_teacher.birthDate like '%" + birthDate + "%'";
    	if(!zhicheng.equals("")) where = where + " and t_teacher.zhicheng like '%" + zhicheng + "%'";
    	if(!telephone.equals("")) where = where + " and t_teacher.telephone like '%" + telephone + "%'";
    	return teacherMapper.queryTeacherList(where);
    }

    /*查询所有教师记录*/
    public ArrayList<Teacher> queryAllTeacher()  throws Exception {
        return teacherMapper.queryTeacherList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String teacherNo,String teacherName,String birthDate,String zhicheng,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!teacherNo.equals("")) where = where + " and t_teacher.teacherNo like '%" + teacherNo + "%'";
    	if(!teacherName.equals("")) where = where + " and t_teacher.teacherName like '%" + teacherName + "%'";
    	if(!birthDate.equals("")) where = where + " and t_teacher.birthDate like '%" + birthDate + "%'";
    	if(!zhicheng.equals("")) where = where + " and t_teacher.zhicheng like '%" + zhicheng + "%'";
    	if(!telephone.equals("")) where = where + " and t_teacher.telephone like '%" + telephone + "%'";
        recordNumber = teacherMapper.queryTeacherCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取教师记录*/
    public Teacher getTeacher(String teacherNo) throws Exception  {
        Teacher teacher = teacherMapper.getTeacher(teacherNo);
        return teacher;
    }

    /*更新教师记录*/
    public void updateTeacher(Teacher teacher) throws Exception {
        teacherMapper.updateTeacher(teacher);
    }

    /*删除一条教师记录*/
    public void deleteTeacher (String teacherNo) throws Exception {
        teacherMapper.deleteTeacher(teacherNo);
    }

    /*删除多条教师信息*/
    public int deleteTeachers (String teacherNos) throws Exception {
    	String _teacherNos[] = teacherNos.split(",");
    	for(String _teacherNo: _teacherNos) {
    		teacherMapper.deleteTeacher(_teacherNo);
    	}
    	return _teacherNos.length;
    }
}
