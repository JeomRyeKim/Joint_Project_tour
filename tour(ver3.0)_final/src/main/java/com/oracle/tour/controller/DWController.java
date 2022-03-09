package com.oracle.tour.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.oracle.tour.service.CJService;
import com.oracle.tour.service.DWService;

@Controller
public class DWController {
	private static final Logger logger = LoggerFactory.getLogger(DWController.class);
	private final DWService dwService;
	@Autowired
	public DWController(DWService dwService) {
		this.dwService = dwService;
	}
	
	
	
}
