<%--
  Created by IntelliJ IDEA.
  User: fuyong_huang
  Date: 2018/1/12
  Time: 14:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>多任务创建</title>
    <script src="/js/jquery-2.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/artDialog/7.0.0/dialog-plus.js"></script>
    <link rel="stylesheet" href="/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="/js/ztree/jquery.ztree.core.js"></script>
</head>
<body>

<form action="/topGover/task/taskInfo/taskInfoSave.jsp?txtAction=saveMulitTask" method="post">

    任务名称: <input type="text" name="taskName"><br>
    开始时间: <input type="date" name="startDate">
    <input type="time" name="startTime"> ~ 截至时间: <input type="date" name="endDate">
    <input type="time" name="endTime"><br>
    <input type="text" name="taskCategory">
    <br/>

    处理方式：
    <select name="infoHandleType">
        <option value="0">单次</option>
        <option value="1">每日</option>
        <option value="2">每周</option>
        <option value="3">每月</option>
        <option value="4">每年</option>
    </select>

    <textarea name="subTaskListStr" id="subTaskListStr"></textarea>

    <h3>选择子任务</h3>
    <button type="button" onclick="subTaskTableSelect()">选择子任务</button>
    <div>
        <table>

            <tr class="queryTableResultTitleStyle">
                <td width="10%"><span id="task_name">任务名称</span>
                </td>
                <td width="10%"><span
                        id="company_name">下发单位</span>
                </td>
                <td width="10%"><span id="start_date">开始时间</span>
                </td>
                <td width="10%"><span id="end_date">结束时间</span></td>
                <td width="10%"> <span
                        id="release_persion">发布人</span></td>
                <td width="10%"><span
                        id="release_time">发布时间</span>
                </td>
                <td width="10%"> <span
                        id="info_handle_type">检查频率</span></td>
                <td width="5%"><span id="info_status">状态</span>
                </td>
            </tr>
            <tbody id="subTaskList">
            </tbody>

        </table>
    </div>
    <button type="submit">提交</button>
    <button type="button">取消</button>

</form>
</body>
<script>

  var subTaskList = new Array();

  function subTaskTableSelect() {

    top.dialog({
      id: "treeSelect",
      title: "选择",
      url: " /topGover/task/taskInfo/taskInfoSelectList.jsp",
      width: 780,
      height: 500,
      button: [{
        id: 'ok',
        value: '选择',
        callback: function () {
          var e = top.$("div[role=dialog]").find("iframe")[0].contentWindow;
          var checkedNode = e.getCheckedNode();
          var tableData = JSON.parse(e.getTableDataJson()).data;
          console.log(tableData[0].TASK_ID);
          debugger
          for (var j = 0; j < tableData.length; j++) {
            for (var i = 0; i < checkedNode.length; i++) {
              if (checkedNode[i].checked) {
                if (tableData[j].TASK_ID == checkedNode[i].value) {
                  subTaskList.push(tableData[j]);
                  console.table(subTaskList)
                }
              }

            }
          }

          createSubTaskList();

        }
      }]
    }).show();

  }

  //生成子任务列表
  function createSubTaskList() {
    $("#subTaskList").append("");
    var html = ""
    var json = "";
    for (var i = 0; i < subTaskList.length; i++) {
      var status;
      var handleType;
      json += subTaskList[i].TASK_ID;
      if (i != subTaskList.length) {
        json += ",";
      }
      switch (subTaskList[i].INFO_STATUS) {
        case "0":
          status = '待审核'
          break;
        case "1":
          status = '通过审核'
          break;
        case "2":
          status = '审核拒绝'
          break;
        case "3":
          status = '已发布'
          break;
        case "4":
          status = '已完成'
          break;
        default :
          status = '待审核'
          break;

      }
      switch (subTaskList[i].INFO_HANDLE_TYPE) {
        case "0":
          handleType = '单次'
          break;
        case "1":
          handleType = '每天'
          break;
        case "2":
          handleType = '每周'
          break;
        case "3":
          handleType = '每月'
          break;
        case "4":
          handleType = '每年'
          break;
        default :
          handleType = '每年'
          break;

      }
      html += '<tr><td>' + subTaskList[i].TASK_NAME + '</td>' +
          '<td>' + subTaskList[i].COMPANY_NAME + '</td>' +
          '<td>' + subTaskList[i].START_DATE + '</td>' +
          '<td>' + subTaskList[i].END_DATE + '</td>' +
          '<td>' + subTaskList[i].RELEASE_PERSION + '</td>' +
          '<td>' + subTaskList[i].RELEASE_TIME + '</td>' +
          '<td>' +
          handleType
          + '</td><td>'
          +
          status
          + '</td></tr>';

    }
    debugger
    document.getElementById("subTaskListStr").value = json;
    $("#subTaskList").append(html);

  }

</script>
</html>
