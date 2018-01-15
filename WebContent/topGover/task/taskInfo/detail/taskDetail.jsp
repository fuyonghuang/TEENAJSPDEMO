<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/import.jsp" %>
<%@ include file="/topGover/task/po/taskObjectInfoVariable.jsp" %>
<%@ include file="/configQueryPage.jsp" %>
<%@ include file="/topGover/task/sqlConstant/taskObjectInfoSql.jsp" %>
<%@ taglib prefix="formTag" tagdir="/WEB-INF/tags/task/formInfo" %>
<%
    Record record = new Record();
    SqlManager sqlManager = new SqlManager();
    Vector vPara = new Vector();
    String querySqlStr = "";
    Record taskFormrecord = new Record();
    String queryTaskFormSqlStr = "";
    if (!action.equals("insert")) {

        vPara = new Vector();
        //获取（检查单位）task_object_info列表。
        querySqlStr = OBJECTINFO_AND_TASKINFO_JOIN_QUERY + " and t.task_objct_id = ? ";
        vPara.add(taskObjectId);
        record = sqlManager.getRecords(querySqlStr, vPara);
        record.next();
        vPara = new Vector();
        queryTaskFormSqlStr = "select t.*,s.form_name from t_task_form t left join S_FORM_INFO s on  t.form_id = s.form_id where t.task_id = ? ";
        vPara.add(record.getString("task_id"));
        taskFormrecord = sqlManager.getRecords(queryTaskFormSqlStr, vPara);

    }
%>

<html>
<head>
    <title>具体任务详情</title>
    <style>
        h2 {
            border-top: solid cornflowerblue 1px;
            border-left: solid cornflowerblue 1px;
            width: 50px;
            height: 25px;
            margin: 0;
            float: left;
            text-align: center;
        }

        .tab-content {
            border: solid cornflowerblue 1px;
            width: 100%;
            height: 100%;
        }

        .tab-content div {
            display: none;
        }

        .selected {
            background-color: cornflowerblue;
        }

        .tab-content .show {
            display: block;
        }
    </style>
</head>
<body>
<!-- 任务统计信息 --开始---->
<div class="tablediv">
    <table class="queryTableStyle">

        <tr>
            <td>任务名称：</td>
            <td>
                <span><%=record.getString("TASK_NAME")%></span>
            </td>
            <td>下发单位：</td>
            <td>
                <span><%=record.getString("company_code")%></span></td>
        </tr>
        <tr>
            <td>下发人：</td>
            <td><span><%= record.getString("RELEASE_PERSION")%></span></td>
            <td>下发时间：</td>
            <td><span><%= record.getString("RELEASE_TIME")%></span></td>
        </tr>
        <tr>
            <td>开始时间：</td>
            <td><span><%= record.getString("START_DATE")%> <%= record
                    .getString("START_TIME")%></span></td>
            <td>结束时间：</td>
            <td><span><%= record.getString("END_DATE")%> <%= record.getString("END_TIME")%></span>
            </td>
        </tr>
        <tr>
            <td>任务来源：</td>
            <td><span><%= record.getString("TASK_FROM")%></span></td>
            <td>处理方式：</td>
            <%
                switch (record.getString("INFO_HANDLE_TYPE")) {
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

    </table>
</div>


<div <%--class="tab-content"--%>>
    <%
        while (taskFormrecord.next()) {
            com.rad.db.Record record2 = new Record();
            SqlManager sqlManager2 = new SqlManager();
            java.util.Vector vPara2 = new Vector();
            String strSql = "";
            vPara2 = new Vector();
            strSql = "select a.* from s_check_content a  where  1=1 and a.FORM_ID = ? ";
            vPara2.add(taskFormrecord.getString("form_id"));
            record2 = sqlManager2.getRecords(strSql, vPara2);
    %>
    <formTag:formInfo checkContentRecord="<%=record2%>"></formTag:formInfo>

    <%
        }
    %>
</div>

<script>
  var tabs = document.getElementsByClassName('tab-head')[0].getElementsByTagName('h2'),
      contents = document.getElementsByClassName('tab-content')[0].getElementsByTagName('div');
  (function changeTab(tab) {
    for (var i = 0, len = tabs.length; i < len; i++) {
      tabs[i].onmouseover = showTab;
    }
  })();

  function showTab() {
    for (var i = 0, len = tabs.length; i < len; i++) {
      if (tabs[i] === this) {
        tabs[i].className = 'selected';
        contents[i].className = 'show';
      } else {
        tabs[i].className = '';
        contents[i].className = '';
      }
    }
  }
</script>

</body>
</html>
