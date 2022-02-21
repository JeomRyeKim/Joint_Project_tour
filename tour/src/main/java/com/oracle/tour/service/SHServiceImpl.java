package com.oracle.tour.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.tour.dao.SHDao;
import com.oracle.tour.dto.Board;
import com.oracle.tour.dto.Command;
import com.oracle.tour.dto.Contents;
import com.oracle.tour.dto.Contents_like;

@Service
@Transactional
public class SHServiceImpl implements SHService {
	private final SHDao shDao;
	@Autowired
	public SHServiceImpl(SHDao shDao) {
		this.shDao = shDao;
	}
	@Override
	public List<Contents> getConList(Contents con) {
		List<Contents> conList = null;
		System.out.println("SHServiceImpl getConList Start..");
		conList = shDao.getConList(con);
		return conList;
	}
	@Override
	public List<Contents> getTourList() {
		List<Contents> tourList = null;
		System.out.println("SHServiceImpl getTourList Start..");
		tourList =shDao.getTourList();
		return tourList;
	}
	@Override
	public List<Contents> getHotelList() {
		List<Contents> hotelList = null;
		System.out.println("SHServiceImpl getHotelList Start..");
		hotelList =shDao.getHotelList();
		return hotelList;
	}
	@Override
	public List<Contents> getFoodList() {
		List<Contents> foodList = null;
		System.out.println("SHServiceImpl getFoodList Start..");
		foodList =shDao.getFoodList();
		return foodList;
	}
	@Override
	public List<Board> getBoardList() {
		System.out.println("SHServiceImpl getBoardList Start..");
		List<Board> boardlist = shDao.getBoardList();
		return boardlist;
	}
	
	@Override
	public Contents getLocalCon(String c_local) {
		System.out.println("SHServiceImpl getLocalList Start..");
		Contents localCon = shDao.getLocalCon(c_local);
		return localCon;
	}
	
	@Override
	public List<Contents> getlocalTourList(String c_local) {
		List<Contents> localTourList = null;
		System.out.println("SHServiceImpl getlocalList Start..");
		localTourList = shDao.getLocalTourList(c_local);
		return localTourList;
	}
	@Override
	public List<Contents> getlocalHotelList(String c_local) {
		List<Contents> localHotelList = null;
		System.out.println("SHServiceImpl getlocalList Start..");
		localHotelList = shDao.getLocalHotelList(c_local);
		return localHotelList;
	}
	@Override
	public List<Contents> getlocalFoodList(String c_local) {
		List<Contents> localFoodList = null;
		System.out.println("SHServiceImpl getlocalList Start..");
		localFoodList = shDao.getLocalFoodList(c_local);
		return localFoodList;
	}
	@Override
	public Contents getDetailContent(String c_no) {
		System.out.println("SHServiceImpl getDetailList Start..");
		Contents detailContent = shDao.getDetailContent(c_no);
		return detailContent;
	}
	@Override
	public List<Contents> getAllList(String c_category) {
		System.out.println("SHServiceImpl AllList Start..");
		List<Contents> allList = shDao.getAllList(c_category);
		return allList;
	}
	@Override
	public int getCountAllList(String c_category) {
		System.out.println("SHServiceImpl CountAllList Start..");
		int result = shDao.getCountAllList(c_category);
		return result;
	}
	
	@Override
	public int getCountLocalAllList(Contents con) {
		System.out.println("SHServiceImpl CountLocalAllList Start..");
		int result = shDao.getCountLocalAllList(con);
		return result;
	}
	@Override
	public List<Contents> getLocalAllList(Contents con) {
		System.out.println("SHServiceImpl CountAllList Start..");
		List<Contents> allLocalList = null;
		allLocalList = shDao.getLocalAllList(con);
		return allLocalList;
	}
	@Override
	public List<Command> getCommandList(String c_no) {
		System.out.println("SHServiceImpl Command Start..");
		List<Command> comList= shDao.getCommandList(c_no);
		return comList;
	}
	@Override
	public int WriteDetailCom(Command com) {
		System.out.println("SHServiceImpl WriteDetailCom Start..");
		int result = shDao.writeDetailCom(com);
		return result;
	}
	@Override
	public int deleteCommand(Command com) {
		System.out.println("SHServiceImpl deleteCommand Start..");
		int result = shDao.deleteCommand(com);
		return result;
	}
	@Override
	public int updateCom(Command com) {
		System.out.println("SHServiceImpl updateCom Start..");
		int result = shDao.updateCom(com);
		return result;
	}
	@Override
	public Command showReplyProperty(String com_no) {
		System.out.println("SHServiceImpl showReplyProperty Start..");
		Command com = shDao.showReplyProperty(com_no);
		return com;
	}
	@Override
	public int writeReply(Command com) {
		System.out.println("SHServiceImpl writeReply Start..");
		int result = shDao.writeReply(com);
		return result;
	}
	@Override
	public int getLikeCnt(String c_no) {
		System.out.println("SHServiceImpl getLikeCnt Start..");
		int likeCnt = shDao.getLikeCnt(c_no);
		return likeCnt;
	}
	@Override
	public int detailLike(Contents_like conLike) {
		System.out.println("SHServiceImpl detailLike Start..");
		int result= shDao.detailLike(conLike);
		return result;
		
	}
	
