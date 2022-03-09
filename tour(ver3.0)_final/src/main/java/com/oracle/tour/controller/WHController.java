package com.oracle.tour.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.tour.dto.Contents;
import com.oracle.tour.dto.Contents_like;
import com.oracle.tour.dto.Contents_like_contents;
import com.oracle.tour.dto.Member;
import com.oracle.tour.service.MailSendService;
import com.oracle.tour.service.WHService;

@Controller
public class WHController {
	private static final Logger logger = LoggerFactory.getLogger(WHController.class);
	
	@Autowired
	private MailSendService mailSendService;
	
	private final WHService whService;
	@Autowired
	public WHController(WHService whService) {
		this.whService = whService;
	}
	
	@RequestMapping(value = "/memberLogout")
	public String logout(HttpSession session,Model model) {
		System.out.println("WHController logout Start..");
		String m_id =(String)session.getAttribute("m_id");
		if(m_id!=null) {
			session.invalidate();
			return "WHview/memberLogout";
		}
		model.addAttribute("msg1","로그인해주세요");
		model.addAttribute("msg2","로그인이 안되어있어 로그아웃을 할수없습니다");
		model.addAttribute("msg3","로그인 페이지로 이동합니다");
		model.addAttribute("msg4","false");
		model.addAttribute("url","/memberLogin");
		return "WHview/alert";
	}
	
	@RequestMapping(value = "/member/join",method = RequestMethod.POST)
	public String memberJoin(Member member,Model model) {
		System.out.println("WHController memberJoin start...");
		whService.memberJoin(member);
		return "WHview/memberJoinSuccess";
		
	}
	
	@RequestMapping(value = "/myInfo")
	public String gomyInfo(Model model,HttpSession session) {
		System.out.println("WHController gomyInfo start..");
		Member member = new Member();
		String m_id =(String)session.getAttribute("m_id");
		member.setM_id(m_id);
		if(m_id!=null) {
		member = whService.myInfo(member);
		model.addAttribute("member",member);
		return "WHview/myInfo";
		}
		model.addAttribute("msg1","로그인해주세요");
		model.addAttribute("msg2","로그인이 안되어있어 이용할수없습니다");
		model.addAttribute("msg3","로그인 페이지로 이동합니다");
		model.addAttribute("msg4","false");
		model.addAttribute("url","/memberLogin");
		return "WHview/alert";
	}
	
	@RequestMapping(value = "/myWishList",method = RequestMethod.GET)
	public String gomyWishList(HttpSession session,Model model) {
		System.out.println("WHController gomyWishList start...");
		
		String m_id =(String)session.getAttribute("m_id");
		List<Contents_like_contents> c_noLists = new ArrayList<>();
		
		if(m_id!=null) {
			
			c_noLists = whService.c_noList(m_id);
			model.addAttribute("contents",c_noLists);
			System.out.println("c_nolist.size->"+c_noLists);
			int total=c_noLists.size();
			if (total % 4 == 0) {
					total = (total / 4);
				} else {
					total = total / 4 + 1;
				} 
			model.addAttribute("total",total);
			return "WHview/myWistList";
		}
		model.addAttribute("msg1","로그인해주세요");
		model.addAttribute("msg2","로그인이 안되어있어 내정보를 이용할수없습니다");
		model.addAttribute("msg3","로그인 페이지로 이동합니다");
		model.addAttribute("msg4","false");
		model.addAttribute("url","/memberLogin");
		return "WHview/alert";
		
	}
	
		
		
	@RequestMapping(value = "/memberDelete")
	public String gomemberDelete() {
		return "index";
		
	}
	
	@ResponseBody
	@RequestMapping(value="/member/mailCheck")
	public String mailCheck(String m_email) {
		System.out.println("WHController mailCheck start..");
		String check="";
		check=mailSendService.mailSend(m_email);
		System.out.println(check);
		return check;
	}
	
