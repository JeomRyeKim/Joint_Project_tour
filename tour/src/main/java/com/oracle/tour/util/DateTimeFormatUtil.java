package com.oracle.tour.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/*
 * 이진호
 * 날짜 시간 포맷변경 유틸
 */
public class DateTimeFormatUtil {
    public static String changeToYMD(LocalDateTime dateTime){
        return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    public static String changeToYMDHM(LocalDateTime dateTime){
        return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm"));
    }
}
