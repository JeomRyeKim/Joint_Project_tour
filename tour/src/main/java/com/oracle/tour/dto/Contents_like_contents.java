package com.oracle.tour.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Contents_like_contents {
	private int c_no;			// 컨텐츠 번호
	private String m_id;		// 회원 번호
	private int c_like_cnt;		// 컨텐츠 좋아요 개수
	private int Cart;			// 찜 여부
	
	//찜목록 리스트
	private String c_title;			// 제목
	private String c_description;	// 지역 설명
	private String c_image1;		// 이미지1
	private String c_local;			// 지역 - 도 이름
	private String keyword;			//키워드 검색시
	
	private List<Contents_like_contents> contents_likes;
	
	
}
