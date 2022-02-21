package com.oracle.tour.dto;


import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 * 이진호
 * 플랜 DTO
 */

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PlanDTO {
	private Long planNo;
    private Long plannerNo;
    private String id;
    private Date day;
    private String name;
    private String intro;
    private Float x;
    private Float y;
}
