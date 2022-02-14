package com.oracle.tour.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.tour.dao.DWDao;

@Service
@Transactional
public class DWServiceImpl implements DWService {
	private final DWDao dwDao;
	@Autowired
	public DWServiceImpl(DWDao dwDao) {
		this.dwDao = dwDao;
	}
	

}
