package com.oracle.tour.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class Admin_Interceptor implements HandlerInterceptor {

	//1번
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("Post handle....................");
		String m_id = (String)modelAndView.getModel().get("m_id");
		System.out.println("m_id : "+m_id);
		
		if("admin".equals(m_id)) {	
			
		}else {
			response.sendRedirect("/");
		}
	}

}
