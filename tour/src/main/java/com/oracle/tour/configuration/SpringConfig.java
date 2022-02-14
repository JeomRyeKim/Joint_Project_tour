package com.oracle.tour.configuration;

import javax.persistence.EntityManager;
import javax.sql.DataSource;

import org.springframework.context.annotation.Configuration;


@Configuration
public class SpringConfig {
	private final DataSource dataSource;
	private final EntityManager em;
	
	public SpringConfig(DataSource dataSource, EntityManager em) {
		this.dataSource = dataSource;
		this.em = em;
	}


}
