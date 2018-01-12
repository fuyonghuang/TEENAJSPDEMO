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
<%

    Record record = new Record();
    Record taskObjectInfoRecord = new Record();
    SqlManager sqlManager = new SqlManager();
    Vector vPara = new Vector();
    String querySqlStr = "";
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
        querySqlStr = "SELECT t.* FROM T_TASK_OBJECT_INFO t where  t.task_id = ? ";
        vPara.add(taskId);
        taskObjectInfoRecord = sqlManager.getRecords(querySqlStr, vPara, pageQuery);
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
<form method="post"
      action="/topGover/task/taskInfo/detail/releasedTaskDetails.jspils.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>"
      name="this_form" style="padding:0; margin:0;">
    <div class="tablediv">
        <table class="queryTableResultStyle">
            <tr class="queryTableResultTitleStyle">

                <td width="10%">被检查到单位<span id="task_name"></td>

                <td width="10%">开始时间 <span id="start_date"></td>
                <td width="10%">结束时间 <span id="end_date"></td>
                <td width="10%"> 检查频率<span id="release_persion"></td>
                <td width="10%">检查情况 <span id="release_time"></td>
                <td width="10%">隐患数 <span id="info_handle_type"></td>
                <td width="5%">最近检查时间 <span
                        id="check_company_confirm_num"></td>
                <td width="5%">任务状态 <span
                        id="check_company_finished_num"></td>
                <td width="5%">认领人 <span id="danger_num1"></td>
                <td width="5%">认领时间 <span id="danger_num2"></td>
                <td>操作</td>
            </tr>
            <%
                //生成表格
                while (taskObjectInfoRecord.next()) {
            %>

            <tr>
                <td><input type="checkbox" name="ckIdx"
                           value="<%=taskObjectInfoRecord.getString("company_name")%>"></td>
                <td><%=taskObjectInfoRecord.getString("company_name")%>&nbsp;</td>
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
                <td><%=taskObjectInfoRecord.getString("status")%>&nbsp;</td>
                <td><%=taskObjectInfoRecord.getString("confirm_user_name")%>&nbsp;</td>
                <td><%=taskObjectInfoRecord.getString("confirm_time")%>&nbsp;</td>
                <td>
                    <a href="userInfo.jsp?txtAction=update&userId=<%=taskObjectInfoRecord.getString("task_objct_id")%>">详情</a>
                    <a href="#" onclick="overseeing()">删除</a>
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
<script>

  function overseeing() {
    confirm("确认删除？")
  }
</script>

</html>