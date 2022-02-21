package com.oracle.tour.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/*
 * 이진호
 * 플래너 DTO
 */

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class PlannerDTO {
    private Long plannerNo;
    private String id;
    private String title;
    /* site : 선택한 지역명으로 지도에 지역 띄워주는 용도 데이터에는 안들어감 */
    private String site;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fDate; 

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lDate;

    private String intro;
    private Date wDate; 

    public void setFDate(String fDate) throws ParseException {
        SimpleDateFormat fm  = new SimpleDateFormat("yyyy-MM-dd");
        Date first_date = fm.parse(fDate);
        this.fDate = first_date;
    }

    public void setLDate(String lDate) throws ParseException { 
        SimpleDateFormat fm  = new SimpleDateFormat("yyyy-MM-dd"); 
        Date last_date = fm.parse(lDate);
        this.lDate = last_date; 
    }

    public void setWDate(String WDate) throws ParseException { 
        SimpleDateFormat fm  = new SimpleDateFormat("yyyy-MM-dd"); 
        Date write_date = fm.parse(WDate);
        this.wDate = write_date; 
    }
}
