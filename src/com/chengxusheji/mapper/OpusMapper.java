package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Opus;

public interface OpusMapper {
	/*添加学生成果信息*/
	public void addOpus(Opus opus) throws Exception;

	/*按照查询条件分页查询学生成果记录*/
	public ArrayList<Opus> queryOpus(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有学生成果记录*/
	public ArrayList<Opus> queryOpusList(@Param("where") String where) throws Exception;

	/*按照查询条件的学生成果记录数*/
	public int queryOpusCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条学生成果记录*/
	public Opus getOpus(int opusId) throws Exception;

	/*更新学生成果记录*/
	public void updateOpus(Opus opus) throws Exception;

	/*删除学生成果记录*/
	public void deleteOpus(int opusId) throws Exception;

}
