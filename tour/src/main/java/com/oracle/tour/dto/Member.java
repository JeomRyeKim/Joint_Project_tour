package com.oracle.tour.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Member {
	private String m_id;				// 회원 id
	private int    m_kind;				// 회원 유형 - 1:사용자, 2:관리자..
	private int    m_active_kind;		// 활동 여부 - 1:활동중인 회원, 2:탈퇴한 회원
	private String m_nickname;			// 회원 닉네임
	private String m_password;			// 회원 비밀번호
	private String m_phone;				// 회원 폰번호
	private String m_phone1;
	private String m_phone2;
	private String m_phone3;
	private String m_email;				// 회원 이메일
	private String m_birth;				// 회원 생일
	private String m_gender;			// 회원 성별
	private String m_password_hint;		// 비밀번호 찾을 때 힌트
	private String m_password_answer;	// 비밀번호 힌트에 대한 답
	private String m_date;				// 회원 가입일
}
