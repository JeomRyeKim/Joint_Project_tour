package com.oracle.tour.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.tour.domain.Planner;

import java.util.List;

/*
 * 이진호
 * 플래너 관련 Repository            --> JpaRepository로 데이터 조회
 */
@Repository
public interface LJPlannerRepository extends JpaRepository<Planner, Long> {
    List<Planner> findAllByIdOrderByPlannerNoDesc(String id);
    Planner findByPlannerNo(Long plannerNo);
    @Transactional
    void deleteByPlannerNo(Long plannerNo);
}
