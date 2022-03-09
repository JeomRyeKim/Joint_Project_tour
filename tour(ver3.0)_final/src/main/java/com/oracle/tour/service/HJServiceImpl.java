package com.oracle.tour.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.tour.dao.HJDao;
import com.oracle.tour.dto.Board;
import com.oracle.tour.dto.Board_comment;
import com.oracle.tour.dto.Board_like;
import com.oracle.tour.dto.Member;

@Service
@Transactional
public class HJServiceImpl implements HJService {
	private final HJDao hd;

	@Autowired
	public HJServiceImpl(HJDao hd) {
		this.hd = hd;
	}

	@Override
	public Member getMemberDetail(String m_id) {
		System.out.println("HJServiceImpl getMemberDetail start..");
		Member member = hd.getMemberDetail(m_id);
		
		return member;
	}
	
	@Override
	public int total(Board board) {
		System.out.println("HJServiceImpl total start..");
		int totCnt = hd.total(board);
		System.out.println("HJServiceImpl total totCnt->" + totCnt);
		return totCnt;
	}

	@Override
	public List<Board> listBoard(Board board) {
		System.out.println("HJServiceImpl listBoard start..");
		List<Board> listBoard = hd.listBoard(board);
		System.out.println("HJServiceImpl listBoard listBoard.size() : " + listBoard.size());
		
		return listBoard;
	}

	@Override
	public int getHit(Board board) {
		System.out.println("HJServiceImpl getHit start..");
		int b_hit = hd.getHit(board);
		
		return b_hit;
	}


	@Override
	public Board BoardDetail(Board board) {
		System.out.println("HJServiceImpl BoardDetail start..");
		Board boardDetail = hd.BoardDetail(board);
		
		return boardDetail;
	}

	@Override
	public int insert(Board board) {
		System.out.println("HJServiceImpl insert start..");
		int result = hd.insert(board);
		
		return result;
	}

	@Override
	public List<Board> boardDelChk(Board board) {
		System.out.println("HJServiceImpl boardDelChk start..");
		List<Board> boardDelChk = hd.boardDelChk(board);
		
		return boardDelChk;
	}
	
	@Override
	public int boardCommentChk(Board board) {
		System.out.println("HJServiceImpl boardCommentChk start..");
		int boardCommentChk = hd.boardCommentChk(board);
		
		return boardCommentChk;
	}

	@Override
	public int boardLikeChk(Board board) {
		System.out.println("HJServiceImpl boardLikeChk start..");
		int boardLikeChk = hd.boardLikeChk(board);
		
		return boardLikeChk;
	}
	
	
	@Override
	public int BoardDelete(Board board) {
		System.out.println("HJServiceImpl BoardDelete start..");
		int boardDelete = hd.BoardDelete(board);
		
		return boardDelete;
	}
	
	@Override
	public int BLikeChk(Board_like board_like) {
		System.out.println("HJServiceImpl BLikeChk start..");
		int BLikeChk = hd.BLikeChk(board_like);
		
		return BLikeChk;
	}

	@Override
	public int BLikeChk_n(Board_like board_like) {
		System.out.println("HJServiceImpl BLikeChk_n start..");
		int BLikeChk_n = hd.BLikeChk_n(board_like);
		
		return BLikeChk_n;
	}
	
	@Override
	public int insert_bl(Board_like board_like) {
		System.out.println("HJServiceImpl selectLikeCnt start..");
		int insert_bl = hd.insert_bl(board_like);
		
		return insert_bl;
	}

	@Override
	public int like_b(Board board) {
		System.out.println("HJServiceImpl like_b start..");
		int like_b = hd.like_b(board);
		
		return like_b;
	}
	
	@Override
	public int update_bl(Board_like board_like) {
		System.out.println("HJServiceImpl update_bl start..");
		int update_bl = hd.update_bl(board_like);
		
		return update_bl;
	}

	@Override
	public int dislike_bl(Board_like board_like) {
		System.out.println("HJServiceImpl dislike_bl start..");
		int dislike_bl = hd.dislike_bl(board_like);
		
		return dislike_bl;
	}

