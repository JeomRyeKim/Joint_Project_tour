package com.oracle.tour.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.oracle.tour.service.CJService;

@Controller
public class CJController {
	private static final Logger logger = LoggerFactory.getLogger(CJController.class);
	private final CJService cjService;
	@Autowired
	public CJController(CJService cjService) {
		super();
		this.cjService = cjService;
	}

	
}
