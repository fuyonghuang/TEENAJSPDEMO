<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/import.jsp" %>


<%
    // 	 参数接收;
    request.setCharacterEncoding("UTF-8");
    String action =
            request.getParameter("txtAction") == null ? "query" : request.getParameter("txtAction");
    com.rad.db.Record record = new Record();
    String formId = request.getParameter("formId") == null ? "" : request.getParameter("formId");
    String formName =
            request.getParameter("formName") == null ? "" : request.getParameter("formName");
    String formType =
            request.getParameter("formType") == null ? "" : request.getParameter("formType");
    String openStatus =
            request.getParameter("openStatus") == null ? "" : request.getParameter("openStatus");
    String inputType =
            request.getParameter("inputType") == null ? "" : request.getParameter("inputType");
    String startTime =
            request.getParameter("startTime") == null ? "" : request.getParameter("startTime");
    String endTime = request.getParameter("endTime") == null ? "" : request.getParameter("endTime");
    SqlManager sqlManager = new SqlManager();
    java.util.Vector vPara = new Vector();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String strSql = "";
    if (formId.equals("") && "check".equals(action)) {
        //复选框选择返回选中表单
        String[] formIds = request.getParameterValues("formIds");
        if (formIds != null) {
            strSql = "select a.* from s_form_info a  where  1=1  ";
            for (int i = 0; i < formIds.length; i++) {
                if (i == 0) {
                    strSql += "and a.FORM_ID = ?";
                    vPara.add(formIds[i]);
                } else {
                    strSql += "or a.FORM_ID = ?";
                    vPara.add(formIds[i]);
                }
            }
            record = sqlManager.getRecords(strSql, vPara);
        }

        out.write("<script> window.localStorage.setItem('formDate'," + record.toJsonString()
                .toString()
                + ")</script>");
    } else if (action.equals("insert")) {
        //添加表单
        Date date = new Date();
        HashMap<String, String> hKeyValue = new HashMap<String, String>();
        formId = (new java.util.Date().getTime()) + "-" + java.util.UUID.randomUUID().toString();
        hKeyValue.put("FORM_ID", formId);
        hKeyValue.put("FORM_NAME", formName);
        hKeyValue.put("FORM_TYPE", formType);
        hKeyValue.put("OPEN_STATUS", openStatus);
        hKeyValue.put("INPUT_TYPE", inputType);
        hKeyValue.put("START_TIME", startTime);
        hKeyValue.put("END_TIME", endTime);
        hKeyValue.put("COMPANY_CODE", "");
        hKeyValue.put("COMPANY_NAME", "上海市教委");
        hKeyValue.put("CREATE_TIME", sdf.format(date));
        hKeyValue.put("CREATE_USER", "李老师");
        try {
            CommonDaoAction.insertInfo("s_form_info", hKeyValue);
//   	      	   fileUpload.upload();
            //增加日志，暂时没写
            response.sendRedirect("formInfoList.jsp");
        } catch (Exception e) {
            out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                    + "\");window.history.back(); </script>");
            return;
        }
    } else if (action.equals("update")) {
        //更新表单
        Date date = new Date();
        HashMap<String, String> hKeyValue = new HashMap<String, String>();
        hKeyValue.put("FORM_NAME", formName);
        hKeyValue.put("FORM_TYPE", formType);
        hKeyValue.put("OPEN_STATUS", openStatus);
        hKeyValue.put("INPUT_TYPE", inputType);
        hKeyValue.put("START_TIME", startTime);
        hKeyValue.put("END_TIME", endTime);
        hKeyValue.put("UPDATE_TIME", sdf.format(date));
        hKeyValue.put("UPDATE_USER", "黄老师");
        try {
            CommonDaoAction.updateInfoByKeyValue("s_form_info", "FORM_ID", formId, hKeyValue);
            response.sendRedirect("formInfoList.jsp");
        } catch (Exception e) {
            out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                    + "\");window.history.back(); </script>");
            return;
        }
    } else if (action.equals("delete")) {
        //删除表单
        try {

            if (formId.equals("")) {
                String[] formIds = request.getParameterValues("ckIdx");
                if (formIds != null) {
                    for (int i = 0; i < formIds.length; i++) {
                        formId = formIds[i];
                        CommonDaoAction.deleteInfoByKeyValue("s_form_info", "FORM_ID", formId);
                        //增加日志，暂时没写
                    }
                }
            } else {
                CommonDaoAction.deleteInfoByKeyValue("s_form_info", "FORM_ID", formId);
                //增加日志，暂时没写
            }
            response.sendRedirect("formInfoList.jsp");
        } catch (Exception e) {
            out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                    + "\");window.history.back(); </script>");
            return;
        }
    }
%>
