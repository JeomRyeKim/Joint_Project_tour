package com.oracle.tour.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;



@Configuration
public class TourConfiguration implements WebMvcConfigurer {
	//interCeptor
	/*
	 * public void addInterceptors(InterceptorRegistry registry) {
	 * registry.addInterceptor(new
	 * SampleInterceptor()).addPathPatterns("/interCeptor")//.addPathPatterns("/???"
	 * ).addPathPatterns("/????") ; }
	 */
}
