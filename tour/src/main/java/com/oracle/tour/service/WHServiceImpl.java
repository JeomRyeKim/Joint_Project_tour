package com.oracle.tour.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.tour.dao.WHDao;
import com.oracle.tour.dto.Contents;
import com.oracle.tour.dto.Contents_like;
import com.oracle.tour.dto.Contents_like_contents;
import com.oracle.tour.dto.Member;

@Service
@Transactional
public class WHServiceImpl implements WHService {
	private final WHDao whDao;
	@Autowired
	public WHServiceImpl(WHDao whDao) {
		this.whDao = whDao;
	}
	@Override
	public Member login(Member member) {
		System.out.println("WHServiceImpl login start..");
		return member=whDao.login(member);
	}
	@Override
	public void memberJoin(Member member) {
		System.out.println("WHServiceImpl memberJoin start...");
		whDao.memberJoin(member);
		
	}
	@Override
	public int idCheck(String m_id) {
		System.out.println("WHServiceImpl idCheck start...");
		int result=0;
		result=whDao.idCheck(m_id);
		return result;
	}
	@Override
	public Member myInfo(Member member) {
		System.out.println("WHServiceImpl myInfo start..");
		member=whDao.myInfo(member);
		return member;
	}
	@Override
	public void pwChange(Member member) {
		System.out.println("WHServiceImpl pwChange start... ");
		whDao.pwChange(member);
	}
	@Override
	public void InfoChange(Member member) {
		System.out.println("WHServiceImpl InfoChange start.." );
		whDao.InfoChange(member);
	}
	@Override
	public void memberLeave(String m_id) {
		System.out.println("WHServiceImpl memberLeave start..");
		whDao.memberLeave(m_id);
		
	}
	@Override
	public List<Contents_like_contents> c_noList(String m_id) {
		System.out.println("WHServiceImpl c_noList start...");
		List<Contents_like_contents> c_noLists = new ArrayList<>();
		c_noLists=whDao.c_noList(m_id);
		return c_noLists;
	}
	@Override
	public List<Contents_like_contents> c_List(Contents_like_contents contents_likes) {
		System.out.println("WHServiceImpl c_List start...");
		List<Contents_like_contents> c_noLists = new ArrayList<>();
		c_noLists=whDao.c_List(contents_likes);
		return c_noLists;
	}
	@Override
	public void wishListDelete(Contents_like_contents content) {
		System.out.println("WHServiceImpl wishListDelete start...");
		whDao.wishListDelete(content);
	}

	
	

	
}
