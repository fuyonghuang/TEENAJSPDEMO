package com.jt.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.SimpleFormatter;

/**
 * Created by  2018/1/4.
 */
public class DateUtils {
    /**
     * 将时间格式化成字符串
     * @param date
     * @return
     */
    public static  String formatDateToString(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
        return  sdf.format( date );
    }


}
