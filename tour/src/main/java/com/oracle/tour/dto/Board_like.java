package com.oracle.tour.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Board_like {
	private int    b_kind;			// 게시판(댓굴) 유형 - 1:자유게시판, 2:후기게시판, 3:고객센터, 4:공지글, 5:게시글 댓글
	private int    b_no;			// 게시판(댓글) 번호
	private String m_id;			// 회원 번호
	private String b_like_check;	// 좋아요 여부 - n:싫어요, y:좋아요
}
