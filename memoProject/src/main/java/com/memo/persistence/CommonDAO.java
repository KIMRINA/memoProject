package com.memo.persistence;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommonDAO {
	
	public int selectCompareTime(String time);
	
}
