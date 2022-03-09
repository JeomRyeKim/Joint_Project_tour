package com.oracle.tour.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.tour.dao.ECDao;

@Service
@Transactional
public class ECServiceImpl implements ECService {
	private final ECDao ecDao;
	@Autowired
	public ECServiceImpl(ECDao ecDao) {
		this.ecDao = ecDao;
	}
	

}
