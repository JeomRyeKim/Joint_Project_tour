package com.oracle.tour.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.tour.dto.Board;
import com.oracle.tour.dto.Command;
import com.oracle.tour.dto.Contents;
import com.oracle.tour.service.SHService;

@Controller
public class SHController {
	private static final Logger logger = LoggerFactory.getLogger(SHController.class);
	private final SHService shS;

	@Autowired
	public SHController(SHService shS) {
		this.shS = shS;
	}

	// index 페이지
	@RequestMapping("/")
	public String goIndex(Model model, HttpServletRequest request) {
		System.out.println("controller index Start");
		// 관광지 리스트 뽑기
		List<Contents> tourList = shS.getTourList();
		model.addAttribute("tourList", tourList);
		// 숙소 리스트 뽑기
		List<Contents> hotelList = shS.getHotelList();
		model.addAttribute("hotelList", hotelList);
		// 음식점 리스트 뽑기
		List<Contents> foodList = shS.getFoodList();
		model.addAttribute("foodList", foodList);

		// 게시글 리스트 뽑기
		List<Board> boardList = shS.getBoardList();
		model.addAttribute("boardList", boardList);

		HttpSession session = request.getSession();
		String m_id = (String) session.getAttribute("m_id");
		session.setAttribute("m_id", m_id);

		return "index";
	}

	// 지역 페이지로 이동
	@RequestMapping("/local")
	public String goIocal(Model model, String c_local) {
		System.out.println("controller local Start");
		// 지역 리스트 뽑기
		Contents localCon = shS.getLocalCon(c_local);
		model.addAttribute("localCon", localCon);

		List<Contents> localTourList = shS.getlocalTourList(c_local);
		model.addAttribute("localTourList", localTourList);

		List<Contents> localHotelList = shS.getlocalHotelList(c_local);
		model.addAttribute("localHotelList", localHotelList);

		List<Contents> localFoodList = shS.getlocalFoodList(c_local);
		model.addAttribute("localFoodList", localFoodList);

		return "SHview/local";
	}

	// 컨텐츠 상세보기
	@RequestMapping("/detail")
	public String godetail(Model model, String c_no, String c_local, HttpServletRequest request) {
		System.out.println("SHcontroller detail Start");
		Contents detailContent = shS.getDetailContent(c_no);
		model.addAttribute("detailCon", detailContent);

		List<Command> comList = shS.getCommandList(c_no);
		model.addAttribute("comList", comList);
		
		//해당 지역 리스트 뽑기
		List<Contents> localCon = shS.getAllLocalList(c_local);
		model.addAttribute("localCon", localCon);
		
		//댓글 개수 
		int commandCnt = shS.getCommandCnt(c_no);
		model.addAttribute("commandCnt",commandCnt);
		
		HttpSession session = request.getSession();
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("MEMBER ID :" + m_id);
		session.setAttribute("m_id", m_id);

		int likeCnt = shS.getLikeCnt(c_no);
		model.addAttribute("likeCnt", likeCnt);

		
		if(m_id!=null) {
			int memberLikeCnt = shS.getMemberLikeCnt(c_no, m_id);
			System.out.println("memberLikeCnt ->" + memberLikeCnt);
			model.addAttribute("memberLikeCnt", memberLikeCnt);
			
			int cartCnt = shS.getCartCnt(c_no, m_id);
			System.out.println("cartCnt :" + cartCnt);
			model.addAttribute("cartCnt", cartCnt);
		}
		
		return "SHview/detail";
	}



	// index 페이지에서 전체보기
	@RequestMapping("/AllList")
	public String goAllList(Model model, String c_category, String c_local, Contents con) {
		System.out.println("SHController AllList Start..");

		List<Contents> allList = shS.getAllList(c_category);
		model.addAttribute("allList", allList);

		int total = shS.getCountAllList(c_category);
		if (total % 3 == 0) {
			total = (total / 3);
		} else {
			total = total / 3 + 1;
		}

		model.addAttribute("total", total);

		return "SHview/allList";
	}

	// 지역 페이지에서 전체보기
	@RequestMapping(value = "localAllList")
	public String goLocalAllList(Model model, Contents con) {
		System.out.println("SHController LocalAllList Start..");

		List<Contents> localAllList = shS.getLocalAllList(con);
		System.out.println("SHController localAllList.size ->" + localAllList.size());
		model.addAttribute("localAllList", localAllList);

		int total = shS.getCountLocalAllList(con);
		System.out.println("SHController CountLocalAllList size->" + total);

		if (total % 3 == 0) {
			total = (total / 3);
		} else {
			total = total / 3 + 1;
		}
		model.addAttribute("total", total);
		return "SHview/localAllList";
	}

