package com.oracle.tour.dao;

import java.util.List;

import com.oracle.tour.dto.Board;
import com.oracle.tour.dto.Command;
import com.oracle.tour.dto.Contents;
import com.oracle.tour.dto.Contents_like;

public interface SHDao {

	List<Contents> getConList(Contents con);

	List<Contents> getTourList();

	List<Contents> getHotelList();

	List<Contents> getFoodList();

	List<Contents> getLocalTourList(String c_local);

	List<Contents> getLocalHotelList(String c_local);

	List<Contents> getLocalFoodList(String c_local);

	Contents getDetailContent(String c_no);

	Contents getLocalCon(String c_local);

	List<Board> getBoardList();

	List<Contents> getAllList(String c_category);

	int getCountAllList(String c_category);

	/* int getCountAllList(Contents con); */

	List<Contents> getLocalAllList(Contents con);

	int getCountLocalAllList(Contents con);

	List<Command> getCommandList(String c_no);

	int writeDetailCom(Command com);

	int deleteCommand(Command com);

	int updateCom(Command com);

	Command showReplyProperty(String com_no);

	int writeReply(Command com);

	int getLikeCnt(String c_no);

	int detailLike(Contents_like conLike);

	int cancelLike(Contents_like con);

	int insertCart(Contents_like con);

	int checkMember(Contents_like con);

	int updateCart(Contents_like con);

	int getCartCnt(String c_no,String m_id);

	int deleteCart(Contents_like con);

	int getMemberLikeCnt(String c_no, String m_id);

	int ajaxLike(Contents_like con);

	int updateLike(Contents_like con);

	int updateInsertLike(Contents_like conLike);

	int uploadContents(Contents con);

	int deleteContent(String c_no);

	int updateContent(Contents con);

	List<Contents> getUpdateLocalList();

	List<Contents> getUpdateCategoryList();

	List<Contents> getSearchList(String search);

	int getCountSearchList(String search);

	int getCommandCnt(String c_no);

	List<Contents> getAllLocalList(String c_local);

	Contents getCountAllCon(Contents con);


}
