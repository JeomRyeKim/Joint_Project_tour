package com.oracle.tour.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DWDaoImpl implements DWDao {
	private final SqlSession sqlSession;
	@Autowired
	public DWDaoImpl(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
}
