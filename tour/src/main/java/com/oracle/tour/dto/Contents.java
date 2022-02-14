package com.oracle.tour.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Contents {
	private int    c_no;			// 컨텐츠 번호
	private String c_local;			// 지역 - 도 이름
	private String c_category;		// 카테고리 - 관광지,숙소,맛집
	private String c_sigungu_code;	// 시군구 코드
	private String c_zipcode;		// 우편번호
	private String c_address;		// 주소
	private String c_title;			// 제목
	private String c_description;	// 지역 설명
	private double c_map_x;			// 위도
	private double c_map_y;			// 경도
	private String c_image1;		// 이미지1
	private String c_image2;		// 이미지2
	private String c_image3;		// 이미지3
}
