package com.oracle.tour.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.oracle.tour.dto.Command;
import com.oracle.tour.dto.Contents_like;
import com.oracle.tour.service.SHService;

@RestController
public class SHResponseController {
	
	private SHService shS;

	@Autowired
	public SHResponseController(SHService shS) {
		this.shS = shS;
	}
	// 컨텐츠 상세 페이지 좋아요
	@RequestMapping("/detail_Like")
	public String detailLike(Contents_like conLike) {
		System.out.println("SHResponseController detail_Like Start..");
		String resultStr = "";
		int result = 0;

		int likeCnt = shS.checkMember(conLike);
		System.out.println("likeCnt ->" + likeCnt);
		if (likeCnt == 1) {
			result = shS.updateInsertLike(conLike);
		} else {
			result = shS.detailLike(conLike);
		}
		resultStr = Integer.toString(result);
		return resultStr;
	}

	@RequestMapping("/ajaxLike")
	public String ajaxLike(String c_no, String m_id) {
		System.out.println("SHResponseController ajaxLike Start..");
		int result = shS.getMemberLikeCnt(c_no, m_id);
		String resultStr = Integer.toString(result);
		return resultStr;
	}

	@RequestMapping("/countLike")
	public String countLike(String c_no) {
		System.out.println("SHResponseController countLike Start..");
		int likeCnt = shS.getLikeCnt(c_no);
		String resultStr = Integer.toString(likeCnt);
		System.out.println(resultStr);
		return resultStr;
	}

	@RequestMapping("/cancel_Like")
	public String cancel_Like(Contents_like con) {
		System.out.println("SHResponseController cancel_Like Start..");
		String resultStr = "";
		int likeCnt = shS.checkMember(con);
		int result = 0;
		if (likeCnt == 1) {
			result = shS.updateLike(con);
		} else {
			result = shS.cancelLike(con);
		}
		resultStr = Integer.toString(result);
		return resultStr;
	}

	@RequestMapping("/ajaxCart")
	public String ajaxCart(String c_no, String m_id) {
		int cartCnt = shS.getCartCnt(c_no, m_id);
		System.out.println("cartCnt :" + cartCnt);
		String resultStr = Integer.toString(cartCnt);
		return resultStr;
	}

	@RequestMapping("/getCart")
	public String getCart(Contents_like con) {
		System.out.println("SHResponseController getCart Start..");
		String resultStr = "";
		int check = shS.checkMember(con);
		if (check == 0) {
			int result = shS.insertCart(con);
			resultStr = Integer.toString(result);
		} else {
			int result = shS.updateCart(con);
			resultStr = Integer.toString(result);
		}
		return resultStr;
	}

	@RequestMapping("/cancelCart")
	public String cancelCart(Contents_like con) {
		System.out.println("SHResponseController cancelCart Start..");
		int result = shS.deleteCart(con);
		String resultStr = Integer.toString(result);
		return resultStr;
	}

	// 컨텐츠 상세 페이지에서 댓글 작성
	@RequestMapping("/detailWriteCom")
	public String WriteDetailCom(Model model, String c_no, String m_id, String com_contents) {
		System.out.println("SHResponseController WriteDetailCom Start..");
		Command com = new Command();
		com.setC_no(Integer.parseInt(c_no));
		com.setM_id(m_id);
		;
		com.setCom_contents(com_contents);
		int result = shS.WriteDetailCom(com);
		String resultStr = Integer.toString(result);
		return resultStr;
	}

	// 컨텐츠 상세 페이지에서 댓글 작성 후 리스트 뽑기
	@RequestMapping("/ajaxCommandList")
	public List<Command> getAjaxCommandList(String c_no) {
		System.out.println("SHResponseController getAjaxCommandList Start..");
		List<Command> comList = shS.getCommandList(c_no);

		return comList;
	}

	// 컨텐츠 상세 페이지 댓글 수정
	@RequestMapping("/updateCom")
	public String updateCom(Command com) {
		System.out.println("SHResponseController updateCom Start..");
		int result = shS.updateCom(com);
		String resultStr = Integer.toString(result);
		return resultStr;
	}

	// 컨텐츠 상세 페이지 댓글 삭제
	@RequestMapping("/deleteCom")
	public String deleteCommand(Command com) {
		System.out.println("SHResponseController deleteCommand Start..");
		int result = shS.deleteCommand(com);
		
		
		System.out.println(result);
		String resultStr = Integer.toString(result);
		return resultStr;
	}

	// 댓글 속성 불러오기
	@RequestMapping("/showReplyProperty")
	public Command showReplyProperty(String com_no) {
		System.out.println("SHResponseController showReplyProperty Start..");
		Command com = shS.showReplyProperty(com_no);
		System.out.println(com.getC_no());
		System.out.println(com.getCom_no());
		return com;
	}

	// 대댓글 쓰기
	@RequestMapping("/writeReply")
	public String writeReply(Command com) {
		System.out.println("SHResponseController writeReply Start..");
		int result = shS.writeReply(com);
		System.out.println(result);
		String resultStr = Integer.toString(result);
		return resultStr;
	}
	
	// 댓글 갯수 불러오기
	@RequestMapping("/countCommandCnt")
	public String countCommandCnt(String c_no) {
		System.out.println("SHResponseController countCommandCnt Start..");
		int likeCnt = shS.getCommandCnt(c_no);
		String resultStr = Integer.toString(likeCnt);
		System.out.println(resultStr);
		return resultStr;
	}
}
