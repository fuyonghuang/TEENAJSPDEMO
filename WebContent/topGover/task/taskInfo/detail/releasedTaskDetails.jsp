<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/import.jsp" %>
<%@ include file="/topGover/task/po/taskInfoVariable.jsp" %>
<%@ include file="/configQueryPage.jsp" %>
<%@ include file="/topGover/task/sqlConstant/taskObjectInfoSql.jsp" %>
<%
    Record record = new Record();
    Record taskObjectInfoRecord = new Record();
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
        querySqlStr = QUERY_TASKOBJECTINFO + " and t.task_id = ? ";
        vPara.add(taskId);
        taskObjectInfoRecord = sqlManager.getRecords(querySqlStr, vPara, pageQuery);
        request.getSession().setAttribute("expExcel_sql", querySqlStr);
        request.getSession().setAttribute("expExcel_para", vPara);
    }
%>
<html>
<head>
    <title>已发布详情</title>
    <link rel="stylesheet" type="text/css" href="/css/page.css">
    <script src="/js/common.js"></script>
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
    <div class="tablediv">
        <table class="queryTableResultStyle">
            <tr class="queryTableResultTitleStyle">

                <td width="10%"><span id="task_name">被检查到单位</span></td>

                <td width="10%"><span id="start_date">开始时间</span></td>
                <td width="10%"><span id="end_date">结束时间</span></td>
                <td width="10%"><span id="release_persion">检查频率</span></td>
                <td width="10%"><span id="release_time">检查情况</span></td>
                <td width="10%"><span id="info_handle_type">隐患数</span></td>
                <td width="5%"> <span
                        id="check_company_confirm_num">最近检查时间</span></td>
                <td width="5%"> <span
                        id="check_company_finished_num">任务状态</span></td>
                <td width="5%"><span id="danger_num1">认领人</span></td>
                <td width="5%"><span id="danger_num2">认领时间 </span></td>
                <td>操作</td>
            </tr>
            <%
                //生成表格
                while (taskObjectInfoRecord.next()) {
            %>

            <tr>
                <td><%=taskObjectInfoRecord.getString("company_name") == null ? taskObjectInfoRecord
                        .getString("user_id") : taskObjectInfoRecord.getString("company_name")%>&nbsp;
                </td>
                <td><%=record.getString("start_date")%>&nbsp;</td>
                <td><%=record.getString("end_date")%>&nbsp;</td>
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

                <td><%=taskObjectInfoRecord.getString("total_check_num")%>&nbsp;</td>
                <td><%=taskObjectInfoRecord.getString("danger_num")%>&nbsp;</td>
                <td><%=taskObjectInfoRecord.getString("handle_time")%>&nbsp;</td>
                <%
                    switch (taskObjectInfoRecord.getString("status")) {
                        case "0": %>
                <td>待审核&nbsp;</td>
                <%
                        break;
                    case "1": %>
                <td>通过审核&nbsp;</td>
                <%
                        break;
                    case "2": %>
                <td>审核拒绝&nbsp;</td>
                <%
                        break;
                    case "3": %>
                <td>已发布&nbsp;</td>
                <%
                        break;
                    case "4": %>
                <td>已完成&nbsp;</td>
                <%
                        break;
                    default: %>
                <td>待审核&nbsp;</td>
                <%
                            break;
                    }
                %>
                <td><%=taskObjectInfoRecord.getString("confirm_user_name")%>&nbsp;</td>
                <td><%=taskObjectInfoRecord.getString("confirm_time")%>&nbsp;</td>
                <td>
                    <a href="taskDetail.jsp?txtAction=update&userId=<%=taskObjectInfoRecord.getString("task_objct_id")%>">详情</a>
                    <a href="#" onclick="overseeing()">督办</a>
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

<!-- 被检查单位列表 --结束-- -->
</body>
<script>

  function overseeing() {
    confirm("发送通知？")
  }
</script>

</html>