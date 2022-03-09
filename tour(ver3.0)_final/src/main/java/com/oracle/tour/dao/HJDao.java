package com.oracle.tour.dao;

import java.util.List;

import com.oracle.tour.dto.Board;
import com.oracle.tour.dto.Board_comment;
import com.oracle.tour.dto.Board_like;
import com.oracle.tour.dto.Member;

public interface HJDao {
	
	Member getMemberDetail(String m_id);

	int total(Board board);
	
	List<Board> listBoard(Board board);

	int getHit(Board board);

	Board BoardDetail(Board board);

	int insert(Board board);
	
	List<Board> boardDelChk(Board board);

	int boardCommentChk(Board board);

	int boardLikeChk(Board board);
	
	int BoardDelete(Board board);

	int BLikeChk(Board_like board_like);

	int BLikeChk_n(Board_like board_like);
	
	int insert_bl(Board_like board_like);

	int like_b(Board board);
	
	int update_bl(Board_like board_like);

	int dislike_bl(Board_like board_like);

	int dislike_b(Board board);
	
	String BLikeYN(Board_like board_like);

	int selectLikeCnt(Board board);

	int Boardmodify(Board board);

	int updateReply(Board board);

	int insertReply(Board board);

	int commentInsert(Board_comment board_comment);
	
	int getBoardComCntUpdate(Board_comment board_comment);

	List<Board> getComList(Board_comment board_comment);

	int getCommentCnt(Board_comment board_comment);
	
	int commentUpdate(Board_comment board_comment);

	List<Board_comment> getModifyComList(Board_comment board_comment);
	
	int getGroupCnt(Board_comment board_comment);
	
	int commnetsDelete(Board_comment board_comment);

	int commnetDelete(Board_comment board_comment);

	int getBoardComCntDelete(Board_comment board_comment);

	int getCommentReply(Board_comment board_comment);

	int commentReplyInsert(Board_comment board_comment);
}
