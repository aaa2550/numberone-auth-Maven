package com.numberONe.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by yanghailong on 2017/10/16.
 */
public class TimeUtils {

    public static final String TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";

    public static final String DAY_DEFAULT = "yyyy-MM-dd";

    public static String getDate(String pattern){
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
        return dateFormat.format(new Date());
    }

    public static String getDate(){
        return getDate(TIME_PATTERN);
    }

}
