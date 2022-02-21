package com.oracle.tour.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.oracle.tour.service.Admin_Interceptor;



@Configuration
public class TourConfiguration implements WebMvcConfigurer {
	//interCeptor
	
	  public void addInterceptors(InterceptorRegistry registry) {
		  registry.addInterceptor(new Admin_Interceptor()).addPathPatterns("/updateContentForm").addPathPatterns("/uploadContentForm");
		  //.addPathPatterns("/???").addPathPatterns("/????") ; }
	  }
	 
}
