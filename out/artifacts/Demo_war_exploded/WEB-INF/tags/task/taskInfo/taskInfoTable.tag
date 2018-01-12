<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="record" type="com.rad.db.Record" required="true" description="数据库bean" %>
<%@ attribute name="infoStatus" type="java.lang.String" required="true" description="任务状态" %>

<!-- taskInfoTable -->
<div class="tablediv">
    <table class="queryTableResultStyle">


        <tr class="queryTableResultTitleStyle">
            <td width="1%"><input type="checkbox" name="checkAll"
                                  onclick="selectAll(this,'ckIdx')"></td>
            <td width="10%" onclick="sortByKey('task_name')"><span id="task_name">任务名称</span>
            </td>
            <td width="10%" onclick="sortByKey('company_name')"><span
                    id="company_name">下发单位</span>
            </td>
            <td width="10%" onclick="sortByKey('start_date')"><span id="start_date">开始时间</span>
            </td>
            <td width="10%" onclick="sortByKey('end_date')"><span id="end_date">结束时间</span></td>
            <td width="10%" onclick="sortByKey('release_persion')"> <span
                    id="release_persion">发布人</span></td>
            <td width="10%" onclick="sortByKey('release_time')"><span
                    id="release_time">发布时间</span>
            </td>
            <td width="10%" onclick="sortByKey('info_handle_type')"> <span
                    id="info_handle_type">检查频率</span></td>
            <%
                System.out.println(record.getString("info_status"));
                if ("0".equals(infoStatus)) {
                    //待审核
                } else if ("1".equals(infoStatus)) {
            %>
            <td width="5%" onclick="sortByKey('check_company_confirm_num')"> <span
                    id="check_company_confirm_num">认领情况</span></td>
            <td width="5%" onclick="sortByKey('check_company_finished_num')"> <span
                    id="check_company_finished_num">执行情况</span></td>
            <td width="5%" onclick="sortByKey('danger_num')"><span id="danger_num">隐患数</span>
            </td>
            <%
            } else if ("2".equals(infoStatus)) {
                //审核拒绝
            } else if ("3".equals(infoStatus)) {
                //已发布
            %>
            <td width="5%" onclick="sortByKey('check_company_confirm_num')"> <span
                    id="check_company_confirm_num">认领情况</span></td>
            <td width="5%" onclick="sortByKey('check_company_finished_num')"> <span
                    id="check_company_finished_num">执行情况</span></td>
            <td width="5%" onclick="sortByKey('danger_num')"><span id="danger_num">隐患数</span>
            </td>
            <%
            } else if ("4".equals(infoStatus)) {
                //已完成
            %>
            <td width="5%" onclick="sortByKey('check_company_confirm_num')"> <span
                    id="check_company_confirm_num">认领情况</span></td>
            <td width="5%" onclick="sortByKey('check_company_finished_num')"> <span
                    id="check_company_finished_num">执行情况</span></td>
            <td width="5%" onclick="sortByKey('danger_num')"><span id="danger_num">隐患数</span>
            </td>
            <%

                } else {
                    System.out.println(infoStatus);
                }%>


            <td width="5%" onclick="sortByKey('info_status')"><span id="info_status">状态</span>
            </td>
            <% if (!"9".equals(infoStatus)) {%>
            <td>操作</td>
            <%}%>

        </tr>
        <%
            //生成表格
            while (record.next()) {
        %>
        <tr>
            <td><input type="checkbox" name="ckIdx" value="<%=record.getString("userId")%>">
            </td>
            <td title="<%=record.getString("task_name")%>"><%=record
                    .getString("task_name")%>&nbsp;
            </td>
            <td><%=record.getString("company_name")%>&nbsp;</td>
            <td><%=record.getString("start_date")%>&nbsp;</td>
            <td><%=record.getString("end_date")%>&nbsp;</td>
            <td><%=record.getString("release_persion")%>&nbsp;</td>
            <td><%=record.getString("release_time")%>&nbsp;</td>
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

            <% if ("0".equals(infoStatus)) {
                //待审核
            } else if ("1".equals(infoStatus)) {
                //审核通过
            %>
            <td><%=record.getString("check_company_confirm_num")%>&nbsp;</td>
            <td><%=record.getString("check_company_finished_num")%>&nbsp;</td>
            <td><%=record.getString("danger_num")%>&nbsp;</td>
            <%
            } else if ("2".equals(infoStatus)) {
                //审核拒绝
            } else if ("3".equals(infoStatus)) {
                //已发布
            %>
            <td><%=record.getString("check_company_confirm_num")%>&nbsp;</td>
            <td><%=record.getString("check_company_finished_num")%>&nbsp;</td>
            <td><%=record.getString("danger_num")%>&nbsp;</td>
            <%
                } else if ("4".equals(infoStatus)) {
                    //已完成
                } else {

                }%>


            <%
                switch (infoStatus) {
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


            <%
                switch (infoStatus) {
                    case "0": %>
            <td>
                <a href="/topGover/task/taskInfo/detail/releasedTaskDetails.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">详情</a>
                &nbsp;
                <a href="/topGover/task/taskInfo/detail/toBeAuditedTaskDetails.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">去审核</a>
            </td>
            <%
                    break;
                case "1": %>
            <td>
                <a href="/topGover/task/taskInfo/detail/releasedTaskDetails.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">详情</a>
                &nbsp;
            </td>
            <%
                    break;
                case "2": %>
            <td>
                <a href="/topGover/task/taskInfo/detail/releasedTaskDetails.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">详情</a>
                &nbsp;
            </td>
            <%
                    break;
                case "3": %>
            <td>
                <a href="/topGover/task/taskInfo/detail/releasedTaskDetails.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">详情</a>
                &nbsp;
            </td>
            <%
                    break;
                case "4": %>
            <td>
                <a href="/topGover/task/taskInfo/detail/releasedTaskDetails.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">详情</a>
                &nbsp;
            </td>
            <%
                    break;
                default: %>

            <%--<a href="/topGover/task/taskInfo/detail/toBeAuditedTaskDetails.jsp?txtAction=detail&taskId=<%=record.getString("task_id")%>">去审核</a>
--%> &nbsp;

            <%
                        break;
                }
            %>

            </td>
        </tr>
        <%}%>
    </table>
</div>
