package com.oracle.tour.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Board_comment {
	private int    b_kind;		// 게시판 유형 - 1:자유게시판, 2:후기게시판, 3:고객센터, 4:공지글
	private int    b_no;		// 게시판 번호
	private String m_id;		// 회원 id
	private int    bc_no;		// 댓글 번호
	private String bc_contents;	// 댓글 내용
	private String bc_date;		// 댓글 입력일
	private int    bc_Group;	// 댓글 그룹
	private int    bc_Step;		// 댓글 순서
	private int    bc_Indent;	// 댓글 들여쓰기
	private String bc_lock;		// 댓글 비밀글 여부 - n:공개글, y:비공개글
	
	// 조회용
	private String m_nickname;	// 회원 닉네임
	private int    m_kind;		// 회원 유형 - 1:사용자, 2:관리자..
	private int    groupCnt;	// 삭제할 때 같은 그룹이면서 나보다 늦게 대댓글을 작성한 댓글 개수

}
