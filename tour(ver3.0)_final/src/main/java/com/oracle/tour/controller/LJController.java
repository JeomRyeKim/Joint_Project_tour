package com.oracle.tour.controller;

import org.slf4j.Logger;



import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.tour.dto.Member;
import com.oracle.tour.dto.PlanDTO;
import com.oracle.tour.dto.PlannerDTO;
import com.oracle.tour.service.LJPlanServiceImpl;
import com.oracle.tour.service.LJPlannerServiceImpl;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




/*
 *  이진호
 *  플래너 Controller
 */

@Controller
public class LJController {
	private static final Logger logger = LoggerFactory.getLogger(LJController.class);
	
	@Autowired
    private LJPlannerServiceImpl plannerService;
    @Autowired
    private LJPlanServiceImpl planService;

    
    /*
     * 플래너 상세보기
     * */
    @RequestMapping("/planD")
    public String planDetail(PlannerDTO dto, Model model) throws Exception {
    	System.out.println("LJController planDetail Start...");
        PlannerDTO planner = plannerService.selectPlanner(dto.getPlannerNo());
        List<Date> dates = planService.getDiffDays(planner.getFDate(), planner.getLDate());
        List<PlanDTO> plans = planService.selectPlan(dto.getPlannerNo());
        model.addAttribute("planner", planner);
        model.addAttribute("dates", dates);
        model.addAttribute("plans", plans);
        System.out.println("LJController planDetail dates.size -> " + dates.size());
        System.out.println("LJController planDetail plans.size -> " + plans.size());

        return "/LJview/planDetail";
    }


    /*
     * 마이플래너 첫 화면 & 내플래너들 보기
     * */
    @RequestMapping("/planL")
    public String planList(Member member, Model model, HttpSession session) throws Exception {
    	System.out.println("LJController planList Start...");
    	// session id를  m_id로 필터링 하고 그거로 planner에서 조회 
    	String m_id = (String) session.getAttribute("m_id");
    	
        List<PlannerDTO> planners = plannerService.selectPlanners(m_id);
        List<PlanDTO> plans = planService.joinPlans(planners);
        model.addAttribute("planners", planners);
        model.addAttribute("plans", plans);
        System.out.println("LJController planList planners.size() -> " + planners.size());
        System.out.println("LJController planList plans.size() -> " + plans.size());

        return "/LJview/planList";
    }

    
    /*
     * 플래너 만들기 .저장
     * */
    @RequestMapping(value = "/plannerInsert", method = RequestMethod.POST)
    @ResponseBody
    public String planInsert(@RequestParam(value = "date[]") List<String> date, 
    					     @RequestParam(value = "place[]") List<String> place, 
    					     @RequestParam(value = "plan_intro[]") List<String> plan_intro, 
    					     @RequestParam(value = "x[]") List<String> x, 
    					     @RequestParam(value = "y[]") List<String> y, 
    					     @RequestParam(value = "time[]") List<String> time, PlannerDTO dto) 
    					    		 throws ParseException {
    	System.out.println("LJController plansInsert Start....");
        PlannerDTO plannerDTO = plannerService.insertPlanner(dto);

        List<Date> days = planService.changeDateList(date, time);
        List<Float> float_x = planService.changeFloatList(x);
        List<Float> float_y = planService.changeFloatList(y);

        List<PlanDTO> plans = planService.returnPlan(days, place, plan_intro, float_x, float_y, plannerDTO.getPlannerNo(), plannerDTO.getId());
        planService.insertPlan(plans);
        logger.info("plans.size -> ", plans.size());
        return "planL?id=" + dto.getId();
    }

    
    /*
     * 플래너 수정하기 .저장
     * */
    @RequestMapping(value = "/plannerUpdate", method = RequestMethod.POST)
    @ResponseBody
    public String plannerUpdate(@RequestParam(value = "planNo[]") List<String> planNo, 
    							@RequestParam(value = "date[]") List<String> date, 
    							@RequestParam(value = "place[]") List<String> place, 
    							@RequestParam(value = "plan_intro[]") List<String> plan_intro, 
    							@RequestParam(value = "y[]") List<String> y, 
    							@RequestParam(value = "x[]") List<String> x, 
    							@RequestParam(value = "time[]") List<String> time, PlannerDTO planner) 
    									throws ParseException {
    	System.out.println("LJController plannerUpdate Start....");
        PlannerDTO plannerDTO = plannerService.insertPlanner(planner);

        List<Date> days = planService.changeDateListForUpdate(date, time); 
        List<Float> float_x = planService.changeFloatList(x);
        List<Float> float_y = planService.changeFloatList(y);
        List<Long> long_planNo = planService.changeLongList(planNo);

        List<PlanDTO> plans = planService.returnUpdatePlan(days, place, plan_intro, float_x, float_y, long_planNo, plannerDTO.getPlannerNo(), plannerDTO.getId());
        planService.updatePlans(plans, planner.getPlannerNo());
        planService.insertPlan(plans);
        logger.info("plans.size -> ", plans.size());

        return "planD?plannerNo=" + planner.getPlannerNo();
    }

    
    /*
     * 플래너 삭제하기
     * */
    @RequestMapping("plannerDelete")
    public String deletePlanner(PlannerDTO dto, Model model) {
    	System.out.println("LJController deletePLanner Start....");
        planService.deletePlans(dto.getPlannerNo());
        plannerService.deletePlanner(dto.getPlannerNo());

        return "redirect:/planL?id=" + dto.getId();
    }

    
    /*
     * 플래너 만들기 
     * */
    @RequestMapping("/goPlanI")
    public String goInsertPage(PlannerDTO dto, Model model) throws Exception {
    	System.out.println("LJController goInsertPage Start...");
        List<Date> days = planService.getDiffDays(dto.getFDate(), dto.getLDate());
        model.addAttribute("days", days);
        model.addAttribute("planner_user", dto);
        System.out.println("LJController goInsertPage days.size -> " + days.size());

        return "/LJview/planInsert";
    }

    
    /*
     * 플래너 수정하기
     * */
    @RequestMapping("/goPlanU")
    public String goUpdatePage(PlannerDTO dto, Model model) throws Exception {
    	System.out.println("LJController goUpdatePage Start....");
        List<Date> days = planService.getDiffDays(dto.getFDate(), dto.getLDate());
        List<PlanDTO> plans = planService.selectPlan(dto.getPlannerNo());
        model.addAttribute("days", days);
        model.addAttribute("planner_user", dto);
        model.addAttribute("plans", plans);
        System.out.println("LJController goUpdatePage days.size -> " + days.size());
        System.out.println("LJController goUpdatePage plans.size -> " + plans.size());

        return "/LJview/planUpdate";
    }
	

	
	
}
