package com.oracle.tour.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CJDaoImpl implements CJDao {
	private final SqlSession sqlSession;
	@Autowired
	public CJDaoImpl(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
}
