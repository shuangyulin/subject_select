package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Teacher;

public interface TeacherMapper {
	/*添加教师信息*/
	public void addTeacher(Teacher teacher) throws Exception;

	/*按照查询条件分页查询教师记录*/
	public ArrayList<Teacher> queryTeacher(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有教师记录*/
	public ArrayList<Teacher> queryTeacherList(@Param("where") String where) throws Exception;

	/*按照查询条件的教师记录数*/
	public int queryTeacherCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条教师记录*/
	public Teacher getTeacher(String teacherNo) throws Exception;

	/*更新教师记录*/
	public void updateTeacher(Teacher teacher) throws Exception;

	/*删除教师记录*/
	public void deleteTeacher(String teacherNo) throws Exception;

}
