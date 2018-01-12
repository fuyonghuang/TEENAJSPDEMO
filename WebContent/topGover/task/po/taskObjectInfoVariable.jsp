<%@ page import="com.jt.utils.DateUtils" %>
<%@ page import="java.util.Date" %><%
    /**
     * 变量定义
     */
    //任务对象id
    String taskObjectId = request.getParameter( "taskObjectId" ) == null ? "": request.getParameter( "taskObjectId" );
    //
    String taskId = request.getParameter( "taskId" ) == null ? "" : request.getParameter( "taskId" );
    //任务名称
    String taskName = request.getParameter( "taskName" ) == null ? "" : request.getParameter( "taskName" );
    //被检查单位
    String companyCode = request.getParameter( "companyCode" ) == null ? "" : request.getParameter( "companyCode" );
    //被检查单位名称
    String companyName = request.getParameter( "companyName" ) == null ? "" : request.getParameter( "companyName" );
    String checkCompanyCode = request.getParameter( "checkCompanyCode" ) == null ? "" : request.getParameter( "checkCompanyCode" );
    String checkCompanyName = request.getParameter( "checkCompanyName" ) == null ? "" : request.getParameter( "checkCompanyName" );
    String userId = request.getParameter( "userId" ) == null ? "" : request.getParameter( "userId" );
    String userName = request.getParameter( "userName" ) == null ? "" : request.getParameter( "userName" );
    String taskObjctType = request.getParameter( "taskObjctType" ) == null ? "" : request.getParameter( "taskObjctType" );
    String confirmTime = DateUtils.formatDateToString( new Date(  ) );
    String confirmUserId = request.getParameter( "confirmUserId" ) == null ? "" : request.getParameter( "confirmUserId" );
    String confirmUserName = request.getParameter( "confirmUserName" ) == null ? "" : request.getParameter( "confirmUserName" );
    String taskStartTime = request.getParameter( "taskStartTime" ) == null ? "" : request.getParameter( "taskStartTime" );
    String taskEndTime = request.getParameter( "taskEndTime" ) == null ? "" : request.getParameter( "taskEndTime" );
    String handleTime = request.getParameter( "handleTime" ) == null ? "" : request.getParameter( "handleTime" );
    String handleUserId = request.getParameter( "handleUserId" ) == null ? "" : request.getParameter( "handleUserId" );
    String handleUserName = request.getParameter( "handleUserName" ) == null ? "" : request.getParameter( "handleUserName" );
    String status = request.getParameter( "status" ) == null ? "0" : request.getParameter( "status" );
    String checkRemark = request.getParameter( "checkRemark" ) == null ? "" : request.getParameter( "checkRemark" );
    String totalCheckNum = request.getParameter( "totalCheckNum" ) == null ? "" : request.getParameter( "totalCheckNum" );
    String finishedCheckNum = request.getParameter( "finishedCheckNum" ) == null ? "" : request.getParameter( "finishedCheckNum" );
    String dangerNum = request.getParameter( "dangerNum" ) == null ? "" : request.getParameter( "dangerNum" );
    String handleDangerNum = request.getParameter( "handleDangerNum" ) == null ? "" : request.getParameter( "handleDangerNum" );
    String createTime = request.getParameter( "createTime" ) == null ? "" : request.getParameter( "createTime" );
    String createUser = request.getParameter( "createUser" ) == null ? "" : request.getParameter( "createUser" );
    String updateTime = request.getParameter( "updateTime" ) == null ? "" : request.getParameter( "updateTime" );
    String updateUser = request.getParameter( "updateUser" ) == null ? "" : request.getParameter( "updateUser" );
    String filePath = request.getParameter( "filePath" ) == null ? "" : request.getParameter( "filePath" );

    //任务开始时间
    String startDate = request.getParameter( "startDate" ) == null ? "" : request.getParameter( "startDate" );
    //结束时间
    String endDate = request.getParameter( "endDate" ) == null ? "" : request.getParameter( "endDate" );

    String startTime = request.getParameter( "startTime" ) == null ? "" : request.getParameter( "startTime" );
    String endTime = request.getParameter( "endTime" ) == null ? "" : request.getParameter( "endTime" );
    //检查频率
    String infoHandleType = request.getParameter( "infoHandleType" ) == null ? "" : request.getParameter( "infoHandleType" );
    String action = request.getParameter( "txtAction" ) == null ? "query" : request.getParameter( "txtAction" );
%>
