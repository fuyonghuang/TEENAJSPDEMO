<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/import.jsp" %>
<%@ include file="/topGover/task/po/taskInfoVariable.jsp" %>
<%@ include file="/configQueryPage.jsp" %>
<%@ taglib prefix="mxt" tagdir="/WEB-INF/tags/task/taskObjectInfo" %>
<%
    if ("".equals(taskId)) {
        out.println(
                "<script>alert(\"记录不存在,错误代码:" + 300001 + "\");window.history.back(); </script>");
        return;
    }
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
        infoStatus = record.getString("info_status");
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
    <title>待审核</title>
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
                <span><%=record.getString("company_name")%></span></td>
        </tr>
        <tr>
            <td>下发人：</td>
            <td><span><%= record.getString("danger_num")%></span></td>
            <td>处理方式：</td>
            <td><span><%= record.getString("finished_num")%>/<%=record
                    .getString("total_object_num")%></span></td>
        </tr>
        <tr>
            <td>开始时间：</td>
            <td><%= record.getString("start_date")%>
            </td>
            <td>截至时间：</td>
            <td><%= record.getString("end_date")%>
            </td>
        </tr>
        <tr>
            <td>任务来源：</td>
            <td><%= record.getString("task_from")%>
            </td>
            <td>任务类型：</td>
            <td><%= record.getString("task_type")%>
            </td>
        </tr>
        <tr>
            <td>表单：</td>
            <td></td>
        </tr>
        <tr>
            <td>附件：</td>
            <td><%= record.getString("task_type")%>
            </td>

        </tr>

    </table>
</div>
<!--被检查任务列表 -->
<form method="post"
      action="/topGover/task/taskInfo/detail/releasedTaskDetails.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>"
      name="this_form" style="padding:0; margin:0;">
    <mxt:taskObjectInfoTable record="<%=record%>" infoStatus="<%=infoStatus%>"
                             taskObjectInfoRecord="<%=taskObjectInfoRecord%>"></mxt:taskObjectInfoTable>
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
<form name="approvalForm"
      action="/topGover/task/taskInfo/taskInfoSave.jsp?txtAction=audit&taskId=<%=record.getString("task_id")%>"
      method="post">
    <div>

        <input type="hidden" name="infoStatus" id="infoStatus">
        <table>
            <tr>
                <td>审核意见</td>
                <td><textarea name="checkDesc" id="checkDesc" cols="30" rows="10"></textarea></td>
            </tr>
            <tr>
                <td>
                    <button type="button" name="adopt" id="adopt" onclick="Approval(0)">通过</button>
                </td>
                <td>
                    <button type="button" name="refuse" id="refuse" onclick="Approval(1)">拒绝
                    </button>
                </td>
                <td>
                    <button type="button" onclick="javaScript:history.back();">返回</button>
                </td>
            </tr>
        </table>


    </div>
</form>
</body>
<script>

  function overseeing() {
    confirm("发送通知？")
  }

  //提交审核。
  function Approval(v) {
    if (v == 0) {
      document.getElementById("infoStatus").value = 1;
    } else if (v == 1) {
      document.getElementById("infoStatus").value = 2;
    }
    document.approvalForm.submit();
  }

</script>

</html>