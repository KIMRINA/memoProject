package com.memo.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CommonDAOImpl implements CommonDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.memo.mappers.CommonMapper";

	@Override
	public int selectCompareTime(String time) {
		return session.selectOne(namespace + ".selectCompareTime", time);
	}

}
