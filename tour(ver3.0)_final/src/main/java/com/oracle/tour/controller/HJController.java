package com.oracle.tour.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oracle.tour.dto.Board;
import com.oracle.tour.dto.Board_comment;
import com.oracle.tour.dto.Board_like;
import com.oracle.tour.dto.Member;
import com.oracle.tour.service.HJService;
import com.oracle.tour.service.Paging;

@Controller
public class HJController {
	private static final Logger logger = LoggerFactory.getLogger(HJController.class);
	private final HJService hs;
	@Autowired
	public HJController(HJService hs) {
		this.hs = hs;
	}
	// 게시판 들어갈 때 검색, 페이징처리
	@RequestMapping("/HJBoard")
	public String BoardList(Board board, String searchType, String keyword, String currentPage, 
							Model model, Member member, String m_id) {
		logger.info("BoardList start");
		
		System.out.println("로그인을 한 상태라면 출력값이 있을 것 - m_id->" + m_id);
		
		int total = hs.total(board);
		int b_kind = board.getB_kind();
		System.out.println("HJController total b_kind->" + b_kind + 
				", searchType->" + searchType + ", keyword->" + keyword);
		
		System.out.println("HJController BoardList total->" + total);
		System.out.println("HJController BoardList currentPage->" + currentPage);
		System.out.println("HJController BoardList b_kind->" + b_kind);
		System.out.println("HJController BoardList keyword->" + keyword);
		System.out.println("HJController BoardList searchType->" + searchType);
		
		Paging pg = new Paging(total, currentPage);
		board.setStart(pg.getStart());
		board.setEnd(pg.getEnd());
		board.setB_kind(b_kind);
		board.setKeyword(keyword);
		board.setSearchType(searchType);
		List<Board> listBoard = hs.listBoard(board);
		System.out.println("HJController BoardList listBoard.size()->" + listBoard.size());
		
		model.addAttribute("total", total);
		model.addAttribute("pg", pg);
		model.addAttribute("listBoard", listBoard);
		
		System.out.println("!StringUtils.isEmpty(m_id)->" + !StringUtils.isEmpty(m_id)); // false
		
		if(!StringUtils.isEmpty(m_id)){
			System.out.println("세션 아이디 값이 있을 때 - HJController BoardList getMemberDetail start");
			member = hs.getMemberDetail(m_id);
			System.out.println("HJController BoardList getMemberDetail member.getM_id()->" + member.getM_id());
			System.out.println("HJController BoardList getMemberDetail member.getM_active_kind()->" + member.getM_active_kind());
			System.out.println("HJController BoardList getMemberDetail member.getM_nickname()->" + member.getM_nickname());
			System.out.println("HJController BoardList getMemberDetail member.getM_kind()->" + member.getM_kind());
			model.addAttribute("member", member);
		}
		return "HJview/Board";
	}
	
	// 상세글(제목 누를 때) 들어갈 때
	@GetMapping("/HJBoardDetail")
	public String BoardDetail(Board board, Board_like board_like, Model model, HttpServletRequest request) {
		System.out.println("HJController BoardDetail start");
		
		String query_string = request.getQueryString();
		System.out.println("자바 현재 url 쿼리스트링!!! query_string->" + query_string);
		
		int b_kind = board.getB_kind();
		int b_no = board.getB_no();
		System.out.println("HJController BoardDetail b_kind->" + b_kind + ", b_no->" + b_no);
		
//		if(!query_string.contains("bc_contents")) {
//			System.out.println("!query_string.contains('bc_contents')");
//		if(b_kind != 0 && b_no != 0) {
			// 조회수 올리는 메소드
			int b_hit = hs.getHit(board);
			
			// 파라미터를 Board board로 보내는 이유는 board의 b_kind와 b_no가 복합키라 2개의 파라미터를 값으로 보내야하기 때문
			Board boardDetail = hs.BoardDetail(board); 
			System.out.println("HJController BoardDetail boardDetail.getB_title()->" + boardDetail.getB_title());
			model.addAttribute("boardDetail", boardDetail);
//		}
		
		String m_id = board.getM_id();
		System.out.println("로그인 했다면 HJController BoardDetail m_id->" + m_id);
		// 좋아요 y or n여부?
		// 로그인 했을 때
		if(m_id != null) {
			String b_like_check = hs.BLikeYN(board_like);
			System.out.println("HJController BoardDetail b_like_check->" + b_like_check);
			model.addAttribute("b_like_check", b_like_check);
		}else { // 로그인 안 했을 때
			model.addAttribute("b_like_check", "n");
		}
		return "HJview/BoardDetail";
	}
	
