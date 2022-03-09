package com.oracle.tour.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Contents_like {
	private int c_no;			// 컨텐츠 번호
	private String m_id;		// 회원 번호
	private int c_like_cnt;		// 컨텐츠 좋아요 개수
	private int Cart;			// 찜 여부
}