	@Override
	public int cancelLike(Contents_like con) {
		System.out.println("SHServiceImpl cancelLike Start..");
		int result = shDao.cancelLike(con);
		return result;
	}
	@Override
	public int insertCart(Contents_like con) {
		System.out.println("SHServiceImpl insertCart Start..");
		int result = shDao.insertCart(con);
		return result;
	}
	@Override
	public int checkMember(Contents_like con) {
		System.out.println("SHServiceImpl checkMember Start..");
		int result = shDao.checkMember(con);
		return result;
	}
	@Override
	public int updateCart(Contents_like con) {
		System.out.println("SHServiceImpl updateCart Start..");
		int result = shDao.updateCart(con);
		return result;
	}
	@Override
	public int getCartCnt(String c_no,String m_id) {
		System.out.println("SHServiceImpl getCartCnt Start..");
		int cartCnt = shDao.getCartCnt(c_no,m_id);
		return cartCnt;
	}
	@Override
	public int deleteCart(Contents_like con) {
		System.out.println("SHServiceImpl deleteCart Start..");
		int result = shDao.deleteCart(con);
		return result;
	}
	@Override
	public int getMemberLikeCnt(String c_no, String m_id) {
		System.out.println("SHServiceImpl getMemberLikeCnt Start..");
		int memberLikeCnt = shDao.getMemberLikeCnt(c_no,m_id);
		return memberLikeCnt;
	}
	@Override
	public int ajaxLike(Contents_like con) {
		System.out.println("SHServiceImpl ajaxLike Start..");
		int result = shDao.ajaxLike(con);
		return result;
	}
	@Override
	public int updateLike(Contents_like con) {
		System.out.println("SHServiceImpl updateLike Start..");
		int result = shDao.updateLike(con);
		return result;
	}
	@Override
	public int updateInsertLike(Contents_like conLike) {
		System.out.println("SHServiceImpl updateInsertLike Start..");
		int result = shDao.updateInsertLike(conLike);
		return result;
	}
	@Override
	public int uploadContent(Contents con) {
		int result = shDao.uploadContents(con);
		return result;
	}
	@Override
	public int deleteContent(String c_no) {
		int result = shDao.deleteContent(c_no);
		return result;
	}
	@Override
	public int updateContent(Contents con) {
		int result = shDao.updateContent(con);
		return result;
	}
	@Override
	public List<Contents> getUpdateLocalList() {
		List<Contents> localList = shDao.getUpdateLocalList();
		return localList;
	}
	@Override
	public List<Contents> getUpdateCategoryList() {
		List<Contents> categoryList = shDao.getUpdateCategoryList();
		return categoryList;
	}
	@Override
	public List<Contents> getSearchList(String search) {
		List<Contents> searchList = shDao.getSearchList(search);
		return searchList;
	}
	@Override
	public int getCountSearchList(String search) {
		int result = shDao.getCountSearchList(search);
		return result;
	}
	@Override
	public int getCommandCnt(String c_no) {
		int result = shDao.getCommandCnt(c_no);
		return result;
	}
	@Override
	public List<Contents> getAllLocalList(String c_local) {
		List<Contents> localList = shDao.getAllLocalList(c_local);
		return localList;
	}
	@Override
	public Contents getCountAllCon(Contents con) {
		Contents con1 = shDao.getCountAllCon(con);
		return con1;
	}


	

}
