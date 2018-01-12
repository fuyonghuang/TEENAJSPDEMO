<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="record" type="com.rad.db.Record" required="true" description="数据库bean" %>
<%@ attribute name="infoStatus" type="java.lang.String" required="false" description="任务状态" %>
<%@ attribute name="taskObjectInfoRecord" type="com.rad.db.Record" required="true"
              description="taskObjectInfoRecord" %>
<!-- taskInfoTable -->
<div class="tablediv">
    <table class="queryTableResultStyle">
        <tr class="queryTableResultTitleStyle">
            <td width="10%"><span id="task_name">被检查到单位</span></td>
            <td width="10%"><span id="start_date">开始时间 </span></td>
            <td width="10%"><span id="end_date">结束时间 </span></td>
            <td width="10%"><span id="release_persion">检查频率</span></td>
        </tr>
        <%--  <%@include file="/topGover/task/taskObjectInfo/taskObjectInfoSave.jsp"%>--%>
        <%
            //生成表格
            while (taskObjectInfoRecord.next()) {
        %>
        <tr>
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
        </tr>
        <%}%>
    </table>
</div>