	@Override
	public int dislike_b(Board board) {
		System.out.println("HJServiceImpl dislike_b start..");
		int dislike_b = hd.dislike_b(board);
		
		return dislike_b;
	}

	@Override
	public String BLikeYN(Board_like board_like) {
		System.out.println("HJServiceImpl BLikeYN start..");
		String b_like_check = hd.BLikeYN(board_like);
		
		return b_like_check;
	}

	@Override
	public int selectLikeCnt(Board board) {
		System.out.println("HJServiceImpl selectLikeCnt start..");
		int b_like_cnt = hd.selectLikeCnt(board);
		
		return b_like_cnt;
	}

	@Override
	public int Boardmodify(Board board) {
		System.out.println("HJServiceImpl Boardmodify start..");
		int modifyChk = hd.Boardmodify(board);
		
		return modifyChk;
	}

	@Override
	public int updateReply(Board board) {
		System.out.println("HJServiceImpl updateReply start..");
		int replyShapeChk = hd.updateReply(board);
		
		return replyShapeChk;
	}

	@Override
	public int insertReply(Board board) {
		System.out.println("HJServiceImpl insertReply start..");
		int insertReplyChk = hd.insertReply(board);
		
		return insertReplyChk;
	}

	@Override
	public int commentInsert(Board_comment board_comment) {
		System.out.println("HJServiceImpl commentInsert start..");
		int getCommentChk = hd.commentInsert(board_comment);
		
		return getCommentChk;
	}

	@Override
	public int getBoardComCntUpdate(Board_comment board_comment) {
		System.out.println("HJServiceImpl getBoardComCntUpdate start..");
		int boardComCntUpdate = hd.getBoardComCntUpdate(board_comment);
		
		return boardComCntUpdate;
	}
	
	@Override
	public List<Board> getComList(Board_comment board_comment) {
		System.out.println("HJServiceImpl getComList start..");
		List<Board> commentList = hd.getComList(board_comment);
		
		return commentList;
	}

	@Override
	public int getCommentCnt(Board_comment board_comment) {
		System.out.println("HJServiceImpl getCommentCnt start..");
		int commentCnt = hd.getCommentCnt(board_comment);
		
		return commentCnt;
	}
	
	@Override
	public int commentUpdate(Board_comment board_comment) {
		System.out.println("HJServiceImpl commentUpdate start..");
		int commentUpdateChk = hd.commentUpdate(board_comment);
		
		return commentUpdateChk;
	}

	@Override
	public List<Board_comment> getModifyComList(Board_comment board_comment) {
		System.out.println("HJServiceImpl getModifyComList start..");
		List<Board_comment> BCModifyComList = hd.getModifyComList(board_comment);
		
		return BCModifyComList;
	}
	
	@Override
	public int getGroupCnt(Board_comment board_comment) {
		System.out.println("HJServiceImpl getGroupCnt start..");
		int groupCnt = hd.getGroupCnt(board_comment);
		
		return groupCnt;
	}

	@Override
	public int commnetDelete(Board_comment board_comment) {
		System.out.println("HJServiceImpl commnetDelete start..");
		int commentDelChk = hd.commnetDelete(board_comment);
		
		return commentDelChk;
	}
	
	@Override
	public int commnetsDelete(Board_comment board_comment) {
		System.out.println("HJServiceImpl commnetsDelete start..");
		int commentDelChk = hd.commnetsDelete(board_comment);
		
		return commentDelChk;
	}

	@Override
	public int getBoardComCntDelete(Board_comment board_comment) {
		System.out.println("HJServiceImpl getBoardComCntDelete start..");
		int boardComCntDelete = hd.getBoardComCntDelete(board_comment);
		
		return boardComCntDelete;
	}

	@Override
	public int getCommentReply(Board_comment board_comment) {
		System.out.println("HJServiceImpl getCommentReply start..");
		int commentReplyUpChk = hd.getCommentReply(board_comment);
		
		return commentReplyUpChk;
	}

	@Override
	public int commentReplyInsert(Board_comment board_comment) {
		System.out.println("HJServiceImpl commentReplyInsert start..");
		int commentReplyInsertChk = hd.commentReplyInsert(board_comment);
		
		return commentReplyInsertChk;
	}
}
