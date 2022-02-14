package com.oracle.tour.service;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Paging {
	private int currentPage = 1;	private int rowPage = 10;
	private int pageBlock = 10;		
	private int start;				private int end;
	private int startPage;			private int endPage;
	private int total;				private int totalPage;
	//				   42				2
	public Paging(int total, String currentPage1) {
		this.total = total;
		if(currentPage1 != null) {
			this.currentPage = Integer.parseInt(currentPage1);
		}
		start = (currentPage - 1) * rowPage + 1; 	// 시작시 1	11
		end = start + rowPage - 1;					// 시작시 10	20
		totalPage = (int)Math.ceil((double)total / rowPage);		// 시작시 2	5 (ceil : 높임,올림)
		//아래 페이징  시작 넘버	   2				2				 10
		startPage = currentPage - (currentPage - 1) % pageBlock;	// 시작시 1	1  //currentPage - 1 % pageBlock 후에 -currentPage
		endPage = startPage + pageBlock - 1;	
		if(endPage > totalPage) { // 공갈 페이지를 없애기 위한 작업
			endPage = totalPage;
		}
	}
	
}
