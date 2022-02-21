package com.oracle.tour.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.oracle.tour.dao.LJPlannerRepository;
import com.oracle.tour.domain.Planner;
import com.oracle.tour.dto.PlannerDTO;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

/*
 * 이진호
 * 플래너 ServiceImpl
 */

@Service
public class LJPlannerServiceImpl implements LJPlannerService {
    @Autowired
    private LJPlannerRepository repository;

    @Override
    public PlannerDTO insertPlanner(PlannerDTO dto) throws ParseException {
        Planner entity = dtoToEntity(dto);
        Planner planner = repository.save(entity);
        PlannerDTO plannerDTO = entityToDto(planner);
        return plannerDTO;
    }

    
    /*
     * planList 페이지에서 보여줄 모든 planner 조회 (sessionId 기준으로)
     * */
    @Override
    public List<PlannerDTO> selectPlanners(String id) {
        List<Planner> planners = repository.findAllByIdOrderByPlannerNoDesc(id);
        List<PlannerDTO> dto = new ArrayList<PlannerDTO>();
        for(Planner planner : planners){
            dto.add(entityToDto(planner));
        }
        return dto;
    }

    @Override
    public PlannerDTO selectPlanner(Long plannerNo) {
        Planner planner = repository.findByPlannerNo(plannerNo);
        PlannerDTO dto = entityToDto(planner);
        return  dto;
    }

    @Override
    public void deletePlanner(Long plannerNo) {
        repository.deleteByPlannerNo(plannerNo);
    }

}