	//좋아요 실행
	@RequestMapping("/HJBoardLike")
	@ResponseBody
	public String BoardLike(Board_like board_like, Board board) {
		System.out.println("HJController BoardLike start");
		System.out.println("HJController BoardLike board_like.getB_kind()" + board_like.getB_kind());
		System.out.println("HJController BoardLike board_like.getB_no()" + board_like.getB_no());
		System.out.println("HJController BoardLike board_like.getM_id()" + board_like.getM_id());
		System.out.println("HJController BoardLike board.getB_kind()" + board.getB_kind());
		System.out.println("HJController BoardLike board.getB_no()" + board.getB_no());
		System.out.println("HJController BoardLike board.getM_id()" + board.getM_id());
		
		// 좋아요 했는지 y여부 가져오기 - 좋아요 했으면 1, 없으면 0
		int BLikeChk = hs.BLikeChk(board_like);
		System.out.println("HJController BoardLike BLikeChk->" + BLikeChk);
		int BLikeChk_n = 0;
		int insert_bl = 0;
		int like_b = 0;
		int update_bl = 0;
		int dislike_bl = 0;
		int dislike_b = 0;
		
		// 좋아요 y가 아니다 - 1. n이다  2. 좋아요 처음이다 <- 좋아요+1해야함
		if(BLikeChk == 0 ) {
			// 좋아요 했는지 n여부 가져오기 - 0:좋아요 처음, 1:n이다
			BLikeChk_n = hs.BLikeChk_n(board_like);
			System.out.println("HJController BoardLike BLikeChk_n->" + BLikeChk_n);
			// 좋아요 처음이다 
			if(BLikeChk_n == 0) { 
				// 좋아요를 처음 누를 때 b_like_check = "y"으로 insert
				insert_bl = hs.insert_bl(board_like);
				System.out.println("HJController BoardLike insert_bl->" + insert_bl);
				// b_like_cnt +1처리
				like_b = hs.like_b(board);
				System.out.println("HJController BoardLike like_b->" + like_b);
				System.out.println("HJController like_b board.getB_like_cnt()->" + board.getB_like_cnt());
			}else { // n이다
				// 기존에 'n'으로 되어있던 값을 b_like_check = "y" 수정처리
				update_bl = hs.update_bl(board_like);
				System.out.println("HJController BoardLike update_bl->" + update_bl);
				// b_like_cnt +1처리
				like_b = hs.like_b(board);
				System.out.println("HJController BoardLike like_b->" + like_b);
				System.out.println("HJController like_b board.getB_like_cnt()->" + board.getB_like_cnt());
			}
		}else { // 좋아요y 다 <- 좋아요-1해야함
			// b_like_check 'y' -> 'n'으로 변경
			dislike_bl = hs.dislike_bl(board_like);
			System.out.println("HJController BoardLike dislike_bl->" + dislike_bl);
			System.out.println("HJController dislike_bl board_like.getB_like_check()->" + board_like.getB_like_check());
			// b_like_cnt -1처리
			dislike_b = hs.dislike_b(board);
			System.out.println("HJController BoardLike dislike_b->" + dislike_b);
			System.out.println("HJController dislike_b board.getB_like_cnt()->" + board.getB_like_cnt());
		}
		
		// b_like_check y or n 여부 가져오기
		String b_like_check = hs.BLikeYN(board_like);
		System.out.println("HJController BoardLike b_like_check->" + b_like_check);
		// b_like_cnt 가져오기
		int b_like_cnt = hs.selectLikeCnt(board);
		System.out.println("HJController BoardLike b_like_cnt->" + b_like_cnt);
		
		JSONObject obj = new JSONObject();

		obj.put("BLikeChk", BLikeChk);			// 좋아요 했는지 y여부
		obj.put("BLikeChk_n", BLikeChk_n);		// 좋아요 했는지 n여부
		obj.put("insert_bl", insert_bl);		// 좋아요를 처음 누를 때 b_like_check = "y"으로 insert
		obj.put("like_b", like_b);				// b_like_cnt +1처리
		obj.put("update_bl", update_bl);		// 기존에 'n'으로 되어있던 값을 b_like_check = "y" 수정처리
		obj.put("dislike_bl", dislike_bl);		// b_like_check 'y' -> 'n'으로 변경
		obj.put("dislike_b", dislike_b);		// b_like_cnt -1처리
		obj.put("b_like_check", b_like_check);	// b_like_check 가져오기
		obj.put("b_like_cnt", b_like_cnt);		// b_like_cnt 가져오기
		
		return obj.toJSONString();
	}
	
