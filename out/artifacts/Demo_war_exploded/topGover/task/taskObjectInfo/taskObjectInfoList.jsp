<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="com.rad.db.Record" %>
<%@ include file="/configQueryPage.jsp" %>
<%@ include file="/import.jsp" %>
<%@ include file="/topGover/task/sqlConstant/taskObjectInfoSql.jsp" %>
<!-- 引入变量-->
<%@include file="/topGover/task/po/taskObjectInfoVariable.jsp" %>
<%
    /**
     * 读取已发布待认领任务列表
     */

    Record record = new Record();
    SqlManager sqlManager = new SqlManager();
    Vector vPara = new Vector();
    String orderByKey = request.getParameter("orderByKey") == null ? "release_time asc"
            : request.getParameter("orderByKey");
    String orderByKeyPara = request.getParameter("orderByKeyPara") == null ? "release_time"
            : request.getParameter("orderByKeyPara");
    String querySqlStr = "";
    if (action.equalsIgnoreCase("query")) {
        vPara = new Vector();

        querySqlStr = OBJECTINFO_AND_TASKINFO_JOIN_QUERY
                + " AND t.COMPANY_CODE = ? AND T.STATUS = ? AND t2.INFO_STATUS = ? AND t2.CHECK_TYPE != ?";
        vPara.add("1");
        vPara.add(status);
        vPara.add("1");
        vPara.add("2");
        //任务名搜索
        if (!"".equals(taskName)) {
            querySqlStr += "instr(t2.TASK_NAME,?)>0";
            vPara.add(taskName);
        }
        //时间范围
        if (!"".equals(startDate)) {
            querySqlStr += " and t2.START_DATE >= ? ";
            vPara.add(startDate);
        }
        if (!"".equals(endDate)) {
            querySqlStr += " and t2.END_DATE <= ? ";
            vPara.add(endDate);
        }
        //频率
        if (!"".equals(infoHandleType)) {
            querySqlStr += " and t2.INFO_HANDLE_TYPE = ? ";
            vPara.add(infoHandleType);
        }

        querySqlStr += " order by " + orderByKey;
        record = sqlManager.getRecords(querySqlStr, vPara, pageQuery);
        request.getSession().setAttribute("expExcel_sql", querySqlStr);
        request.getSession().setAttribute("expExcel_para", vPara);
    }


%>


<html>
<head>
    <title>待认领列表</title>

    <link rel="stylesheet" type="text/css" href="/css/page.css">
    <script src="/js/common.js"></script>
</head>
<body>

<form method="post" action="taskObjectInfoList.jsp" name="this_form" style="padding:0; margin:0;">

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
                <td><select name="status"
                            onchange="this_form.txtCurPage.value=1;this_form.submit();">
                    <option value="0">待认领</option>
                    <option value="1">处理中</option>
                    <option value="2">退回</option>
                    <option value="3">已完成</option>
                    <option value="4">已过期</option>
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

    <div class="tablediv">
        <table class="queryTableResultStyle">
            <!-- 表头-->
            <tr class="queryTableResultTitleStyle">
                <td width="1%"><input type="checkbox" name="checkAll"
                                      onclick="selectAll(this,'ckIdx')"></td>
                <td width="10%" onclick="sortByKey('task_name')"><span id="task_name">任务名称</span>
                </td>
                <td width="10%" onclick="sortByKey('company_name')"><span
                        id="company_name">下发单位</span></td>
                <td width="10%" onclick="sortByKey('start_date')"><span id="start_date">开始时间</span>
                </td>
                <td width="10%" onclick="sortByKey('end_date')"><span id="end_date">结束时间 </span>
                </td>
                <td width="10%" onclick="sortByKey('release_persion')"><span id="release_persion">发布人</span>
                </td>
                <td width="10%" onclick="sortByKey('release_time')"><span
                        id="release_time">发布时间</span></td>
                <td width="10%" onclick="sortByKey('info_handle_type')"><span id="info_handle_type">检查频率 </span>
                </td>
                <td width="5%" onclick="sortByKey('status')"><span id="status">状态</span></td>

                <td>操作</td>
            </tr>
            <%
                //生成表格
                while (record.next()) {
            %>
            <tr>
                <td><input type="checkbox" name="ckIdx" value="<%=record.getString("userId")%>">
                </td>
                <td><%=record.getString("task_name")%>&nbsp;
                </td>
                <td><%=record.getString("company_name")%>&nbsp;
                </td>
                <td><%=record.getString("start_date")%>&nbsp;
                </td>
                <td><%=record.getString("end_date")%>&nbsp;
                </td>
                <td><%=record.getString("release_persion")%>&nbsp;
                </td>
                <td><%=record.getString("release_time")%>&nbsp;
                </td>
                <%
                    switch (record.getString("info_handle_type")) {
                        case "0": %>
                <td>单次&nbsp;</td>
                <%
                        break;
                    case "1": %>
                <td>每天&nbsp;</td>
                <%
                        break;
                    case "2": %>
                <td>每周&nbsp;</td>
                <%
                        break;
                    case "3": %>
                <td>每月&nbsp;</td>
                <%
                        break;
                    case "4": %>
                <td>每年&nbsp;</td>
                <%
                        break;
                    default: %>
                <td>单次&nbsp;</td>
                <%
                            break;
                    }
                %>
                <%
                    switch (record.getString("status")) {
                        case "0": %>
                <td>待认领&nbsp;</td>
                <%
                        break;
                    case "1": %>
                <td>已认领处理中&nbsp;</td>
                <%
                        break;
                    case "2": %>
                <td>退回&nbsp;</td>
                <%
                        break;
                    case "3": %>
                <td>已完成&nbsp;</td>
                <%
                        break;
                    case "4": %>
                <td>已过期&nbsp;</td>
                <%
                        break;
                    default: %>
                <td>待认领&nbsp;</td>
                <%
                            break;
                    }
                %>


                <td><%
                    switch (record.getString("status")) {
                        case "0": %>
                    <a href="/topGover/task/taskObjectInfo/details/claimTheTaskDetail.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">去认领</a>
                    <%
                            break;
                        case "1": %>
                    <a href="/topGover/task/taskObjectInfo/details/claimTheTaskDetail.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">去办理</a>

                    <%
                            break;
                        case "2": %>
                    <a href="/topGover/task/taskObjectInfo/details/claimTheTaskDetail.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">去认领</a>

                    <%
                            break;
                        case "3": %>
                    <a href="/topGover/task/taskObjectInfo/details/claimTheTaskDetail.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">去认领</a>

                    <%
                            break;
                        case "4": %>
                    <a href="/topGover/task/taskObjectInfo/details/claimTheTaskDetail.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">去认领</a>

                    <%
                            break;
                        default: %>
                    <a href="/topGover/task/taskObjectInfo/details/claimTheTaskDetail.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">去认领</a>
                    <%
                                break;
                        }
                    %>


                </td>
            </tr>
            <%}%>
        </table>
    </div>
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
</body>

</body>
</html>
<script>

  setOrderByImg("<%=orderByKeyPara.trim()%>", "<%=orderByKey.trim()%>", "<%=webRoot%>");
</script>