	@ResponseBody
	@RequestMapping(value = "/member/idCheck")
	public String idCheck(String m_id) {
		System.out.println("WHController idCheck start..");
		int result =0;
		result = whService.idCheck(m_id);
		String result1 = Integer.toString(result);
		System.out.println(result1);
		return result1;
		
	}

	@ResponseBody
	@RequestMapping(value="/member/pwChange")
	public String pwChange(Member member,Model model,HttpSession session) {
		System.out.println("WHController pwChange start..");
		whService.pwChange(member);
		model.addAttribute("msg","비밀번호 변경완료");
		member = whService.myInfo(member);
		System.out.println("m_id->"+member.getM_id());
		System.out.println("m_kind->"+member.getM_active_kind());
		session.setAttribute("m_id", member.getM_id());
		session.setAttribute("m_active_kind", member.getM_active_kind());
		return "member";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/member/InfoChange")
	public String InfoChange(Member member,Model model) {
		System.out.println("WHController InfoChange start...");
		whService.InfoChange(member);
		model.addAttribute("msg","회원정보수정이 완료되었습니다");
		return "msg";	
	}
	
	@RequestMapping(value = "/member/leave")
	public String memberLeave(String m_id,Model model,HttpSession session, Member member) {
		System.out.println("WHController memberLeave start..");
		whService.memberLeave(m_id);
		model.addAttribute("msg1","회원탈퇴 완료");
		model.addAttribute("msg2","회원탈퇴가 성공적으로 완료 되었습니다");
		model.addAttribute("msg3","홈페이지로 이동합니다");
		model.addAttribute("msg4","success");
		model.addAttribute("url","/");
		session.invalidate();
		return "WHview/alert";
	}
	
	
	@RequestMapping(value = "/wishListSearch")
	public String search(Contents_like_contents contents_likes,HttpSession session,Model model) {
		System.out.println("WHController WishListsearch start...");
		System.out.println("keyword->"+contents_likes.getKeyword());
		System.out.println("m_id->"+contents_likes.getM_id());
		List<Contents_like_contents> c_noLists = new ArrayList<>();
		c_noLists = whService.c_List(contents_likes);
		model.addAttribute("contents",c_noLists);
		int total = c_noLists.size();
		if (total % 4 == 0) {
				total = (total / 4);
			} else {
				total = total / 4 + 1;
			} 
		model.addAttribute("total",total);
		return "WHview/myWistList";
	}
//	@ResponseBody
//	@RequestMapping(value = "/wishListSearch")
//	public List<Contents_like_contents> search(Contents_like_contents contents_likes,HttpSession session,Model model) {
//		System.out.println("WHController WishListsearch start...");
//		System.out.println("keyword->"+contents_likes.getKeyword());
//		System.out.println("m_id->"+contents_likes.getM_id());
//		List<Contents_like_contents> c_noLists = new ArrayList<>();
//		c_noLists = whService.c_List(contents_likes);
//		model.addAttribute("contents",c_noLists);
//		int total = c_noLists.size();
//		if (total % 4 == 0) {
//				total = (total / 4);
//			} else {
//				total = total / 4 + 1;
//			} 
//		
//		for(int i=0;i<c_noLists.size();i++) {
//			c_noLists.get(i).setTotal(total);	
//		}
//		
//		return c_noLists;
//	}
	
	
	@ResponseBody
	@RequestMapping(value = "/wishListDelete")
	public List<Contents_like_contents> wishListDelete(@RequestParam(value = "checkBoxArr[]") List<Integer> checkBoxArr,HttpSession session,Model model) {
		Contents_like_contents content = new Contents_like_contents();
		String m_id =(String)session.getAttribute("m_id");
		content.setM_id(m_id);
		System.out.println("valueArr->"+checkBoxArr);
		for(int c_no:checkBoxArr) {
			content.setC_no(c_no);
			whService.wishListDelete(content);
			System.out.println("content.getCno->"+content.getC_no());
		}
		List<Contents_like_contents> c_noLists = new ArrayList<>();
		c_noLists = whService.c_noList(m_id);
		System.out.println("c_niLists.size->"+c_noLists.size());
		int total = c_noLists.size();
		if (total % 4 == 0) {
				total = (total / 4);
			} else {
				total = total / 4 + 1;
			} 
		
		for(int i=0;i<c_noLists.size();i++) {
			c_noLists.get(i).setTotal(total);	
		}
		
		
		
		System.out.println("total->"+total);
		return c_noLists;

	}
	@RequestMapping(value="/memberLogin")
	public String login1() {
		
		return "WHview/memberLogin";
		
	}
	@RequestMapping(value = "/memberLogin1" ,method = RequestMethod.POST)
	public String memberLogin1(Model model,HttpSession session,Member member) {
		System.out.println("WHController memberLogin start...");
		member = whService.login(member);
			if(member.getM_active_kind()==1&&member.getM_kind()==1) {
				session.setAttribute("m_id", member.getM_id());
				return "WHview/memberLoginView";
			}else if(member.getM_active_kind()==2&&member.getM_kind()==1) {
				session.setAttribute("m_id", member.getM_id());
				session.setAttribute("m_active_kind", member.getM_active_kind());
				return "WHview/memberLoginView";
			}else if(member.getM_kind()==2) {
				session.setAttribute("m_id", member.getM_id());
				session.setAttribute("m_kind", member.getM_kind());
				return "WHview/memberLoginView";
			}else if(member.getM_active_kind()==3) {
				model.addAttribute("msg2","탈퇴된 회원입니다 계정을 복구할려면 이메일 인증을해주세요");//이렇게할지 아니면 다시 회원가입으로 돌아가게할지 고민중
				model.addAttribute("msg2","1");
				return "WHview/memberLogin";
			}else {
				System.out.println("memberkind="+member.getM_kind());
				model.addAttribute("msg","1");
				model.addAttribute("msg1","아이디 또는 비밀번호를 확인해주세요");
				return "WHview/memberLogin";
			}
		
	
	}
	@RequestMapping(value = "/memberFind",method = RequestMethod.POST)
	public String memberFind1(Member member,Model model,String m_email) {
		System.out.println("WHController memberFind start..");
		int result = 0;
		System.out.println("member.m_email->"+m_email);
		result = mailSendService.memberFind(member);
		System.out.println("result->"+result);
		if(result==1) {
		model.addAttribute("msg1","임시비밀번호 발급 성공");
		model.addAttribute("msg2","임시비밀번호가 발급되었습니다");
		model.addAttribute("msg3","로그인페이지로 이동합니다");
		model.addAttribute("msg4","success");
		model.addAttribute("url","/memberLogin");
		System.out.println("성공");
		return "WHview/alert";
		}else {
			model.addAttribute("msg4","1");
			return "WHview/memberLogin";
			
		}
		
	}
	@RequestMapping(value = "/myInfo2")
	public String gomyInfo2(Model model,HttpSession session) {
		System.out.println("WHController gomyInfo start..");
		Member member = new Member();
		String m_id =(String)session.getAttribute("m_id");
		member.setM_id(m_id);
		if(m_id!=null) {
		member = whService.myInfo(member);
		model.addAttribute("member",member);
		return "WHview/myInfo2";
		}
		model.addAttribute("msg1","로그인해주세요");
		model.addAttribute("msg2","로그인이 안되어있어 이용할수없습니다");
		model.addAttribute("msg3","로그인 페이지로 이동합니다");
		model.addAttribute("msg4","false");
		model.addAttribute("url","/memberLogin");
		return "WHview/alert";
	}
	
	@RequestMapping(value = "/memberJoin")
	public String goJoin2() {
		return "WHview/memberJoin";
	}
	
}