	// 게시글 작성
	@GetMapping("/HJWriteForm")
	public String WriteForm(Board board) {
		logger.info("WriteForm start");
		System.out.println("HJController WriteForm start");
		
		return "HJview/WriteForm";
	}
	@PostMapping("HJWrite")
	public String Write(HttpServletRequest request, MultipartFile filename, Board board, Model model, RedirectAttributes rttr) throws Exception {
		logger.info("Write start");
		System.out.println("HJController Write start");
		System.out.println("HJController Write OriginalFilename : " + filename.getOriginalFilename());
		System.out.println("HJController Write Size : " + filename.getSize());
		System.out.println("HJController Write ContentType : " + filename.getContentType());
		
		String b_filename = filename.getOriginalFilename();
		System.out.println("HJController Write b_filename->" + b_filename);
		
		// 이미지 파일이 있을 때 파일 업로드
		if(!b_filename.isEmpty()) {

			System.out.println("HJController HJWrite 업로드된 그림 파일이 있음!");
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/image/board");
			System.out.println("Write POST start");
			System.out.println("HJController Write uploadPath : " + uploadPath);
			
			String savedName = uploadFile(filename.getOriginalFilename(), filename.getBytes(), uploadPath);
			System.out.println("HJController Write savedName : " + savedName);
			board.setB_filename(savedName);
			System.out.println("HJController Write set 후에  board.getB_filename(savedName)->" + board.getB_filename());
			System.out.println("HJController Write board.getB_lock()->" + board.getB_lock());
		}
			
			System.out.println("***********HJController Write insert");
			int result = hs.insert(board); // 성공시 1, 실패시 0
			System.out.println("HJController Write insert result->" + result);
			System.out.println("HJController Write board.getB_notice()->" + board.getB_notice());
			System.out.println("HJController Write board.getB_filename()->" + board.getB_filename());
			System.out.println("HJController Write board.getM_nickname()->" + board.getM_nickname());
		// 업데이트 성공시
		if (result > 0) {
			System.out.println("새글 등록 완료!!!!!!!!!");
			String m_id = board.getM_id();
			System.out.println("로그인 했다면 HJController Write m_id->" + m_id);
			rttr.addAttribute("m_id", m_id);
			// forward:HJBoard, /HJBoard, HJBoard 다 오류남
			return "redirect:HJBoard";
		}else {
			model.addAttribute("msg","입력 실패 확인해 보세요");
			return "forward:HJWriteForm";
		}
	}
	// 파일 업로드 처리
	private String uploadFile(String originalName, byte[] fileData, String uploadPath) throws Exception {
		System.out.println("uploadFile start");
		UUID uid = UUID.randomUUID(); // UUID : 세계적으로 유일한 번호
		
		String savedName = uid.toString() + "_" + originalName;
		System.out.println("uploadPath->" + uploadPath);
		System.out.println("savedName : " + savedName);
		File target = new File(uploadPath, savedName); // 진짜로 업로드 처리
		FileCopyUtils.copy(fileData, target); //org.springframework.util.FileCopyUtils;
		
		return savedName;
	}
	
