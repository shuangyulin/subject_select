package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Subject;

public interface SubjectMapper {
	/*添加论文题目信息*/
	public void addSubject(Subject subject) throws Exception;

	/*按照查询条件分页查询论文题目记录*/
	public ArrayList<Subject> querySubject(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有论文题目记录*/
	public ArrayList<Subject> querySubjectList(@Param("where") String where) throws Exception;

	/*按照查询条件的论文题目记录数*/
	public int querySubjectCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条论文题目记录*/
	public Subject getSubject(int subjectId) throws Exception;

	/*更新论文题目记录*/
	public void updateSubject(Subject subject) throws Exception;

	/*删除论文题目记录*/
	public void deleteSubject(int subjectId) throws Exception;

}
