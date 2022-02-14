package com.oracle.tour.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ECDaoImpl implements ECDao {
	private final SqlSession sqlSession;
	@Autowired
	public ECDaoImpl(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
}