	// 게시글 삭제
	@RequestMapping(value = "/HJBoardDelete")
	public String BoardDelete(Board board, RedirectAttributes rttr) {
		System.out.println("HJController BoardDelete start");
		
		// 삭제하는 답변글 뒤에 쓰여진 답변글이 있는지 확인 - b_kind, b_no 알아오기
		List<Board> boardDelChk = hs.boardDelChk(board);
		
	    for (int i = 0; i < boardDelChk.size(); i++) {
	        int b_no = boardDelChk.get(i).getB_no();
	        System.out.println(" b_no->" + b_no);
	        board.setB_no(b_no);

			// 해당 게시글에 댓글이 있는지 확인하고 있으면 댓글 먼저 지우기
			int boardCommentChk = hs.boardCommentChk(board);
			System.out.println("HJController BoardDelete boardCommentChk->" + boardCommentChk);
			
			// 해당 게시글에 좋아요가 있는지 확인하고 있으면 좋아요 먼저 지우기
			int boardLikeChk = hs.boardLikeChk(board);
			System.out.println("HJController BoardDelete boardLikeChk->" + boardLikeChk);
			
			// 게시글 삭제 처리
			int boardDelete = hs.BoardDelete(board);
			System.out.println("HJController BoardDelete boardDelete->" + boardDelete);
		}
		
		String m_id = board.getM_id();
		System.out.println("로그인 했다면 HJController BoardDelete m_id->" + m_id);
		rttr.addAttribute("m_id", m_id);
		return "redirect:HJBoard";
	}	
	
