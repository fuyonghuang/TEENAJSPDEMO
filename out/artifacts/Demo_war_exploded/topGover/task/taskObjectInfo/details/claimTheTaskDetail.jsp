<%--
  Created by IntelliJ IDEA.
  Date: 2018/1/4
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/import.jsp" %>
<%@ include file="/configQueryPage.jsp" %>
<%@ include file="/topGover/task/po/taskInfoVariable.jsp" %>
<%
    //任务对象id
    String taskObjectId = request.getParameter("taskObjectId") == null ? ""
            : request.getParameter("taskObjectId");
    Record record = new Record();
    Record formRecord = new Record();
    SqlManager sqlManager = new SqlManager();
    Vector vPara = new Vector();
    String queryFormSqlStr = "";
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
        //获取任务关联表单信息
        queryFormSqlStr = "select s.* from s_form_info s left join T_TASK_FORM t ON s.form_id = t.form_id where t.task_id = ?";
        vPara.add(taskId);
        formRecord = sqlManager.getRecords(queryFormSqlStr, vPara, pageQuery);
        request.getSession().setAttribute("expExcel_sql", queryFormSqlStr);
        request.getSession().setAttribute("expExcel_para", vPara);
    }
%>
<html>
<head>
    <title>待认领</title>
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
                <span><%=record.getString("company_name")%></span></td>
        </tr>
        <tr>
            <td>发布人：</td>
            <td><span><%= record.getString("release_persion")%></span></td>
            <td>发布时间：</td>
            <td><span><%= record.getString("release_time")%></span></td>
        </tr>
        <tr>
            <td>开始时间：</td>
            <td><span><%= record.getString("start_date")%> <%= record
                    .getString("start_time")%></span></td>
            <td>结束时间：</td>
            <td><span><%= record.getString("end_date")%> <%= record.getString("end_time")%></span>
            </td>
        </tr>
        <tr>
            <td>任务来源：</td>
            <td><%= record.getString("task_from")%>
            </td>
            <td>检查频率：</td>
            <td><%= record.getString("info_handle_type")%>
            </td>
        </tr>
        <%-- <tr>
             <td>备注：</td>
             <td></td>
         </tr>--%>
        <tr>
            <td>附件：</td>
            <td></td>
        </tr>
    </table>
</div>
<!-- 任务统计信息 --结束---->
<!-- 被检查单位列表 --开始-- -->

<form method="post"
      action="/topGover/task/taskObjectInfo/taskObjectInfoSave.jsp?txtAction=claimAction&taskId=<%=record.getString("task_id")%>"
      name="this_form" style="padding:0; margin:0;">
    <div class="tablediv">

        <table class="queryTableResultStyle">
            <tr class="queryTableResultTitleStyle">

                <td width="10%"><span id="task_name">表单名称</span></td>

                <td width="10%"><span id="start_date">表单类型</span></td>
                <td width="10%"><span id="end_date">所属单位</span></td>
                <td>操作</td>
            </tr>
            <%
                //生成表格
                while (formRecord.next()) {
            %>

            <tr>
                <td><%=formRecord.getString("form_name")%>&nbsp;</td>

                <td><%=formRecord.getString("form_type")%>&nbsp;</td>
                <td><%=formRecord.getString("open_status")%>&nbsp;</td>
                <td>
                    <a href="userInfo.jsp?txtAction=query&form_id=<%=formRecord.getString("form_id")%>">预览</a>
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


    <div class="tablediv">
        <table>
            <tr>
                <button type="submit" value="认领"> 认领</button>
            </tr>
            <tr>
                <button type="button" value="认领">返回</button>
            </tr>
        </table>
    </div>
</form>

<!-- 被检查单位列表 --结束-- -->
</body>
<script>

  function overseeing() {
    confirm("发送通知？")

  }
</script>

</html>