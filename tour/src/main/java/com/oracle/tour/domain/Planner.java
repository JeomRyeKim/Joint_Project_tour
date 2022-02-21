package com.oracle.tour.domain;

import lombok.*;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;


/*
 * 이진호
 * 플래너 Entity
 */

@Entity
@Table(name="PLANNER_TBL")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@ToString
@Builder
@SequenceGenerator(name = "PLANNER_SEQ_GENERATOR", sequenceName = "PLANNER_SEQ", initialValue = 1, allocationSize = 1)
public class Planner {

    @Id
    @Column(name = "planner_no", nullable = false)
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "PLANNER_SEQ_GENERATOR")
    private Long plannerNo;

    @Column(name = "m_id")
    private String id;

    @Column(nullable = false)
    private String title;

    @Column(name = "f_date", nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fDate;

    @Column(name = "l_date", nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lDate;

    private String intro;

    @Column(name = "w_date")
    private Date wDate;

    @PrePersist
    protected void onWrite(){
        wDate = new Date();
    }
}