	// 게시글 수정
	@PostMapping("HJBoardmodifyForm")
	public String BoardmodifyForm(Board board, Model model) {
		logger.info("HJBoardmodifyForm start");
		System.out.println("HJController BoardmodifyForm board.getM_id()->" + board.getM_id());
		System.out.println("HJController BoardmodifyForm board.getB_kind()->" + board.getB_kind());
		System.out.println("HJController BoardmodifyForm board.getB_no()->" + board.getB_no());
		
		Board boardDetail = hs.BoardDetail(board);
		System.out.println("HJController BoardmodifyForm boardDetail.getB_title()->" + boardDetail.getB_title());
		model.addAttribute("boardDetail", boardDetail);
		
		return "HJview/BoardModify";
	}	
	@PostMapping("HJBoardmodify")
	public String Boardmodify(HttpServletRequest request, MultipartFile filename, RedirectAttributes rttr, Board board, Model model) throws Exception {
		logger.info("Boardmodify start");
		System.out.println("HJController Boardmodify board.getB_kind()->" + board.getB_kind());
		System.out.println("HJController Boardmodify board.getB_no()->" + board.getB_no());
		System.out.println("HJController Boardmodify board.getM_id()->" + board.getM_id());
		System.out.println("HJController Boardmodify board.getM_nickname()->" + board.getM_nickname());
		
		String beforeFilename = board.getB_filename(); // 수정전에 있었던 이미지 파일 명
		System.out.println("HJController Boardmodify 수정전에 있었던 beforeFilename->" + beforeFilename);
		
		String b_filename = filename.getOriginalFilename(); // 수정하면서 추가한 이미지 파일 명
		System.out.println("HJController Boardmodify filename.getOriginalFilename()->" + b_filename);
		
		// 파일 업로드 (수정 전 이미지X -> 수정 후 이미지X인 경우 파일 업로드 자체를 거치지X)
		// 수정 전 이미지O -> 수정 후 이미지X
		if((beforeFilename == null || beforeFilename.isEmpty()) && (b_filename == null || b_filename.isEmpty())) {
			System.out.println("수정 전 이미지O -> 수정 후 이미지X");
			board.setB_filename(b_filename);
			System.out.println("HJController Boardmodify board.getB_filename()->" + board.getB_filename());
		}// 수정 전 이미지X -> 수정 후 이미지O
		else if((beforeFilename == null || beforeFilename.isEmpty()) && (b_filename != null || !b_filename.isEmpty())) {
			System.out.println("수정 전 이미지X -> 수정 후 이미지O");
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/image/board");
			String savedName = uploadFile(filename.getOriginalFilename(), filename.getBytes(), uploadPath);
			logger.info("savedName : " + savedName);
			board.setB_filename(savedName);
			System.out.println("HJController Boardmodify board.getB_lock()->" + board.getB_lock());
		} // 수정 전 이미지O -> 수정 후 이미지O (이미지 그대로)
		else if((beforeFilename != null || !beforeFilename.isEmpty()) && (b_filename == null || b_filename.isEmpty())) {
			System.out.println("수정 전 이미지O -> 수정 후 이미지O (이미지 그대로)");
			board.setB_filename(beforeFilename);
			System.out.println("HJController Boardmodify board.getB_filename()->" + board.getB_filename());
		} // 수정 전 이미지O -> 수정 후 이미지O (이미지 바뀜)
		else if((beforeFilename != null || !beforeFilename.isEmpty()) && (b_filename != null || !b_filename.isEmpty()) && !beforeFilename.contains(b_filename)) {
			System.out.println("수정 전 이미지O -> 수정 후 이미지O (이미지 바뀜)");
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/image/board");
			String savedName = uploadFile(filename.getOriginalFilename(), filename.getBytes(), uploadPath);
			logger.info("savedName : " + savedName);
			board.setB_filename(savedName);
			System.out.println("HJController Boardmodify board.getB_lock()->" + board.getB_lock());
		}
		
		int modifyChk = hs.Boardmodify(board);
		System.out.println("HJController Boardmodify modifyChk->" + modifyChk);
		
		String m_id = board.getM_id();
		System.out.println("로그인 했다면 HJController Boardmodify m_id->" + m_id);
		int b_kind = board.getB_kind();
		System.out.println("로그인 했다면 HJController Boardmodify b_kind->" + b_kind);
		int b_no = board.getB_no();
		System.out.println("로그인 했다면 HJController Boardmodify b_no->" + b_no);
		// 수정 성공시
		if (modifyChk > 0) {
			System.out.println("게시글 수정 완료!!!!!!!!!");
			rttr.addAttribute("m_id", m_id);
			rttr.addAttribute("b_kind", b_kind);
			rttr.addAttribute("b_no", b_no);
//			return "redirect:HJBoard";
			return "redirect:HJBoardDetail";
		}else {
			model.addAttribute("msg","수정 실패 확인해 보세요");
			return "forward:HJBoardmodifyForm";
		}
	}	
	
