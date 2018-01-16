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
    <title>任务统计</title>
    <link rel="stylesheet" type="text/css" href="/css/page.css">
    <script src="/js/common.js"></script>
</head>
<body>

<form method="post" action="taskStatistics.jsp" name="this_form" style="padding:0; margin:0;">

    <!--2 queryTable -->
    <div class="tablediv">
        <table class="queryTableStyle">
            <tr>
                <td colspan="6" class="queryTableSubTitle">快速查询</td>
            </tr>
            <tr>
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
                <td>任务类型：</td>
                <td><select name="checkType">
                    <option value="0">日常安检</option>
                    <option value="1">每日自检</option>
                    <option value="2">第三方检查</option>
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
    <!-- 数字 -->
    <div class="tablediv">
        <table class="queryTableStyle">
            <tr>
                <td>下发单位</td>
                <td>单位任务数</td>
                <td>认领数</td>
                <td>认领率</td>
            </tr>
            <tr>
                <td>1</td>
                <td>2</td>
                <td>3</td>
                <td>4</td>
            </tr>
        </table>
    </div>

    <!-- 柱形图 -->
    <div class="tablediv">
        <table class="queryTableStyle">
            <tr>
                <td>
                    <div>
                        柱形图1
                    </div>
                </td>
                <td>
                    <div>
                        柱形图2
                    </div>
                </td>
            </tr>

        </table>
    </div>

    <div class="tablediv">
        <table class="queryTableResultStyle">
            <!-- 表头-->
            <tr class="queryTableResultTitleStyle">

                <td width="10%"><span>组织</span>
                </td>
                <td width="10%"><span>下发单位</span></td>
                <td width="10%"><span>任务数</span></td>
                <td width="10%"><span>单位任务数 </span>
                </td>
                <td width="10%"><span>认领数</span>
                </td>
                <td width="10%"><span>认领率</span></td>
            </tr>
            <%
                //生成表格
                while (record.next()) {
            %>
            <tr>

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