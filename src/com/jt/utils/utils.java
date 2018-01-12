package com.jt.utils;

/**
 * Created by  2018/1/9.
 */
public class utils {


    public static String switchStatus(String str) {
        switch (str) {
            case "0":
                return "待认领";
            case "1":
                return "已认领处理中";
            case "2":
                return "退回";
            case "3":
                return "已完成";
            case "4":
                return "已过期";
            default:
                return "待认领";
        }
    }
}