	// 게시글 답변글 작성
	@RequestMapping("/HJboardReply_view")
	public String boardReply_view(Board board, Model model) {
		logger.info("boardReply_view start");
		
		Board boardDetail = hs.BoardDetail(board); 
		System.out.println("HJController boardReply_view boardDetail.getB_title()->" + boardDetail.getB_title());
		System.out.println("HJController boardReply_view boardDetail.getB_kind()->" + boardDetail.getB_kind());
		System.out.println("HJController boardReply_view boardDetail.getB_no()->" + boardDetail.getB_no());
		System.out.println("HJController boardReply_view boardDetail.getB_Group()->" + boardDetail.getB_Group());
		model.addAttribute("boardDetail", boardDetail);
		
		return "HJview/BoardReply";
	}
	@RequestMapping("/HJboardReply")
	public String boardReply(HttpServletRequest request, MultipartFile filename, Board board, Model model) throws Exception {
		logger.info("boardReply start");
		
		String b_filename = filename.getOriginalFilename();
		System.out.println("HJController boardReply b_filename->" + b_filename);
		
		// 파일 업로드
		if(!b_filename.isEmpty()) {
			System.out.println("HJController HJboardReply 업로드된 그림 파일이 있음!");
			
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/image/board");
			String savedName = uploadFile(filename.getOriginalFilename(), filename.getBytes(), uploadPath);
			logger.info("savedName : " + savedName);
			board.setB_filename(savedName);
			System.out.println("HJController boardReply board.getB_lock()->" + board.getB_lock());
		}
		
		// 새로 입력하는 댓글이 기존의 댓글과 b_Group =같고   &  기존의 댓글보다 b_Step >작으면  =>  b_Step + 1
		System.out.println("HJController boardReply board.getB_Group()->" + board.getB_Group());
		System.out.println("HJController boardReply board.getB_Step()->" + board.getB_Step());
		System.out.println("HJController boardReply board.getB_Indent()->" + board.getB_Indent());
		int replyShapeChk = hs.updateReply(board);
		System.out.println("HJController boardReply 기존글 b_Step + 1 - replyShapeChk->" + replyShapeChk);
		
		// 답변 입력
		board.setB_Step(board.getB_Step() + 1);
		System.out.println("HJController boardReply board.setB_Step(board.getB_Step() + 1) 후에 board.getB_Step()->" + board.getB_Step());
		board.setB_Indent(board.getB_Indent() + 1);
		System.out.println("HJController boardReply board.setB_Step(board.setB_Indent() + 1) 후에 board.getB_Indent()->" + board.getB_Indent());
		int insertReplyChk = hs.insertReply(board);
		System.out.println("HJController boardReply insertReplyChk->" + insertReplyChk);
		
		String m_id = board.getM_id();
		System.out.println("로그인 했다면 HJController boardReply m_id->" + m_id);
		int b_kind = board.getB_kind();
		System.out.println("로그인 했다면 HJController boardReply b_kind->" + b_kind);
		int b_no = board.getB_no();
		System.out.println("로그인 했다면 HJController boardReply b_no->" + b_no);
		// 답변글 입력 성공시
		if (insertReplyChk > 0) {
			System.out.println("게시글 답변 입력 완료~~~~~~~~~~~~~~~");
			return "redirect:HJBoard";
		}else {
			model.addAttribute("msg","답변글 입력 실패 확인해 보세요");
			return "forward:HJboardReply_view";
		}
	}
	
