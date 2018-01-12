<%@ page import="com.rad.db.CommonDaoAction" %>
<%@ page import="com.rad.db.Record" %>
<%@ page import="com.rad.util.CommonUtil" %>
<%@ page import="java.util.HashMap" %>
<!-- 引入变量-->
<%@include file="/topGover/task/po/taskObjectInfoVariable.jsp" %>

<%@ include file="/configQueryPage.jsp" %>
<!-- 引入sql 常量 -->
<%@ include file="/topGover/task/sqlConstant/taskObjectInfoSql.jsp" %>
<%

    String action =
            request.getParameter("txtAction") == null ? "query" : request.getParameter("txtAction");
    //认领操作。
    if ("claimAction".equals(action)) {
        //更新数据
        HashMap<String, String> hKeyValue = new HashMap<String, String>();
        hKeyValue.put("CONFIRM_TIME", confirmTime);
        hKeyValue.put("CONFIRM_USER_ID", "123");
        hKeyValue.put("CONFIRM_USER_NAME", "123");
        hKeyValue.put("STATUS", "1");

        try {
            CommonDaoAction
                    .updateInfoByKeyValue("T_TASK_OBJECT_INFO", "task_objct_id", taskObjectId,
                            hKeyValue);
            /**
             * 获取关联表单数据
             */
            Record taskFormRecord = CommonDaoAction
                    .getInfoByKeyValue("t_task_form", "task_id", taskId);
            while (taskFormRecord.next()) {
                String formId = taskFormRecord.getString("form_id");
                Record formInfoRecord = CommonDaoAction
                        .getInfoByKeyValue("s_form_info", "form_id", formId);
                String formName = formInfoRecord.getString("form_name");
                String tableName = formInfoRecord.getString("table_name");
                String tableId = formInfoRecord.getString("table_id");
                String checkBelongCompanyCode = formInfoRecord.getString("company_name");
                HashMap<String, String> checkInfoMap = new HashMap();
                String checkResultId = CommonUtil.getUUid();
                checkInfoMap.put("check_result_id", checkResultId);
                checkInfoMap.put("task_id", taskId);
                checkInfoMap.put("form_id", formId);
                checkInfoMap.put("task_from", "");
                checkInfoMap.put("form_name", formName);
                checkInfoMap.put("table_name", tableName);
                checkInfoMap.put("table_id", tableId);
                checkInfoMap.put("pname", "");
                checkInfoMap.put("cname", "");
                checkInfoMap.put("dname", "");
                checkInfoMap.put("streetname", "");
                checkInfoMap.put("check_result", "0");
                //默认未开始
                checkInfoMap.put("check_status", "0");
                checkInfoMap.put("company_id", companyCode);
                checkInfoMap.put("company_code", companyCode);
                checkInfoMap.put("company_name", companyName);
                checkInfoMap.put("check_company_code", checkCompanyCode);
                checkInfoMap.put("check_company_name", checkCompanyName);
                checkInfoMap.put("parent_code", "");
                //检查表单归属单位
                checkInfoMap.put("check_belong_company_code", checkBelongCompanyCode);
                checkInfoMap.put("create_time", formId);
                checkInfoMap.put("create_user", formId);
                try {
                    CommonDaoAction.insertInfo("t_check_info", checkInfoMap);
                } catch (Exception e) {
                    out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                            + "\");window.history.back(); </script>");
                    return;
                }

                //获取检查内容
                Record checkContentRecord = CommonDaoAction
                        .getInfoByKeyValue("s_check_content", "form_id", formId);
                //生成检查结果明细表数据
                while (checkContentRecord.next()) {
                    HashMap<String, String> checkResultMap = new HashMap();
                    String itemResultId = CommonUtil.getUUid();
                    checkResultMap.put("item_result_id", itemResultId);
                    checkResultMap.put("check_result_id", checkResultId);
                    checkResultMap.put("task_id", taskId);
                    checkResultMap.put("form_id", formId);
                    checkResultMap.put("task_from", "");
                    checkResultMap.put("form_name", formName);
                    checkResultMap.put("table_name", tableName);
                    checkResultMap.put("table_id", tableId);
                    checkResultMap.put("pname", "");
                    checkResultMap.put("cname", "");
                    checkResultMap.put("dname", "");
                    checkResultMap.put("streetname", "");
                    checkResultMap.put("item_id", checkContentRecord.getString("item_id"));
                    checkResultMap.put("item_title", checkContentRecord.getString("item_title"));
                    checkResultMap.put("item_no", checkContentRecord.getString("item_no"));
                    checkResultMap.put("type_name1", checkContentRecord.getString("type_name1"));
                    checkResultMap.put("type_name2", checkContentRecord.getString("type_name2"));
                    checkResultMap.put("type_name3", checkContentRecord.getString("type_name3"));
                    checkResultMap
                            .put("content_title", checkContentRecord.getString("content_title"));
                    checkResultMap
                            .put("answer_result", checkContentRecord.getString("answer_result"));
                    checkResultMap
                            .put("item_content", checkContentRecord.getString("item_content"));
                    checkResultMap.put("score", "");
                    checkResultMap.put("check_result", "");
                    checkResultMap.put("check_desc", "");
                    checkResultMap.put("photo_path", "");
                    checkResultMap.put("viedio_path", "");
                    checkResultMap.put("file_path", filePath);
                    checkResultMap.put("audio_path", "");
                    checkResultMap.put("company_id", "");
                    checkResultMap.put("company_code", companyCode);
                    checkResultMap.put("company_name", companyName);
                    checkResultMap.put("check_company_code", checkCompanyCode);
                    checkResultMap.put("check_company_name", checkCompanyName);
                    checkResultMap.put("parent_code", "");
                    checkResultMap.put("user_id", userId);
                    checkResultMap.put("user_name", userName);
                    checkResultMap.put("check_year", "");
                    checkResultMap.put("check_month", "");
                    checkResultMap.put("check_date", "");
                    checkResultMap.put("check_week", "");
                    checkResultMap.put("check_time", "");
                    checkResultMap.put("create_time", createTime);
                    checkResultMap.put("create_user", createUser);
                    checkResultMap.put("update_time", updateTime);
                    checkResultMap.put("update_user", updateUser);
                    try {
                        CommonDaoAction.insertInfo("t_check_result", checkResultMap);
                    } catch (Exception e) {
                        out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                                + "\");window.history.back(); </script>");
                        return;
                    }
                }
            }
            response.sendRedirect("/topGover/task/taskObjectInfo/taskObjectInfoList.jsp");
        } catch (Exception e) {
            response.sendRedirect("/");
            out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                    + "\");window.history.back(); </script>");
            return;
        }
    } else if ("".equals(action)) {

    }


%>

