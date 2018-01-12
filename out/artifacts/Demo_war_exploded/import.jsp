<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="org.apache.poi.hssf.usermodel.HSSFDateUtil" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="org.apache.poi.ss.usermodel.Cell" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.rad.util.*" %>
<%@page import="org.json.JSONObject" %>
<%@page import="com.rad.db.SqlManager" %>
<%@page import="java.util.*" %>
<%@page import="java.util.regex.*" %>
<%@page import="com.rad.db.*" %>
<%@ page import="com.jt.entity.SUserInfo" %>


<%
    String webRoot = request.getContextPath();
    String remoteAddr = request.getRemoteAddr();
    String accessTime = new java.text.SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" ).format( new java.util.Date() );

    SUserInfo userInfo = (SUserInfo) request.getSession().getAttribute( "userInfo" );
/*    SCompanyInfo sCompanyInfo = (SCompanyInfo) request.getSession().getAttribute( "companyInfo" );*/

    String titleName = "test";
    java.util.Enumeration<String> checkQueryParas = request.getParameterNames();
    String checkQueryPara = "";
    String checkQueryParaValue = "";
    boolean checkQueryParaResult = true;
    String pageUrl = request.getServletPath();
    while (checkQueryParas.hasMoreElements()) {
        checkQueryPara = checkQueryParas.nextElement();
        checkQueryParaValue = request.getParameter( checkQueryPara );

        if (checkQueryParaValue != null && !checkQueryParaValue.equals( "" )) {
            checkQueryParaValue = checkQueryParaValue.toLowerCase();
            if (checkQueryParaValue.indexOf( "script" ) >= 0) checkQueryParaResult = false;
            else if (checkQueryParaValue.indexOf( "eval" ) >= 0) checkQueryParaResult = false;
            else if (checkQueryParaValue.indexOf( "e-xpression" ) >= 0) checkQueryParaResult = false;
            else if (checkQueryParaValue.indexOf( "e-xpression" ) >= 0) checkQueryParaResult = false;
            else if (checkQueryParaValue.indexOf( "onload" ) >= 0) checkQueryParaResult = false;
            else if (checkQueryParaValue.indexOf( "window.open" ) >= 0) checkQueryParaResult = false;
            else if (checkQueryParaValue.indexOf( "iframe" ) >= 0) checkQueryParaResult = false;
            else if (checkQueryParaValue.indexOf( " and " ) >= 0) checkQueryParaResult = false;
            else if (checkQueryParaValue.indexOf( " or " ) >= 0) checkQueryParaResult = false;
            else {
                if (checkQueryParaValue.indexOf( "<a" ) >= 0 || checkQueryParaValue.indexOf( "<img" ) >= 0 ||
                        checkQueryParaValue.indexOf( "&lt;" ) >= 0 || checkQueryParaValue.indexOf( "&gt;" ) >= 0)
                    checkQueryParaResult = false;
            }
        }


        if (!checkQueryParaResult) {
            out.println( "<script>alert('非法数据');window.history.back();</script>" );
            return;
        }
    }


%>



