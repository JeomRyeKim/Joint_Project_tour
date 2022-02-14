package com.oracle.tour.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.tour.dto.Contents;
import com.oracle.tour.dto.Contents_like;
import com.oracle.tour.dto.Contents_like_contents;
import com.oracle.tour.dto.Member;

@Repository
public class WHDaoImpl implements WHDao {
	private final SqlSession sqlSession;
	@Autowired
	public WHDaoImpl(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	@Override
	public Member login(Member member) {
		System.out.println("WHODaolmpl login start...");
		try {
			member=sqlSession.selectOne("WHLogin",member);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	@Override
	public void memberJoin(Member member) {
		System.out.println("WHODaolmpl memberJoin start...");
		try {
			sqlSession.insert("WHjoin",member);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	@Override
	public int idCheck(String m_id) {
		System.out.println("WHODaolmpl idCheck start...");	
		int result=0;
		try {
			result=sqlSession.selectOne("WHidCheck",m_id);
			System.out.println(result);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public Member myInfo(Member member) {
		System.out.println("WHODaolmpl myInfo start...");
		try {
			member=sqlSession.selectOne("WHmyInfo",member);
			System.out.println("member.m_password->"+member.getM_password());
			String m_phone1 = member.getM_phone().substring(0,3);
			String m_phone2 = member.getM_phone().substring(3,7);
			String m_phone3 = member.getM_phone().substring(7,11);
			member.setM_phone1(m_phone1);
			member.setM_phone2(m_phone2);
			member.setM_phone3(m_phone3);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	@Override
	public void pwChange(Member member) {
		System.out.println("WHODaolmpl pwChange start...");
		try {
			sqlSession.update("WHpwChange",member);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@Override
	public int memberFind(Member member) {
		System.out.println("WHODaolmpl memberFind start..");
		int result =0;
		try {
			result=sqlSession.selectOne("WHemailCheck", member);
			if(result==1) {
			sqlSession.update("WHTpPw",member);
			}else {
				System.out.println("잘못된 이메일입니다");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public void InfoChange(Member member) {
		System.out.println("WHODaolmpl InfoChange start...");
		try {
			sqlSession.update("WHInfoCh",member);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	@Override
	public void memberLeave(String m_id) {
		System.out.println("WHODaolmpl memberLeave stat...");
		try {
			sqlSession.update("WHMemberLv",m_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	@Override
	public List<Contents_like_contents> c_noList(String m_id) {
		System.out.println("WHODaolmpl c_noList start...");
		List<Contents_like_contents> c_noLists = new ArrayList<>();
		try {
			c_noLists=sqlSession.selectList("WHCnoList", m_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return c_noLists;
	}
	@Override
	public List<Contents_like_contents> c_List(Contents_like_contents contents_likes) {
		System.out.println("WHODaolmpl c_noList start...");
		List<Contents_like_contents> c_noLists = new ArrayList<>();
		try {
			c_noLists=sqlSession.selectList("WHSearchList", contents_likes);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return c_noLists;
	}
	@Override
	public void wishListDelete(Contents_like_contents content) {
		System.out.println("WHODaolmpl wishListDelete start...");
		try {
			sqlSession.update("WHlistDelete",content);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
}
