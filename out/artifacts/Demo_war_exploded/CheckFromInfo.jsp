<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/import.jsp" %>

<!-- 检验有没有登录 -->
<%-- <%@ include file="/sessionCheck.jsp"%> --%>
<%@ include file="/configQueryPage.jsp" %>
<%

    String action =
            request.getParameter("txtAction") == null ? "query" : request.getParameter("txtAction");
    com.rad.db.Record record = new Record();
    String formName =
            request.getParameter("formName") == null ? "" : request.getParameter("formName");
    String formType =
            request.getParameter("formType") == null ? "" : request.getParameter("formType");
    String openStatus =
            request.getParameter("openStatus") == null ? "" : request.getParameter("openStatus");
    String company = request.getParameter("company") == null ? "" : request.getParameter("company");
    String orderByKey = request.getParameter("orderByKey") == null ? "userId asc"
            : request.getParameter("orderByKey");
    String orderByKeyPara = request.getParameter("orderByKeyPara") == null ? "userId"
            : request.getParameter("orderByKeyPara");
    SqlManager sqlManager = new SqlManager();
    java.util.Vector vPara = new Vector();
    String strSql = "";
    if ("query".equals(action)) {

        vPara = new Vector();
        strSql = "select a.* from s_form_info a  where  1=1  ";
        if (!"".equals(formName)) {
            strSql += " and a.FORM_NAME like ? ";
            vPara.add("%" + formName + "%");
        }
        if (!"".equals(formType)) {
            strSql += " and a.FORM_TYPE = ? ";
            vPara.add(formType);
        }
        if (!"".equals(openStatus)) {
            strSql += " and a.OPEN_STATUS = ? ";
            vPara.add(openStatus);
        }
        if (!"".equals(company)) {
            strSql += " and a.COMPANY_NAME like ? ";
            vPara.add("%" + company + "%");
        }
        if (vPara.size() == 0) {
            vPara = null;
        }
// 	        strSql+=" order by "+orderByKey;
        record = sqlManager.getRecords(strSql, vPara, pageQuery);
// 	        request.getSession().setAttribute("expExcel_sql",strSql);
// 	        request.getSession().setAttribute("expExcel_para",vPara);
        out.println("<span id='formTableData' style='display:none'>" + record.toJsonString()
                + "</span>");
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
</head>
<script src="/js/jquery-2.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/artDialog/7.0.0/dialog-plus.js"></script>
<body>

<div id="u0" class="">
    <div id="u0_div" class=""></div>
    <div id="u0_text" class="text ">
        <p><span>表单列表</span></p>
    </div>
</div>

<form method="post" action="CheckFromInfo.jsp" name="this_form" id="this_form">
    <div style="width:100%">
        <div style="float: left;  margin-left: 15%;">
            <span>表单类型</span>
            <select id="formType" name="formType">
                <option value="">请选择</option>
                <option value="0" <%if(formType.equals("0")){%>selected="selected"<%} %>>选项表单
                </option>
                <option value="1" <%if(formType.equals("1")){%>selected="selected"<%} %>>模板文件表单
                </option>
                <option value="2" <%if(formType.equals("2")){%>selected="selected"<%} %>>其它填报表单
                </option>
            </select>
        </div>
        <div style="float: left;  margin-left: 6%;">
            <span>开放状态</span>
            <select id="openStatus" name="openStatus">
                <option value="请选择">请选择</option>
                <option value="0" <%if(openStatus.equals("0")){%>selected="selected"<%} %>>不开放
                </option>
                <option value="1" <%if(openStatus.equals("1")){%>selected="selected"<%} %>>开放
                </option>
            </select>
        </div>
        <div id="u7" style="float: left;  margin-left: 6%;">
            <input id="search" type="submit" value="搜索">
        </div>

        <div id="u35" style="float: left;margin-left: 6%;">
            <input id="u7_input" type="button" value="创建表单">
        </div>
    </div>
    <div>
        <div style="float: left;  margin-left: 15%;">
            <span>表单名称</span>
            <input id="formName" name="formName" type="text" value="<%=formName%>"
                   style="color: rgb(153, 153, 153);">

        </div>

        <div style="float: left;  margin-left: 15%;">
            <span>单位名称</span>
            <input id="company" name="company" type="text" value="<%=company%>"
                   style="color: rgb(153, 153, 153);">
        </div>
    </div>
    <input type="hidden" name="txtAction" id="txtAction" value="<%=action%>">
    <div style="float: left;  width: 100%;">
        <table id="formTable">
            <tr>
                <td></td>
                <td>单位</td>
                <td>表单类型</td>
                <td>表单名称</td>
                <td>开发状态</td>
            </tr>
            <%
                while (record.next()) {
            %>
            <tr>
                <td><input type="checkbox" name="formIds"
                           value="<%=record.getString("FORM_ID")%>">
                </td>
                <td><%=record.getString("COMPANY_NAME")%>
                </td>
                <td>
                    <%if (record.getString("FORM_TYPE").equals("0")) {%>
                    选项表单
                    <%} else if (record.getString("FORM_TYPE").equals("1")) {%>
                    模板文件表单
                    <%} else if (record.getString("FORM_TYPE").equals("2")) {%>
                    其它填报表单
                    <%} %>
                </td>
                <td><%=record.getString("FORM_NAME")%>
                </td>
                <td>
                    <%if (record.getString("OPEN_STATUS").equals("0")) {%>
                    不开放
                    <%} else if (record.getString("OPEN_STATUS").equals("1")) {%>
                    开放
                    <%} %>
                </td>
            </tr>
            <%}%>
        </table>
        <span name="formTableData" style="display: none"></span>
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
    <button type="button" id="checkSubmit">确定</button>
</form>
</body>
<script type="text/javascript">
  var list = new Array();

  function onSelect(e) {
    if (e.checked == false) {
      list.splice($.inArray(e.value, list), 1);
    } else if (e.checked == true) {
      list.push(e.value);
    }
    var jsonObject = new Object();
    jsonObject.formDate = list;
    sessionStorage.setItem("formIds", JSON.stringify(jsonObject));
  }

  function getCheckedNode() {

    return document.getElementsByName("formIds");
  }

  function getTableDataJson() {
    return document.getElementById("formTableData").innerText;
  }

  $(function () {
    $("#checkSubmit").click(function () {
      $("#txtAction").val("check");
      $("#this_form").attr("action", "formInfoSave.jsp");
      document.this_form.submit();
    });
    $("#search").click(function () {
      $("#txtAction").val("query");
    });
  });
</script>
</html>