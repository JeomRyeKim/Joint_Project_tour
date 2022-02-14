package com.oracle.tour.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.tour.dao.CJDao;

@Service
public class CJServiceImpl implements CJService {
	private final CJDao cjDao;
	@Autowired
	public CJServiceImpl(CJDao cjDao) {
		this.cjDao = cjDao;
	}
	

}
