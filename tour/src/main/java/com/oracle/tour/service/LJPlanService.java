package com.oracle.tour.service;

import java.util.List;


import com.oracle.tour.domain.Plan;
import com.oracle.tour.dto.PlanDTO;
import com.oracle.tour.dto.PlannerDTO;

/*
 * 이진호
 * 플랜 Service
 */
public interface LJPlanService {
    List<PlanDTO> selectPlans(PlannerDTO planner);
    List<PlanDTO> joinPlans(List<PlannerDTO> planners);
    List<PlanDTO> selectPlan(Long plannerNo);
    void deletePlans(Long plannerNo);

    default PlanDTO entityToDto(Plan plan){
        PlanDTO dto = PlanDTO.builder()
                .planNo(plan.getPlanNo())
                .plannerNo(plan.getPlannerNo())
                .id(plan.getId())
                .name(plan.getName())
                .intro(plan.getIntro())
                .day(plan.getDay())
                .x(plan.getX())
                .y(plan.getY())
                .build();
        return dto;
    }

    default Plan dtoToEntity(PlanDTO dto){
        Plan plan = Plan.builder()
                .planNo(dto.getPlanNo())
                .plannerNo(dto.getPlannerNo())
                .id(dto.getId())
                .name(dto.getName())
                .intro(dto.getIntro())
                .day(dto.getDay())
                .x(dto.getX())
                .y(dto.getY())
                .build();
        return plan;
    }
}
