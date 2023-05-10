package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.SubjectType;

public interface SubjectTypeMapper {
	/*添加题目类型信息*/
	public void addSubjectType(SubjectType subjectType) throws Exception;

	/*按照查询条件分页查询题目类型记录*/
	public ArrayList<SubjectType> querySubjectType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有题目类型记录*/
	public ArrayList<SubjectType> querySubjectTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的题目类型记录数*/
	public int querySubjectTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条题目类型记录*/
	public SubjectType getSubjectType(int typeId) throws Exception;

	/*更新题目类型记录*/
	public void updateSubjectType(SubjectType subjectType) throws Exception;

	/*删除题目类型记录*/
	public void deleteSubjectType(int typeId) throws Exception;

}
