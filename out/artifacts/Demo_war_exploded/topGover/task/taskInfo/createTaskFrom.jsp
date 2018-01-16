<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/import.jsp" %>
<%@ taglib prefix="zt" tagdir="/WEB-INF/tags" %>


<%@ include file="/topGover/task/sqlConstant/taskInfoSql.jsp" %>
<%@ taglib prefix="zt" tagdir="/WEB-INF/tags" %>

<%

    String taskId = request.getParameter("taskId") == null ? "" : request.getParameter("taskId");
    String action = request.getParameter("textAction") == null ? "query"
            : request.getParameter("textAction");
    Record record = new Record();
    Record taskFormRecord = new Record();
    SqlManager sqlManager = new SqlManager();
    Vector vPara = new Vector();
    String querySqlStr = "";

    if (action.equals("edit")) {
        //获取task_info详情
        record = CommonDaoAction.getInfoByKeyValue("t_task_info", "task_id", taskId);
        record.next();
        vPara = new Vector();
        //获取（检查单位）task_object_info列表。
        taskFormRecord = CommonDaoAction.getInfoByKeyValue("t_task_form", "task_id", taskId);
        vPara.add(taskId);

        request.getSession().setAttribute("expExcel_sql", querySqlStr);
        request.getSession().setAttribute("expExcel_para", vPara);
    }
%>
<html>
<head>
    <title>Title</title>
    <script src="/js/jquery-2.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/artDialog/7.0.0/dialog-plus.js"></script>
    <link rel="stylesheet" href="/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="/js/ztree/jquery.ztree.core.js"></script>
</head>
<body>

<form action="/topGover/task/taskInfo/taskInfoSave.jsp?txtAction=save" method="post">
    <input type="hidden" value="<%=record.getString("task_id")%>" id="taskId" name="taskId">
    任务名称: <input type="text" name="taskName" value="<%=record.getString("task_name")%>"><br>
    开始时间:
    <input type="date" name="startDate" value="<%=record.getString("start_date")%>">
    <input type="time" name="startTime" value="<%=record.getString("start_time")%>"> ~
    截至时间: <input type="date" name="endDate" value="<%=record.getString("end_date")%>">
    <input type="time" name="endTime" value="<%=record.getString("end_time")%>"><br>
    任务类型：
    <select name="taskType">
        <option value="0">每日自检</option>
        <option value="1">日常安检</option>
    </select>
    <br/>

    处理方式：
    <select name="infoHandleType">
        <option value="0"
                <%if(record.getString("info_handle_type").equals("0")){%>selected="selected"<%
            }

        %>>单次
        </option>
        <option value="1"
                <%if(record.getString("info_handle_type").equals("1")){%>selected="selected"<%
            }

        %>>每日
        </option>
        <option value="2"
                <%if(record.getString("info_handle_type").equals("2")){%>selected="selected"<%
            }

        %>>每周
        </option>
        <option value="3"
                <%if(record.getString("info_handle_type").equals("3")){%>selected="selected"<%
            }

        %>>每月
        </option>
        <option value="4"
                <%if(record.getString("info_handle_type").equals("4")){%>selected="selected"<%
            }

        %>>每年
        </option>
    </select>
    <br>
    是否审核：

    <input type="radio" name="isApply" id="isFalse" value="0" onclick="hideApplyDiv()"> 否
    <input type="radio" value="1" name="isApply" id="isTrue" onclick="showApplyDiv()"> 是
    <br>
    <div id="applyDiv" style="display: none">
        审核人：<select id="applyPerson">
        <option value="张三">张三</option>
        <option value="李四">李四</option>
        <option value="王五">王五</option>
        <option value="赵六">赵六</option>
    </select>
    </div>
    <br>
    工作日限制：
    <input type="radio" name="onlyWorkDay" value="0"
           <%if(record.getString("only_work_day").equals("0")){%>checked<%} %>> 否
    <input type="radio" name="onlyWorkDay" value="1"
           <%if(record.getString("only_work_day").equals("1")){%>checked<%} %>> 是
    <br>
    工作日历：<input type="date" name="notHandleDay" value="<%=record.getString("not_handle_day")%>">
    <br/>
    表单选择：
    <button type="button" onclick="alertFromPage()" name="selectFrom">选择表单</button>
    <input type="hidden" name="formIds" id="formIds">
    <div id="formTable">
        <table class="">
            <tr class="queryTableResultTitleStyle">
                <td width="10%"><span id="task_name">表单名称</span>
                </td>
                <td width="10%"><span
                        id="company_name">表单类型</span>
                </td>
                <td width="10%"><span id="start_date">所属单位</span>
                </td>
                <td width="10%"><span id="end_date">操作</span></td>
            </tr>
            <tbody id="selectFormList">

            </tbody>
        </table>
    </div>
    <br/>
    任务检查方式：
    <select name="taskCategory"
            onchange="checkTaskCategory(this.options[this.options.selectedIndex].value)"
            id="taskCategory">
        <option value="0">自检</option>
        <option value="1">抽查</option>
        <option value="2">以上两者</option>
    </select><br/>
    <div style="display: none" id="execCompanyDiv">
        执行单位：<zt:mytreeselect id="checkCompanCode" name="checkCompanCode" value=""
                              labelName="checkCompanyName"
                              labelValue=""
                              title="区县选择" checked="true"
                              url="/topGover/office/office.json"></zt:mytreeselect><br/><br/>
    </div>
    <br/>
    <h3>接收对象：</h3><br/>

    单位类型：
    <select name="objectCompanyType">
        <option value="0"
                <%if(record.getString("object_company").equals("0")){%>selected="selected"<%} %>>大学
        </option>
        <option value="1"
                <%if(record.getString("object_company").equals("1")){%>selected="selected"<%} %>>大专
        </option>
        <option value="2"
                <%if(record.getString("object_company").equals("2")){%>selected="selected"<%} %>> 高中
        </option>
        <option value="3"
                <%if(record.getString("object_company").equals("3")){%>selected="selected"<%} %>>初中
        </option>
        <option value="4"
                <%if(record.getString("object_company").equals("4")){%>selected="selected"<%} %>>小学
        </option>
        <option value="5"
                <%if(record.getString("object_company").equals("5")){%>selected="selected"<%} %>>幼儿园
        </option>
    </select>

    <br/>
    区县：<zt:mytreeselect id="objectCompanyParentCode" name="objectCompanyParentCode" value=""
                        labelName="objectCompanyParentCode"
                        labelValue=""
                        title="区县选择" checked="true"
                        url="/topGover/office/office.json"></zt:mytreeselect><br/>
    范围：
    <select name="objectCompany" id="objectCompany">
        <option value="0">所有下级</option>
        <option value="1">本单位</option>
        <option value="2">本单位及下级单位</option>
        <option value="3">指定单位</option>
        <option value="9">所有单位</option>
    </select>
    <br/>

    指定单位： <zt:mytreeselect id="companyCode" name="companyCode" value="" labelName="companyName"
                           labelValue=""
                           title="学校选择" checked="true"
                           url="/topGover/office/office.json"></zt:mytreeselect><br/>


    指定人： <zt:mytreeselect id="apportionUserIds" name="apportionUserIds" value=""
                          labelName="apportionUserNames" labelValue=""
                          title="指定人选择" checked="true"
                          url="/topGover/user/userInfo.json"></zt:mytreeselect><br/>


    <input type="submit" value="提交">
