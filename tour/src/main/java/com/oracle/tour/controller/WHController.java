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
	
	
	@RequestMapping(value = "/memberLogin")
	public String goLogin(HttpSession session,Model model) {
		String m_id =(String)session.getAttribute("m_id");
		if(m_id!=null) {
			model.addAttribute("msg1","이미 로그인 되어있습니다 다른아이디로 로그인시 로그아웃후에 로그인해주세요");
			model.addAttribute("url","/");
			return "WHview/alert";
		}
		return "WHview/memberLogin";	
	}
	
	@RequestMapping(value = "/memberLogout")
	public String logout(HttpSession session,Model model) {
		System.out.println("WHController logout Start..");
		String m_id =(String)session.getAttribute("m_id");
		if(m_id!=null) {
			session.invalidate();
			return "WHview/memberLogout";
		}
		model.addAttribute("msg1","로그인이 안되어있어 로그아웃을할수없습니다");
		model.addAttribute("url","/memberLogin");
		return "WHview/alert";
	}
	
	@RequestMapping(value = "/memberJoin")
	public String goJoin() {
		return "WHview/memberJoin";
	}
	
	@RequestMapping(value = "/memberFind")
	public String goFind() {
		return "WHview/memberFind";
	}
	@RequestMapping(value="/memberUpdate")
	public String goMemberUpdate() {
		return "WHview/memberUpdate";
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
		model.addAttribute("msg1","로그인이 안되어있어 로그아웃을할수없습니다");
		model.addAttribute("url","/memberLogin");
		return "WHview/alert";
	}
	
//	@RequestMapping(value = "myWishList")
//	public String gomyWishList(HttpSession session,Model model) {
//		System.out.println("WHController gomyWishList start...");
//		String m_id =(String)session.getAttribute("m_id");
//		List<Contents_like> contents = new ArrayList<>();
//		contents=whService.myWishList(m_id);
//		return "WHview/myWistList";
//	}
	
	
	@RequestMapping(value = "/myWishList")
	public String gomyWishList(HttpSession session,Model model) {
		System.out.println("WHController gomyWishList start...");
		
		String m_id =(String)session.getAttribute("m_id");
		List<Contents_like_contents> c_noLists = new ArrayList<>();;
		int total=c_noLists.size();
		if (total % 4 == 0) {
				total = (total / 4);
			} else {
				total = total / 4 + 1;
			} 
		model.addAttribute("total",total);
		if(m_id!=null) {
			
			c_noLists = whService.c_noList(m_id);
			model.addAttribute("contents",c_noLists);
			return "WHview/myWistList";
		}
		
		model.addAttribute("msg1","로그인이 안되어있어 내정보를 이용할수없습니다");
		model.addAttribute("url","/memberLogin");
		return "WHview/alert";
	}
	@RequestMapping(value = "myPlanner")
	public String gomyPlanner() {
		return "WHview/myPlanner";
	}
	
	@RequestMapping(value = "/myPlannerList")
	public String gomyPlannerList() {
		return "WHview/myPlannerList";
	}
	
	@RequestMapping(value = "/myPlannerWrite")
	public String gomyPlannerWrite() {
		return "WHview/myPlannerWrite";
	}
	
	@RequestMapping(value = "/memberDelete")
	public String gomemberDelete() {
		return "index";
		
	}
	@RequestMapping(value = "/member/login" ,method = RequestMethod.POST)
	public String memberLogin(Model model,HttpSession session,Member member) {
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
				model.addAttribute("msg1","탈퇴된 회원입니다 계정을 복구할려면 이메일 인증을해주세요");//이렇게할지 아니면 다시 회원가입으로 돌아가게할지 고민중
				model.addAttribute("url","/passwordFind");
				return "WHview/alert";
			}else {
				System.out.println("memberkind="+member.getM_kind());
				model.addAttribute("msg","아이디혹은 비밀번호가 틀렸습니다");
				return "WHview/loginFailView";
			}
		
	
	}
	
	@RequestMapping(value = "/member/join",method = RequestMethod.POST)
	public String memberJoin(Member member,Model model) {
		System.out.println("WHController memberJoin start...");
		whService.memberJoin(member);
		return "WHview/memberJoinSuccess";
		
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
	@RequestMapping(value = "/passwordFind")
	public String passwordFind() {
		System.out.println("WHController passwordFind start..");
		return "WHview/passwordFind";
		
	}
	@ResponseBody
	@RequestMapping(value="/member/pwChange")
	public String pwChange(Member member,Model model) {
		System.out.println("WHController pwChange start..");
		whService.pwChange(member);
		model.addAttribute("msg","비밀번호 변경완료");
		return "member";
	}
	
	
	@RequestMapping(value = "/member/find",method = RequestMethod.POST)
	public String memberFind(Member member,Model model) {
		System.out.println("WHController memberFind start..");
		int result = 0;
		result = mailSendService.memberFind(member);
		if(result==1) {
		model.addAttribute("msg1","임시비밀번호 발급이완료되었습니다");
		model.addAttribute("url","/memberLogin");
		return "WHview/alert";
		}else {
			model.addAttribute("msg1","아이디 또는 이메일을 확인해주세요");
			model.addAttribute("url","/passwordFind");
			return "WHview/alert";
		}
		
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
	public String memberLeave(String m_id,Model model,HttpSession session) {
		System.out.println("WHController memberLeave start..");
		whService.memberLeave(m_id);
		model.addAttribute("msg1","회원탈퇴가 완료되었습니다");
		model.addAttribute("url","/");
		session.invalidate();
		return "WHview/alert";
	}
	
	
	@RequestMapping(value = "/myWishList/search")
	public String search(Contents_like_contents contents_likes,HttpSession session,Model model) {
		System.out.println("WHController gomyWishList start...");
		System.out.println("keyword->"+contents_likes.getKeyword());
		System.out.println("m_id->"+contents_likes.getM_id());
		List<Contents_like_contents> c_noLists = new ArrayList<>();
		c_noLists = whService.c_List(contents_likes);
		model.addAttribute("contents",c_noLists);
		int total=c_noLists.size();
		if (total % 4 == 0) {
				total = (total / 4);
			} else {
				total = total / 4 + 1;
			} 
		return "WHview/myWistList";
	}	
	
//	@ResponseBody
//	@RequestMapping(value = "/myWishList/search")
//	public String search(Contents_like contents_like,HttpSession session,Model model) {
//		System.out.println("WHController gomyWishList start...");
//		System.out.println("keyword->"+contents_like.getKeyword());
//		List<Contents_like> c_noLists = new ArrayList<>();
//		c_noLists = whService.c_List(contents_like);
//		model.addAttribute("contents",c_noLists);
//		int total=c_noLists.size();
//		if (total % 4 == 0) {
//				total = (total / 4);
//			} else {
//				total = total / 4 + 1;
//			} 
//		return "contents";
//	}
	@ResponseBody
	@RequestMapping(value = "/wishListDelete")
	public String wishListDelete(@RequestParam(value = "checkBoxArr[]") List<Integer> checkBoxArr,HttpSession session,Model model) {
		Contents_like_contents content = new Contents_like_contents();
		String m_id =(String)session.getAttribute("m_id");
		content.setM_id(m_id);
		System.out.println("valueArr->"+checkBoxArr);
		for(int c_no:checkBoxArr) {
			content.setC_no(c_no);
			whService.wishListDelete(content);
			System.out.println("content.getCno->"+content.getC_no());
		}
		model.addAttribute("msg","찜목록삭제완료");
		return "redirect:/myWishList";
	


		
	}
}
