package com.oracle.tour.dao;

import java.util.List;

import com.oracle.tour.dto.Contents;
import com.oracle.tour.dto.Contents_like;
import com.oracle.tour.dto.Contents_like_contents;
import com.oracle.tour.dto.Member;

public interface WHDao {

	Member login(Member member);
	void memberJoin(Member member);
	int idCheck(String m_id);
	Member myInfo(Member member);
	void pwChange(Member member);
	int memberFind(Member member);
	void InfoChange(Member member);
	void memberLeave(String m_id);
	List<Contents_like_contents> c_noList(String m_id);
	List<Contents_like_contents> c_List(Contents_like_contents contents_likes);
	void wishListDelete(Contents_like_contents content);
}
