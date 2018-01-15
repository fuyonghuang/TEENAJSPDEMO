<%--
  Created by IntelliJ IDEA.
  Date: 2018/1/4
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/import.jsp" %>
<%@ include file="/topGover/task/po/taskInfoVariable.jsp" %>
<%@ include file="/configQueryPage.jsp" %>
<%@ include file="/topGover/task/sqlConstant/taskInfoSql.jsp" %>
<%@ taglib prefix="mx" tagdir="/WEB-INF/tags/task/taskInfo" %>
<%
    Record record = new Record();
    Record subTaskRecord = new Record();
    SqlManager sqlManager = new SqlManager();
    Vector vPara = new Vector();
    String querySqlStr = "";
    //分页必须要有 orderByKey orderByKeyPara，
    String orderByKey = request.getParameter("orderByKey") == null ? "release_time asc"
            : request.getParameter("orderByKey");
    String orderByKeyPara = request.getParameter("orderByKeyPara") == null ? "release_time"
            : request.getParameter("orderByKeyPara");

    if (!action.equals("insert")) {
        //获取task_info详情
        record = CommonDaoAction.getInfoByKeyValue("t_task_info", "task_id", taskId);
        record.next();
        vPara = new Vector();
        //获取（检查单位）task_object_info列表。
        querySqlStr = QUERY_TASKINFO + " and t.parent_id = ? ";
        vPara.add(taskId);
        subTaskRecord = sqlManager.getRecords(querySqlStr, vPara, pageQuery);
        request.getSession().setAttribute("expExcel_sql", querySqlStr);
        request.getSession().setAttribute("expExcel_para", vPara);
    }
%>
<html>
<head>
    <title>已发布</title>
    <%-- <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>--%>
    <script src="https://unpkg.com/sweetalert2@7.3.2/dist/sweetalert2.all.js"></script>

    <!-- Include a polyfill for ES6 Promises (optional) for IE11, UC Browser and Android browser support -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>
</head>
<body>
<!-- 任务统计信息 --开始---->
<div class="tablediv">
    <table class="queryTableStyle">

        <tr>
            <td>任务名称：</td>
            <td>
                <span><%=record.getString("task_name")%></span>
            </td>
            <td>下发单位：</td>
            <td>
                <span><%=record.getString("company_code")%></span></td>
        </tr>
        <tr>
            <td>隐患数：</td>
            <td><span><%= record.getString("danger_num")%></span></td>
            <td>执行情况：</td>
            <td><span><%= record.getString("finished_num")%>/<%=record
                    .getString("total_object_num")%></span></td>
            <td>认领情况：</td>
            <td></td>
            <td>任务状态：</td>
            <td></td>
        </tr>

    </table>
</div>
<!-- 任务统计信息 --结束---->
<!-- 被检查单位列表 --开始-- -->

<form method="post"
      action="/topGover/task/taskInfo/detail/releasedTaskDetails.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>"
      name="this_form" style="padding:0; margin:0;">
    <!--2 queryTable -->
    <div class="tablediv">
        <table class="queryTableStyle">
            <tr>
                <td colspan="6" class="queryTableSubTitle">快速查询</td>
            </tr>
            <tr>
                <td>任务名称：</td>
                <td><input type="text" name="taskName" value="<%=taskName%>"></td>
                <td>下发单位：</td>
                <td><input type="text" name="companyCode" value="<%=companyCode%>"></td>
            </tr>
            <tr>
                <td>任务时间：</td>
                <td><input type="date" name="startDate" value="<%=startDate%>"> ~ <input type="date"
                                                                                         name="endDate"
                                                                                         value="<%=endDate%>">
                </td>
                <td>检查频率：</td>
                <td><select name="infoHandleType">
                    <option value="0">单次</option>
                    <option value="1">每日</option>
                    <option value="2">每周</option>
                    <option value="3">每月</option>
                    <option value="4">每年</option>
                </select></td>
                <td>状态：</td>
                <td><select name="infoStatus"
                            onchange="this_form.txtCurPage.value=1;this_form.submit();">
                    <option value="0">待审核</option>
                    <option value="1">通过审核</option>
                    <option value="2">审核拒绝</option>
                    <option value="3">已发布</option>
                    <option value="4">已完成</option>

                </select></td>
            </tr>
            <tr>
                <td colspan="6" style="text-align: center;">
                    <input type="button" class="button"
                           onClick="this_form.txtCurPage.value=1;this_form.submit();"
                           value="查询">
                    <input type="reset" class="button" onClick="resetEmpty()" value="重置">
                    <%--  <input type="button" class="button" onClick="doOutput('<%=viewPage%>','query')" value="导出">--%>
                </td>
            </tr>
        </table>
    </div>
    <mx:taskInfoTable record="<%=subTaskRecord%>" infoStatus="<%=infoStatus %>"></mx:taskInfoTable>
    <!--  分页显示-->
    <table class="queryTableStyle" style="width:100%">
        <tr bgcolor="">
            <td class="showPage" height="30" colspan="15" align="right" style="padding-right:15px;">
                <%@ include file="/page.jsp" %>
            </td>
        </tr>
    </table>
    <!--  分页显示结束-->
    <%@ include file="/common_query_hidden.jsp" %>
</form>

<!-- 被检查单位列表 --结束-- -->
</body>


</html>
<script>
  setOrderByImg("<%=orderByKeyPara.trim()%>", "<%=orderByKey.trim()%>", "<%=webRoot%>");
</script>