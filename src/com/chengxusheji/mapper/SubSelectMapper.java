package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.SubSelect;

public interface SubSelectMapper {
	/*添加学生选题信息*/
	public void addSubSelect(SubSelect subSelect) throws Exception;

	/*按照查询条件分页查询学生选题记录*/
	public ArrayList<SubSelect> querySubSelect(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有学生选题记录*/
	public ArrayList<SubSelect> querySubSelectList(@Param("where") String where) throws Exception;

	/*按照查询条件的学生选题记录数*/
	public int querySubSelectCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条学生选题记录*/
	public SubSelect getSubSelect(int selectId) throws Exception;

	/*更新学生选题记录*/
	public void updateSubSelect(SubSelect subSelect) throws Exception;

	/*删除学生选题记录*/
	public void deleteSubSelect(int selectId) throws Exception;

}
