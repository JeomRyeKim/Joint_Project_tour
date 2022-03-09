package com.oracle.tour.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.oracle.tour.service.ECService;

@Controller
public class ECController {
	private static final Logger logger = LoggerFactory.getLogger(ECController.class);
	private final ECService ecService;
	@Autowired
	public ECController(ECService ecService) {
		super();
		this.ecService = ecService;
	}


}