	// 게시글 댓글 입력
	@RequestMapping(value = "/HJCommentInsert", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String CommentInsert(Board_comment board_comment) {
		System.out.println("HJController CommentInsert start");
		System.out.println("HJController CommentInsert board_comment.getB_kind()->" + board_comment.getB_kind());
		System.out.println("HJController CommentInsert board_comment.getB_no()->" + board_comment.getB_no());
		System.out.println("HJController CommentInsert board_comment.getM_id()->" + board_comment.getM_id());
		System.out.println("HJController CommentInsert board_comment.getBc_Group()->" + board_comment.getBc_Group());
		System.out.println("HJController CommentInsert board_comment.getBc_lock()->" + board_comment.getBc_lock());
		// 댓글 입력
		int getCommentChk = hs.commentInsert(board_comment);
		System.out.println("HJController CommentInsert getCommentChk->" + getCommentChk);
		int bc_no = board_comment.getBc_no();
		System.out.println("HJController CommentInsert insert이후에 bc_no->" + bc_no);
		
		// 게시판에 댓글 개수 +1 해주기
		int boardComCntUpdate = hs.getBoardComCntUpdate(board_comment);
		System.out.println("HJController CommentInsert boardComCntUpdate->" + boardComCntUpdate);

		String getCommentStr = Integer.toString(getCommentChk);
		return getCommentStr;
	}
	// 게시글 댓글 목록 가져오기
	@RequestMapping(value = "/HJCommentList")
	@ResponseBody
	public List<Board> CommentList(Board_comment board_comment) {
		System.out.println("HJController CommentList start");
		System.out.println("HJController CommentList board_comment.getB_kind()->" + board_comment.getB_kind());
		System.out.println("HJController CommentList board_comment.getB_no()->" + board_comment.getB_no());
		System.out.println("HJController CommentList board_comment.getBc_no()->" + board_comment.getBc_no());
		System.out.println("HJController CommentList board_comment.getM_id()->" + board_comment.getM_id());
		List<Board> commentList = hs.getComList(board_comment);
		System.out.println("HJController CommentList commentList.size()->" + commentList.size());
		
		return commentList;
	}
	// 해당 게시글 댓글 개수 가져오기
	@RequestMapping(value = "/HJCommentCnt")
	@ResponseBody
	public String CommentCnt(Board_comment board_comment) {
		System.out.println("HJController CommentCnt start");
		int commentCnt = hs.getCommentCnt(board_comment);
		System.out.println("HJController CommentList commentCnt->" + commentCnt);
		
		String commentCntStr = Integer.toString(commentCnt);
		return commentCntStr;
	}
	// 댓글 수정
	@RequestMapping(value = "HJCommentUpdate", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String CommentUpdate(Board_comment board_comment) {
		System.out.println("HJController CommentUpdate start");
		System.out.println("HJController CommentUpdate board_comment.getBc_lock()->" + board_comment.getBc_lock());
		int commentUpdateChk = hs.commentUpdate(board_comment);
		System.out.println("HJController CommentUpdate commentUpdateChk->" + commentUpdateChk);
		System.out.println("HJController CommentUpdate board_comment.getB_kind()->" + board_comment.getB_kind());
		System.out.println("HJController CommentUpdate board_comment.getB_no()->" + board_comment.getB_no());
		System.out.println("HJController CommentUpdate board_comment.getBc_contents()->" + board_comment.getBc_contents());
		System.out.println("HJController CommentUpdate board_comment.getBc_no()->" + board_comment.getBc_no());
		
		// 수정한 댓글 내용 view로 보내기
//		List<Board_comment> BCModifyComList = hs.getModifyComList(board_comment);
//		System.out.println("HJController CommentUpdate BCModifyComList.size()->" + BCModifyComList.size());
//		System.out.println("HJController CommentUpdate board_comment.getBc_lock()->" + board_comment.getBc_lock());
		
//		return BCModifyComList;
		String commentUpStr = Integer.toString(commentUpdateChk);
		return commentUpStr;
	}
	// 댓글 삭제
	@RequestMapping(value = "HJCommentDelete")
	@ResponseBody
	public String CommentDelete(Board_comment board_comment) {
		System.out.println("HJController CommentDelete start");
		System.out.println("HJController CommentDelete board_comment.getBc_no()->" + board_comment.getBc_no());
		System.out.println("HJController CommentDelete board_comment.getBc_Step()->" + board_comment.getBc_Step());
		// 댓글 삭제 전에 자기보다 늦게 달린 대댓글 있는지 확인(있으면 상위 대댓글 삭제할 때 하위 대댓글들도 같이 삭제처리할 예정)
		int groupCnt = hs.getGroupCnt(board_comment);
		System.out.println("HJController CommentDelete groupCnt->" + groupCnt);
		
		int commentDelChk = 0;
		// 자기 댓글보다 늦게 달린 대댓글 O - 여러개 삭제 (2개 이상)
		if(groupCnt >= 2) {
			commentDelChk = hs.commnetsDelete(board_comment);
		}// 자기 댓글보다 늦게 달린 대댓글X - 1개 삭제
		else if(groupCnt <= 1) {
			commentDelChk = hs.commnetDelete(board_comment);
		}
		System.out.println("HJController CommentDelete commentDelChk->" + commentDelChk);
		
		board_comment.setGroupCnt(groupCnt);
		if(groupCnt != 0) {
			// 게시판에 댓글 개수 - 해주기
			int boardComCntDelete = hs.getBoardComCntDelete(board_comment);
			System.out.println("HJController CommentDelete boardComCntDelete->" + boardComCntDelete);
		}
		
		String commentDelStr = Integer.toString(commentDelChk);
		return commentDelStr;
	}
	// 대댓글 달기
	@RequestMapping(value = "HJCommentReply", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String CommentReply(Board_comment board_comment) {
		System.out.println("HJController CommentReply start");
		int bc_no = board_comment.getBc_no();
		int bc_Group = board_comment.getBc_Group();
		int bc_Step = board_comment.getBc_Step();
		int bc_Indent = board_comment.getBc_Indent();
		System.out.println("HJController CommentReply bc_no->" + bc_no);
		System.out.println("HJController CommentReply bc_Group->" + bc_Group);
		System.out.println("HJController CommentReply bc_Step->" + bc_Step);
		System.out.println("HJController CommentReply bc_Indent->" + bc_Indent);
		
		System.out.println("HJController CommentReply board_comment.getBc_lock()->" + board_comment.getBc_lock());
		String bc_lock = board_comment.getBc_lock();
		// 대댓글에서 bc_lock값이 없을 때 n으로 넣어주기
		if(StringUtils.isEmpty(bc_lock)) bc_lock = "n";
		System.out.println("HJController CommentReply bc_lock에 n 삽입 후 bc_lock->" + bc_lock);
		board_comment.setBc_lock(bc_lock);
		
		// 새로 입력하는 댓글이 기존의 댓글과 b_Group =같고   &  기존의 댓글보다 b_Step >작으면  =>  b_Step + 1
		int commentReplyUpChk = hs.getCommentReply(board_comment);
		System.out.println("HJController CommentReply commentReplyUpChk->" + commentReplyUpChk);
		
		//대댓글 입력
		board_comment.setBc_Step(board_comment.getBc_Step() + 1);
		board_comment.setBc_Indent(board_comment.getBc_Indent() + 1);
		System.out.println("HJController CommentReply bc_Step +1 후->" + board_comment.getBc_Step());
		System.out.println("HJController CommentReply bc_Indent+1 후->" + board_comment.getBc_Indent());
		int commentReplyInsertChk = hs.commentReplyInsert(board_comment);
		System.out.println("HJController CommentReply commentReplyInsertChk->" + commentReplyInsertChk);

		
		if(commentReplyInsertChk > 0) {
			System.out.println("대댓글 작성 완료##############");
			// 게시판에 댓글 개수 +1 해주기
			int boardComCntUpdate = hs.getBoardComCntUpdate(board_comment);
			System.out.println("HJController CommentReply boardComCntUpdate->" + boardComCntUpdate);
		}
			
		String commentReplyInsertStr = Integer.toString(commentReplyInsertChk);
		return commentReplyInsertStr;
	}
	// Footer
	// 회사 소개
	@RequestMapping("Footer_company")
	public String Footer_company() {
		System.out.println("HJController Footer_company start");
		return "HJview/company";
	}
	// 이용 약관
	@RequestMapping("Footer_agreement")
	public String Footer_agreement() {
		System.out.println("HJController Footer_agreement start");
		return "HJview/agreement";
	}
	// 개인정보처리방침
	@RequestMapping("Footer_privacy")
	public String Footer_privacy() {
		System.out.println("HJController Footer_privacy start");
		return "HJview/privacy";
	}
	
}
