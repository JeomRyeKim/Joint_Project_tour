package com.oracle.tour.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.tour.dto.Board;
import com.oracle.tour.dto.Command;
import com.oracle.tour.dto.Contents;
import com.oracle.tour.dto.Contents_like;

@Repository
public class SHDaoImpl implements SHDao {
	private final SqlSession session;
	@Autowired
	public SHDaoImpl(SqlSession session) {
		this.session = session;
	}
	
	//전체 리스트 뽑기
	@Override
	public List<Contents> getConList(Contents con) {
		System.out.println("SHDaoImpl getConList Start..");
		List<Contents> conList = null;
		try {
			conList = session.selectList("SHGetConList",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getConList Error->"+e.getMessage());
		}
		return conList;
	}
	
	//전체 관광지 리스트 뽑기
	@Override
	public List<Contents> getTourList() {
		System.out.println("SHDaoImpl getTourList Start..");
		List<Contents> tourList = null;
		try {
			tourList = session.selectList("SHTourList");
		} catch (Exception e) {
			System.out.println("SHDaoImpl getTourList Error->"+e.getMessage());
		}
		return tourList;
	}

	//전체 숙소 리스트 뽑기
	@Override
	public List<Contents> getHotelList() {
		System.out.println("SHDaoImpl getHotelList Start..");
		List<Contents> hotelList = null;
		try {
			hotelList = session.selectList("SHHotelList");
		} catch (Exception e) {
			System.out.println("SHDaoImpl getHotelList Error->"+e.getMessage());
		}
		return hotelList;
	}

	//전체 음식점 리스트 뽑기
	@Override
	public List<Contents> getFoodList() {
		System.out.println("SHDaoImpl getFoodList Start..");
		List<Contents> foodList = null;
		try {
			foodList = session.selectList("SHFoodList");
		} catch (Exception e) {
			System.out.println("SHDaoImpl getHotelList Error->"+e.getMessage());
		}
		return foodList;
	}
	
	//전체 게시글 리스트 뽑기
	@Override
	public List<Board> getBoardList() {
		System.out.println("SHDaoImpl getBoardList Start..");
		List<Board> boardList = null;
		try {
			boardList = session.selectList("SHBoardList");
		} catch (Exception e) {
			System.out.println("SHDaoImpl getBoardList Error->"+e.getMessage());
		}
		return boardList;
	}
	
	//해당 지역 전체 리스트 뽑기
	@Override
	public Contents getLocalCon(String c_local) {
		System.out.println("SHDaoImpl getLocalList Start..");
		Contents localCon = null;
		try {
			localCon = session.selectOne("SHLocalCon",c_local);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getLocalCon Error->"+e.getMessage());
		}
		return localCon;
	}
	// 해당 지역 관광지 리스트 뽑기
	@Override
	public List<Contents> getLocalTourList(String c_local) {
		System.out.println("SHDaoImpl getLocalTourList Start..");
		List<Contents> localTourList = null;
		try {
			localTourList = session.selectList("SHLocalTourList",c_local);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getLocalTourList Error->"+e.getMessage());
		}
		return localTourList;
	}
	// 해당 지역 숙소 리스트 뽑기
	@Override
	public List<Contents> getLocalHotelList(String c_local) {
		System.out.println("SHDaoImpl getLocalHotelList Start..");
		List<Contents> localHotelList = null;
		try {
			localHotelList = session.selectList("SHLocalHotelList",c_local);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getLocalHotelList Error->"+e.getMessage());
		}
		return localHotelList;
	}
	// 해당 지역 음식점 리스트 뽑기
	@Override
	public List<Contents> getLocalFoodList(String c_local) {
		System.out.println("SHDaoImpl getLocalFoodList Start..");
		List<Contents> localFoodList = null;
		try {
			localFoodList = session.selectList("SHLocalFoodList",c_local);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getLocalFoodList Error->"+e.getMessage());
		}
		return localFoodList;
	}

	// c_no로 상세페이지 데이터 뽑기
	@Override
	public Contents getDetailContent(String c_no) {
		Contents detailContent = null;
		System.out.println("SHDaoImpl getDetailContent Start..");
		try {
			detailContent = session.selectOne("SHDetailContent",c_no);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getDetailContent ERRER->"+e.getMessage());
		}
		return detailContent;
	}
	
	// (index) 전체보기 >> 해당 카테고리 전체 리스트 뽑기

	@Override
	public List<Contents> getAllList(String c_category) {
		System.out.println("SHDaoImpl AllList Start..");
		List<Contents> allList = null;
		try {
			allList = session.selectList("SHAllList",c_category);
		} catch (Exception e) {
			System.out.println("SHDaoImpl AllList Error->" + e.getMessage());
		}
		return allList;
	}

	// (index) 전체보기 >> 해당 카테고리 전체 칼럼 수 뽑기 
	@Override
	public int getCountAllList(String c_category) {
		System.out.println("SHDaoImpl CountAllList Start..");
		int result = 0;
		try {
			result = session.selectOne("SHCountAllList",c_category);
		} catch (Exception e) {
			System.out.println("SHDaoImpl CountAllList Error->"+e.getMessage());
		}
		return result;
	}
	
//	@Override
/*	public int getCountAllList(Contents con) {
		System.out.println("SHDaoImpl CountLocalAllList Start..");
		int result = 0;
		try {
			result = session.selectOne("SHCountAllLocalList",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl CountLocalAllList Error->"+e.getMessage());
		}
		return result;
	}*/

	// (local) 전체보기 >> 해당 지역 카테고리 전체 리스트 뽑기
	@Override
	public List<Contents> getLocalAllList(Contents con) {
		System.out.println("SHDaoImpl AllLoclaList Start..");
		List<Contents> localAllList = null;
		try {
			localAllList = session.selectList("SHLocalAllList",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl LocalAllList Error->" + e.getMessage());
		}
		return localAllList;
	}

	//(local) 전체보기 >> 해당 지역 카테고리 전체 칼럼 수 뽑기
	@Override
	public int getCountLocalAllList(Contents con) {
		System.out.println("SHDaoImpl CountLocalAllList Start..");
		int result = 0;
		try {
			result = session.selectOne("SHCountAllLocalList",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl CountLocalAllList Error->"+e.getMessage());
		}
		return result;
	}

	// 컨텐츠 상세 페이지 댓글 리스트 뽑기
	@Override
	public List<Command> getCommandList(String c_no) {
		System.out.println("SHDaoImpl getCommandList Start..");
		List<Command> comList = null;
		try {
			comList = session.selectList("SHCommandList",c_no);
		} catch (Exception e) {
			System.out.println("getCommandList error -> " + e.getMessage());
		}
		return comList;
	}

	// 컨텐츠 상세 페이지 댓글 작성 (insert)
	@Override
	public int writeDetailCom(Command com) {
		System.out.println("SHDaoImpl writeDetailCom Start..");
		int result = 0;
		try {
			result = session.insert("SHWriteDetailCom",com);
		} catch (Exception e) {
			System.out.println("ShDaoImpl writeDetailCom ERROR -> "+e.getMessage());
		}
		return result;
	}
	//댓글삭제
	@Override
	public int deleteCommand(Command com) {
		System.out.println("SHDaoImpl deleteCommand Start..");
		int result = 0;
		try {
			Command command = session.selectOne("SHSelectOneList",com);
			if(command.getCom_Step()==0) {
				result = session.delete("SHDeleteAllCommand",command);
			}else {
				result = session.delete("SHDeleteCommand",command);
			}
		} catch (Exception e) {
			System.out.println("ShDaoImpl deleteCommand ERROR -> "+e.getMessage());
		}
		return result;
	}
	
	//댓글 수정
	@Override
	public int updateCom(Command com) {
		System.out.println("SHDaoImpl updateCom Start..");
		int result = 0;
		try {
			result = session.update("SHUpdateCommand",com);
			session.commit();
		} catch (Exception e) {
			System.out.println("ShDaoImpl updateCom ERROR -> "+e.getMessage());
		}
		return result;
	}

	//댓글 속성 보기
	@Override
	public Command showReplyProperty(String com_no) {
		System.out.println("SHDaoImpl showReplyProperty Start..");
		Command com = null;
		try {
			com = session.selectOne("SHReplyProperty",com_no);
		} catch (Exception e) {
			System.out.println("ShDaoImpl showReplyProperty ERROR -> "+e.getMessage());
		}
		return com;
	}

	//대댓글 작성
	@Override
	public int writeReply(Command com) {
		System.out.println("SHDaoImpl writeReply Start..");
		replyShape(com);
		int result = 0;
		try {
			result = session.insert("SHwriteReply",com);
		} catch (Exception e) {
			System.out.println("SHDaoImpl writeReply Error->"+e.getMessage());
		}
		return result;
	}
	//대댓글 그룹 확인
	private void replyShape(Command com) {
		System.out.println("SHDaoImpl replyShape Start..");
		try {
			session.update("SHreplyShape",com);
		} catch (Exception e) {
			System.out.println("SHDaoImpl replyShape Error ->"+e.getMessage());
		}
	}

	//컨텐츠 좋아요 갯수 가져오기
	@Override
	public int getLikeCnt(String c_no) {
		System.out.println("SHDaoImpl getLikeCnt Start..");
		int likeCnt = 0;
		try {
			likeCnt = session.selectOne("SHGetLikeCnt",c_no);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getLikeCnt Error->"+e.getMessage());
		}
		return likeCnt;
	}

	@Override
	public int detailLike(Contents_like conLike) {
		System.out.println("SHDaoImpl detailLike Start..");
		int result = 0;
		try {
			result = session.insert("SHDetailLike",conLike);
		} catch (Exception e) {
			System.out.println("SHDaoImpl detailLike Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int cancelLike(Contents_like con) {
		System.out.println("SHDaoImpl cancelLike Start..");
		int result = 0;
		try {
			result = session.delete("SHDeleteLike",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl cancelLike Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int insertCart(Contents_like con) {
		System.out.println("SHDaoImpl insertCart Start..");
		int result = 0;
		try {
			result = session.insert("SHGetCart",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getCart Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int checkMember(Contents_like con) {
		System.out.println("SHDaoImpl checkMember Start..");
		int result = 0;
		try {
			result = session.selectOne("SHCheckMember",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl checkMember Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int updateCart(Contents_like con) {
		System.out.println("SHDaoImpl updateCart Start..");
		int result = 0;
		try {
			result = session.update("SHUpdateCart",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl updateCart Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int getCartCnt(String c_no,String m_id) {
		System.out.println("SHDaoImpl getCartCnt Start..");
		int cartCnt = 0;
		Contents_like con = new Contents_like();
		con.setC_no(Integer.parseInt(c_no));
		con.setM_id(m_id);
		System.out.println(c_no);
		System.out.println(m_id);
		try {
			cartCnt = session.selectOne("SHGetCartCnt",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getCartCnt Error->"+e.getMessage());
		}
		return cartCnt;
	}

	@Override
	public int deleteCart(Contents_like con) {
		System.out.println("SHDaoImpl deleteCart Start..");
		int result = 0;
		try {
			result = session.update("SHDeleteCart",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl deleteCart Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int getMemberLikeCnt(String c_no, String m_id) {
		System.out.println("SHDaoImpl getMemberLikeCnt Start..");
		int memberLikeCnt = 0;
		Contents_like con = new Contents_like();
		con.setC_no(Integer.parseInt(c_no));
		con.setM_id(m_id);
		try {
			memberLikeCnt = session.selectOne("SHGetMemberLikeCnt",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getMemberLikeCnt Error->"+e.getMessage());
		}
		return memberLikeCnt;
	}

	@Override
	public int ajaxLike(Contents_like con) {
		System.out.println("SHDaoImpl ajaxLike Start..");
		int result = 0;
		try {
			result = session.selectOne("SHAjaxLike",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl ajaxLike Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int updateLike(Contents_like con) {
		System.out.println("SHDaoImpl updateLike Start..");
		int result = 0;
		try {
			result = session.update("SHUpdateLike",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl updateLike Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int updateInsertLike(Contents_like conLike) {
		System.out.println("SHDaoImpl updateInsertLike Start..");
		int result = 0;
		try {
			result = session.update("SHUpdateInsertLike",conLike);
		} catch (Exception e) {
			System.out.println("SHDaoImpl updateInsertLike Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int uploadContents(Contents con) {
		System.out.println("SHDaoImpl uploadContents Start..");
		int result = 0;
		try {
			result = session.insert("SHUploadContents",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl uploadContents Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int deleteContent(String c_no) {
		System.out.println("SHDaoImpl deleteContent Start..");
		int result = 0;
		try {
			result = session.delete("SHDeleteContent",c_no);
		} catch (Exception e) {
			System.out.println("SHDaoImpl deleteContent Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int updateContent(Contents con) {
		System.out.println("SHDaoImpl updateContent Start..");
		int result = 0;
		try {
			result = session.update("SHUpdateContent",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl updateContent Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public List<Contents> getUpdateLocalList() {
		System.out.println("SHDaoImpl updateContent Start..");
		List<Contents> localList = null;
		try {
			localList = session.selectList("SHGetUpdateLocalList");
		} catch (Exception e) {
			System.out.println("SHDaoImpl updateContent Error->"+e.getMessage());
		}
		return localList;
	}

	@Override
	public List<Contents> getUpdateCategoryList() {
		System.out.println("SHDaoImpl getUpdateCategoryList Start..");
		List<Contents> categoryList = null;
		try {
			categoryList = session.selectList("SHGetUpdateCategoryList");
		} catch (Exception e) {
			System.out.println("SHDaoImpl getUpdateCategoryList Error->"+e.getMessage());
		}
		return categoryList;
	}

	@Override
	public List<Contents> getSearchList(String search) {
		System.out.println("SHDaoImpl getSearchList Start..");
		List<Contents> searchList = null;
		search = search.trim();
		try {
			searchList = session.selectList("SHGetSearchList",search);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getSearchList Error->"+e.getMessage());
		}
		return searchList;
	}

	@Override
	public int getCountSearchList(String search) {
		System.out.println("SHDaoImpl getCountSearchList Start..");
		int result = 0;
		search = search.trim();
		try {
			result = session.selectOne("SHGetCountSearchList",search);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getCountSearchList Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int getCommandCnt(String c_no) {
		System.out.println("SHDaoImpl getCommandCnt Start..");
		int result = 0;
		try {
			result = session.selectOne("SHGetCommandCnt",c_no);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getCommandCnt Error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public List<Contents> getAllLocalList(String c_local) {
		System.out.println("SHDaoImpl getAllLocalList Start..");
		List<Contents> localList = null;
		try {
			localList = session.selectList("SHAllLocalList",c_local);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getAllLocalList Error->" + e.getMessage());
		}
		return localList;
	}

	@Override
	public Contents getCountAllCon(Contents con) {
		System.out.println("SHDaoImpl getCountAllCon Start..");
		Contents con1 = null;
		try {
			con1 = session.selectOne("SHGetCountAllCon",con);
		} catch (Exception e) {
			System.out.println("SHDaoImpl getCountAllCon Error->" + e.getMessage());
		}
		return con1;
	}


	
}