</form>

<script>
  //检查任务类型，绝对是否要显示任务执行单位选择。
  function checkTaskCategory(v) {
    debugger
    if (v !== "0") {
      document.getElementById("execCompanyDiv").style.display = "block";
    }
  }

  function showApplyDiv() {

    document.getElementById("applyDiv").style.display = "block";

  }

  function hideApplyDiv() {
    document.getElementById("applyDiv").style.display = "none";
  }

  var selectFormList = new Array();
  if (<%=taskFormRecord.toJsonString()!=null%>) {
    selectFormList = JSON.parse(<%=taskFormRecord.toJsonString()%>).date;
  }

  function alertFromPage() {
    top.dialog({
      title: "选择用户",
      url: "<%=request.getContextPath()%>/CheckFromInfo.jsp",
      width: 600,
      height: 500,
      button: [{
        id: 'ok',
        value: '选择',
        callback: function () {
          var e = top.$("div[role=dialog]").find("iframe")[0].contentWindow;
          var checkedNode = e.getCheckedNode();
          var tableData = JSON.parse(e.getTableDataJson()).data;
          debugger
          for (var j = 0; j < tableData.length; j++) {
            for (var i = 0; i < checkedNode.length; i++) {
              if (checkedNode[i].checked) {
                if (tableData[j].FORM_ID == checkedNode[i].value) {
                  selectFormList.push(tableData[j]);
                }
              }
            }
          }
          createFormTabel();
        }
      }]
    }).show();
  }

  //创建显示选择的表单表格。
  function createFormTabel() {

    $("#selectFormList").append("");
    var html = ""
    var formJson = "";
    var formType = "";

    for (var i = 0; i < selectFormList.length; i++) {
      formJson += selectFormList[i].TASK_ID;
      if (i < selectFormList.length - 1) {
        formJson += ",";
      }
      switch (selectFormList[i].FORM_TYPE) {
        case "0":
          formType = '选项表单'
          break;
        case "1":
          formType = '模板文件表单'
          break;
        case "2":
          formType = '其它填报表单'
          break;
        default :
          formType = '选项表单'
          break;
      }
      html += '<tr><td>' + selectFormList[i].FORM_NAME + '</td>' +
          '<td>' + formType + '</td>' +
          '<td>' + selectFormList[i].COMPANY_NAME + '</td>' +
          '<td><a href="#">预览</a></td></tr>';
    }

    document.getElementById("formIds").value = formJson;
    $("#selectFormList").append(html);
  }


</script>

</body>
</html>
