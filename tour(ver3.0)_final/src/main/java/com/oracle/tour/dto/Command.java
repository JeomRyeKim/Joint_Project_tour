package com.oracle.tour.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Command {
	private int    c_no;			// 컨텐츠 번호
	private String m_id;			// 회원 아이디
	private int    com_no;			// 댓글 번호
	private String com_contents;	// 댓글 내용
	private int    com_Group;		// 댓글 그룹
	private int    com_Step;		// 댓글 순서
	private int    com_Indent;		// 댓글 들여쓰기
	
	//조회용
	private String m_nickname;
}
