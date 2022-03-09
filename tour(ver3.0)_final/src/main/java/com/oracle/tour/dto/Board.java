package com.oracle.tour.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Board {
	private int    b_kind;			// 게시판 유형 - 1:자유게시판, 2:후기게시판, 3:고객센터, 4:공지글
	private int    b_no;			// 게시판 번호
	private String m_id;			// 회원 id
	private String b_title;			// 게시판 제목
	private String b_contents;		// 게시판 내용
	private Date   b_date;			// 게시판 작성일
	private int    b_hit;			// 게시판 조회수
	private String b_filename;		// 게시판 파일(이미지)
	private int	   b_Group;			// 게시판 그룹
	private int	   b_Step;			// 게시판 순서
	private int	   b_Indent;		// 게시판 들여쓰기
	private int	   b_notice;		// 게시판 공지글 여부 - 1:일반글, 2:공지글
	private String b_lock;			// 게시판 비밀글 여부 - n:공개글, y:비공개글
	private int    b_like_cnt;		// 게시판 좋아요 개수
	private int    b_commentCnt;	// 게시판 댓글 개수
	
	//조회용
	private int start;				// 페이징처리
	private int end;				// 페이징 처리
	private String m_nickname;		// 회원 닉네임 - 게시판 리스트에서 조회
	private String searchType;		// 검색 종류 - 제목, 내용, 글쓴이 닉네임
	private String keyword;			// 검색란에 입력하는 값
	private int    m_active_kind;	// 활동 여부 - 1:활동중인 회원, 2:임시 회원, 3:탈퇴한 회원
	private int    m_kind;			// 회원 유형 - 1:사용자, 2:관리자..
	
}
