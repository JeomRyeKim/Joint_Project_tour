package com.oracle.tour.dao;



import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.transaction.annotation.Transactional;

import com.oracle.tour.domain.Plan;

import java.util.Date;
import java.util.List;

/*
 * 이진호
 * 플랜 관련 Repository
 */
public interface LJPlanRepository extends JpaRepository<Plan, Long> {
    List<Plan> findAllByPlannerNoAndDayBetweenOrderByPlanNo(Long plannerNo, Date start,Date end);
    List<Plan> findAllByPlannerNoOrderByPlanNo(Long plannerNo);
    @Transactional
    void deleteAllByPlannerNo(Long plannerNo);
    @Transactional
    void deleteByPlanNo(Long planNo);
}