	// 컨텐츠등록페이지로 이동
	@RequestMapping("/uploadContentForm")
	public String uploadContentView(HttpServletRequest request,Model model) {
		HttpSession session = request.getSession();
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("MEMBER ID :" + m_id);
		model.addAttribute("m_id", m_id);
		
		return "SHview/uploadContentForm";
	}

	// 컨텐츠 등록
	@RequestMapping(value = "uploadContent", method = RequestMethod.POST)
	public String uploadContent(Model model, Contents con, HttpServletRequest request, MultipartFile[] c_image)
			throws Exception {
		System.out.println("SHController uploadContents Start..");
		String uploadPath = request.getSession().getServletContext()
				.getRealPath("/resources/image/" + con.getC_local());
		System.out.println("uploadPath:" + uploadPath);
		String[] saveName = new String[3];
		
		for(int i=0;i<saveName.length;i++) {
			saveName[i] = uploadFile(c_image[i].getOriginalFilename(), c_image[i].getBytes(), uploadPath);
		}
		
		con.setC_image1(saveName[0]);
		con.setC_image2(saveName[1]);
		con.setC_image3(saveName[2]);

		
		int result = shS.uploadContent(con);
		System.out.println("SHController uploadContent result->"+result);
		model.addAttribute("result",result);
		
		Contents con1 = shS.getCountAllCon(con);
		model.addAttribute("con",con);
		model.addAttribute("con1",con1);
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!"+con1.getC_no());
		

		return "SHview/uploadContentResult";
	}
	//컨텐츠 등록 이미지 이름 정해주는 메소드
	private String uploadFile(String originalFilename, byte[] fileData, String uploadPath) throws Exception {
		UUID uid = UUID.randomUUID();

		String savedName = uid.toString() + "_" + originalFilename;
		File target = new File(uploadPath, savedName);
		FileCopyUtils.copy(fileData, target);
		return savedName;
	}

	//컨텐츠 삭제(관리자)
	@RequestMapping("/deleteContent")
	public String deleteContent(String c_no,Model model) {
		System.out.println("SHController deleteContent Start..");
		int result = shS.deleteContent(c_no);
		System.out.println("deleteContent->"+result);
		model.addAttribute("result",result);
		return "SHview/deleteContentResult";
	}
	
	//컨텐츠 수정 폼으로 이동(관리자)
	@RequestMapping("/updateContentForm")
	public String updateContent(String c_no,Model model,HttpServletRequest request) {
		System.out.println("SHController updateContentForm Start..");
		Contents con = shS.getDetailContent(c_no);
		model.addAttribute("con",con);
		
		HttpSession session = request.getSession();
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("MEMBER ID :" + m_id);
		model.addAttribute("m_id", m_id);
		
		List<Contents> localList = shS.getUpdateLocalList();
		model.addAttribute("local",localList);
		
		List<Contents> categoryList = shS.getUpdateCategoryList();
		model.addAttribute("category",categoryList);
		return "SHview/updateContentForm";
	}
	
	///컨텐츠 수정(관리자)
	@RequestMapping(value="/updateContent" ,method = RequestMethod.POST)
	public String updateContent(Model model, Contents con, HttpServletRequest request, MultipartFile[] c_image) throws Exception{
		System.out.println("SHController updateContent Start...");
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/image/" + con.getC_local());
		
		String imageName[] = {con.getC_image1() , con.getC_image2() , con.getC_image3()};
		String updateImageName[] = new String[3];
		
		for(int i=0;i<c_image.length;i++) {
			if(c_image[i].isEmpty()) {
				updateImageName[i] = imageName[i];
			}else {
				updateImageName[i] = uploadFile(c_image[i].getOriginalFilename(), c_image[i].getBytes(), uploadPath);
			}
		}
		con.setC_image1(updateImageName[0]);
		con.setC_image2(updateImageName[1]);
		con.setC_image3(updateImageName[2]);
		
		System.out.println("updateImageName[0]"+updateImageName[0]);
		System.out.println("updateImageName[1]"+updateImageName[1]);
		System.out.println("updateImageName[2]"+updateImageName[2]);
		
		int result = shS.updateContent(con); 
		model.addAttribute("result",result);
		model.addAttribute("con",con);
		System.out.println(con.getC_no());
		
		return "SHview/updateContentResult";
	}
	
	//컨텐츠 검색
	@RequestMapping("/content_Search")
	public String contentSearch(Model model,String search) {
		System.out.println("SHController contentSearch Start..");
		List<Contents> searchList = shS.getSearchList(search);
		model.addAttribute("searchText",search);
		model.addAttribute("search",searchList);
		
		int total = shS.getCountSearchList(search);
		if (total % 3 == 0) {
			total = (total / 3);
		} else {
			total = total / 3 + 1;
		}

		model.addAttribute("total", total);
		return "SHview/searchView";
	}
}
