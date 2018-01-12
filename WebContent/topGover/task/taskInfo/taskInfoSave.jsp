<%@ page import="com.jt.entity.SCompanyInfo" %>
<%@ page import="com.rad.db.CommonDaoAction" %>
<%@ page import="java.util.HashMap" %>
<%@ include file="/import.jsp" %>
<%@ include file="/topGover/task/po/taskInfoVariable.jsp" %>
<%

    if ("save".equals(action)) {

        request.getParameter("infoStatus");
        //todo 抽查时选择多个执行单位，需要生成多条记录
        //todo
        //对象分类   0 单位1指定人
        String taskObjctType = "";
        if ("".equals(apportionUserId)) {
            taskObjctType = "0";
        } else {
            taskObjctType = "1";
        }

        if ("0".equals(taskCategory)) {
            //自检任务

        } else if ("1".equals(taskCategory)) {
            //抽查任务

        } else if ("2".equals(taskCategory)) {
            //抽查自查同时。

        }

        formIdStr = "1,2,3,4,5";
        String[] formArry = formIdStr.split(",");
        //插入task_info

        taskId = CommonUtil.getUUid();
        HashMap<String, String> map = warpTaskInfoMap(taskId, taskName, taskType, startDate,
                formArry.length > 1 ? "1" : "0", endDate, startTime,
                endTime,
                notHandleDay, onlyWorkDay, infoHandleType, releasePersion, releaseTime, checkType,
                checkCompanyCode, checkCompanyName, objectCompanyType, objectCompanyParentCode,
                objectCompany,
                objectUser, totalObjectNum, applyPerson, checkPerson, checkDesc, checkTime,
                createTime, isApply);
        try {
            CommonDaoAction.insertInfo("t_task_info", map);
        } catch (Exception e) {
            out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                    + "\");window.history.back(); </script>");
            return;
        }
        String OfficeStr = companyCode;
        String officeNameStr = companyName;
        String[] officeArry = null;
        String[] officeNameArray = null;

        List<SCompanyInfo> offices = new ArrayList<>();

        //根据指定单位类型来查询指定单位数据
        if ("0".equals(objectCompany)) {
            //所有下级

            //todo 1、获取所有下级信息
            //todo 2、根据获取的下级信息将数据录入

            officeArry = OfficeStr.split(",");
        } else if ("1".equals(objectCompany)) {
            //本单位
            //todo 从session中获取
            officeArry = OfficeStr.split(",");
        } else if ("2".equals(objectCompany)) {
            //本单位及下级
            //todo 1、从session中获取，获取所有下级信息
            //todo 2、根据获取的下级信息将数据录入
            officeArry = OfficeStr.split(",");
        } else if ("3".equals(objectCompany)) {
            //指定单位
            //由前端选择的参数进行插入
            officeArry = OfficeStr.split(",");
            officeNameArray = officeNameStr.split(",");

            for (int i = 0; i < officeArry.length; i++) {
                SCompanyInfo sCompanyInfo = new SCompanyInfo();
                sCompanyInfo.setCompanyCode(officeArry[i]);
                sCompanyInfo.setCompanyName(officeNameArray[i]);
                offices.add(sCompanyInfo);
            }
        } else if ("9".equals(objectCompany)) {
            //todo 所有单位
            officeArry = OfficeStr.split(",");
        }

        //在task_object_info 中生成记录

        // 根据选择任务接收对象插入至task_object_info中
        for (SCompanyInfo Office : offices
                ) {
            String taskObjectId = CommonUtil.getUUid();
            //组装map  task_Object_info
            HashMap<String, String> taskObjectMap = wrapTaskObjectMap(taskObjctType, taskId, map,
                    Office.getCompanyName(),
                    Office.getCompanyCode(), taskObjectId, checkCompanyCode, checkCompanyName,
                    apportionUserId,
                    apportionUserName, checkRemark, taskType);
            try {
                CommonDaoAction.insertInfo("t_task_object_info", taskObjectMap);
            } catch (Exception e) {
                out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                        + "\");window.history.back(); </script>");
                return;
            }

        }

        String userStr = "1,2,3,4,5,6,7,8,9";
        String[] userArry = userStr.split(",");
        // 根据选择任务接收对象插入至task_object_info中
        for (String user : userArry
                ) {
            //插入task_Object_info
            HashMap<String, String> taskObjectMap = new HashMap();
            String taskObjectId = CommonUtil.getUUid();
            taskObjectMap.put("task_objct_id", taskObjectId);
            taskObjectMap.put("task_id", taskId);
            map.put("company_code", OfficeStr);
            map.put("company_name", companyName);
            taskObjectMap.put("check_company_code", checkCompanyCode);
            taskObjectMap.put("check_company_name", checkCompanyName);
            taskObjectMap.put("user_id", user);
            taskObjectMap.put("user_name", user);
            taskObjectMap.put("task_objct_type", "1");
            taskObjectMap.put("confirm_time", "");
            taskObjectMap.put("confirm_user_id", "");
            taskObjectMap.put("confirm_user_name", "");
            taskObjectMap.put("task_start_time", "");
            taskObjectMap.put("task_end_time", "");
            taskObjectMap.put("handle_time", "");
            taskObjectMap.put("handle_user_id", "");
            taskObjectMap.put("handle_user_name", "");
            taskObjectMap.put("status", "0");
            taskObjectMap.put("check_remark", checkRemark);
            taskObjectMap.put("total_check_num", "");
            taskObjectMap.put("create_time", DateUtils.formatDateToString(new Date()));
            taskObjectMap.put("create_user", "");
            taskObjectMap.put("task_type", "");

            try {
                CommonDaoAction.insertInfo("t_task_object_info", taskObjectMap);
            } catch (Exception e) {
                out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                        + "\");window.history.back(); </script>");
                return;
            }
        }

        //表单任务关联。
        for (String formId : formArry
                ) {
            HashMap<String, String> taskFormtMap = new HashMap();
            taskFormtMap.put("task_form_id", CommonUtil.getUUid());
            taskFormtMap.put("task_id", taskId);
            taskFormtMap.put("form_id", formId);
            try {
                CommonDaoAction.insertInfo("t_task_form", taskFormtMap);
            } catch (Exception e) {
                out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                        + "\");window.history.back(); </script>");
                return;
            }

            for (SCompanyInfo Office : offices
                    ) {

                Record formInfoRecord = CommonDaoAction
                        .getInfoByKeyValue("s_form_info", "form_id", formId);
                String formName = formInfoRecord.getString("form_name");
                String tableName = formInfoRecord.getString("table_name");
                String tableId = formInfoRecord.getString("table_id");
                String checkBelongCompanyCode = formInfoRecord.getString("company_name");
                String checkResultId = CommonUtil.getUUid();
                HashMap<String, String> checkInfoMap = warpCheckInfoMap(taskId, taskFrom, userInfo,
                        Office.getCompanyCode(), Office.getCompanyName(), checkCompanyCode,
                        checkCompanyName, formId, formName, tableName, tableId,
                        checkBelongCompanyCode, checkResultId);
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
                    String itemId = checkContentRecord.getString("item_id");
                    String itemTitle = checkContentRecord.getString("item_title");
                    String itemNo = checkContentRecord.getString("item_no");
                    String typeName1 = checkContentRecord.getString("type_name1");
                    String typeName2 = checkContentRecord.getString("type_name2");
                    String typeName3 = checkContentRecord.getString("type_name3");
                    String contentTitle = checkContentRecord.getString("content_title");
                    String answerResult = checkContentRecord.getString("answer_result");
                    String itemContent = checkContentRecord.getString("item_content");
                    HashMap<String, String> checkResultMap = warpCheckResultMap(taskId,
                            Office.getCompanyCode(), Office.getCompanyName(), checkCompanyCode,
                            checkCompanyName, createTime,
                            createUser, formId, formName, tableName, tableId, checkResultId, itemId,
                            itemTitle, itemNo,
                            typeName1, typeName2, typeName3, contentTitle, answerResult,
                            itemContent);

                    try {
                        CommonDaoAction.insertInfo("t_check_result", checkResultMap);
                    } catch (Exception e) {
                        out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                                + "\");window.history.back(); </script>");
                        return;
                    }


                }
            }
        }
        response.sendRedirect("/topGover/task/taskInfo/taskInfoList.jsp?txtAction=query");
    } else if ("update".equals(action)) {
        //更新数据
        HashMap<String, String> hKeyValue = new HashMap<String, String>();
        hKeyValue.put("userName",
                request.getParameter("userName") == null ? "" : request.getParameter("userName"));
        hKeyValue.put("userTel",
                request.getParameter("userTel") == null ? "" : request.getParameter("userTel"));
        try {
            CommonDaoAction.updateInfoByKeyValue("userInfo", "userId", "", hKeyValue);
            //增加日志，注释，没表
            //CommonDaoAction.insertLog("userInfo","修改用户信息",hKeyValue.toString()+userId,"update",userInfo.getString("userName"));
            response.sendRedirect("userInfoQuery.jsp?txtAction=query&saveQuery=1");
        } catch (Exception e) {
            out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                    + "\");window.history.back(); </script>");
            return;
        }

    } else if ("delete".equals(action)) {
        //删除数据
        try {
            CommonDaoAction.deleteInfoByKeyValue("userInfo", "userId", "");
            response.sendRedirect("userInfoQuery.jsp?txtAction=query&saveQuery=1");
        } catch (Exception e) {
            out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                    + "\");window.history.back(); </script>");
            return;
        }
    } else if ("audit".equals(action)) {
        procFlowInfo = "{\"123\",\"1234\"}";
        //更新数据
        HashMap<String, String> hKeyValue = new HashMap<String, String>();
        hKeyValue.put("check_desc", checkDesc);
        hKeyValue.put("check_time", checkTime);
        hKeyValue.put("info_status", infoStatus);
        hKeyValue.put("proc_flow_info", procFlowInfo);
        try {
            CommonDaoAction.updateInfoByKeyValue("t_task_info", "task_id", taskId, hKeyValue);
            //增加日志，注释，没表
            //CommonDaoAction.insertLog("userInfo","修改用户信息",hKeyValue.toString()+userId,"update",userInfo.getString("userName"));
            response.sendRedirect("taskInfoList.jsp?txtAction=query");
        } catch (Exception e) {
            out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                    + "\");window.history.back(); </script>");
            return;
        }
    } else if ("saveTask".equals(action)) {
        taskId = CommonUtil.getUUid();
        HashMap<String, String> map = warpTaskInfoMap(taskId, taskName, taskType, startDate,
                "", endDate, startTime,
                endTime,
                notHandleDay, onlyWorkDay, infoHandleType, releasePersion, releaseTime, checkType,
                checkCompanyCode, checkCompanyName, objectCompanyType, objectCompanyParentCode,
                objectCompany,
                objectUser, totalObjectNum, applyPerson, checkPerson, checkDesc, checkTime,
                createTime, isApply);

        try {
            CommonDaoAction.insertInfo("t_task_info", map);
        } catch (Exception e) {
            out.println("<script>alert(\"保存出错,错误代码:" + e.getMessage()
                    + "\");window.history.back(); </script>");
            return;
        }
    }

%>
<%!
    /**
     * warpCheckResultMap
     * @param taskId
     * @param companyCode
     * @param companyName
     * @param checkCompanyCode
     * @param checkCompanyName
     * @param createTime
     * @param createUser
     * @param formId
     * @param formName
     * @param tableName
     * @param tableId
     * @param checkResultId
     * @param itemId
     * @param itemTitle
     * @param itemNo
     * @param typeName1
     * @param typeName2
     * @param typeName3
     * @param contentTitle
     * @param answerResult
     * @param itemContent
     * @return
     */
    private HashMap<String, String> warpCheckResultMap(String taskId, String companyCode,
            String companyName, String checkCompanyCode, String checkCompanyName, String createTime,
            String createUser, String formId, String formName, String tableName, String tableId,
            String checkResultId, String itemId, String itemTitle, String itemNo, String typeName1,
            String typeName2, String typeName3, String contentTitle, String answerResult,
            String itemContent) {
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
        checkResultMap.put("item_id", itemId);
        checkResultMap.put("item_title", itemTitle);
        checkResultMap.put("item_no", itemNo);
        checkResultMap.put("type_name1", typeName1);
        checkResultMap.put("type_name2", typeName2);
        checkResultMap.put("type_name3", typeName3);
        checkResultMap.put("content_title", contentTitle);
        checkResultMap.put("answer_result", answerResult);
        checkResultMap.put("item_content", itemContent);
        checkResultMap.put("score", "");
        checkResultMap.put("check_result", "");
        checkResultMap.put("check_desc", "");
        checkResultMap.put("photo_path", "");
        checkResultMap.put("viedio_path", "");
        checkResultMap.put("file_path", "");
        checkResultMap.put("audio_path", "");
        checkResultMap.put("company_id", companyCode);
        checkResultMap.put("company_code", companyCode);
        checkResultMap.put("company_name", companyName);
        checkResultMap.put("check_company_code", checkCompanyCode);
        checkResultMap.put("check_company_name", checkCompanyName);
        checkResultMap.put("parent_code", "");
        checkResultMap.put("create_time", createTime);
        checkResultMap.put("create_user", createUser);
        return checkResultMap;
    }

    /**
     *checkInfo Map 组装
     */
    private HashMap<String, String> warpCheckInfoMap(String taskId, String taskFrom,
            SUserInfo userInfo, String companyCode, String companyName, String checkCompanyCode,
            String checkCompanyName, String formId, String formName, String tableName,
            String tableId,
            String checkBelongCompanyCode, String checkResultId) {
        HashMap<String, String> checkInfoMap = new HashMap();

        checkInfoMap.put("check_result_id", checkResultId);
        checkInfoMap.put("task_id", taskId);
        checkInfoMap.put("form_id", formId);
        checkInfoMap.put("task_from", taskFrom);
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
        checkInfoMap.put("create_time", DateUtils.formatDateToString(new Date()));
        checkInfoMap.put("create_user", userInfo.getUserId());
        return checkInfoMap;
    }


    /**
     * taskInfoMap
     * @param taskId
     * @param taskName
     * @param taskType
     * @param startDate
     * @param formArry
     * @param endDate
     * @param startTime
     * @param endTime
     * @param notHandleDay
     * @param onlyWorkDay
     * @param infoHandleType
     * @param releasePersion
     * @param releaseTime
     * @param checkType
     * @param checkCompanyCode
     * @param checkCompanyName
     * @param objectCompanyType
     * @param objectCompanyParentCode
     * @param objectCompany
     * @param objectUser
     * @param totalObjectNum
     * @param applyPerson
     * @param checkPerson
     * @param checkDesc
     * @param checkTime
     * @param createTime
     * @param isApply
     * @return
     */
    private HashMap<String, String> warpTaskInfoMap(String taskId, String taskName, String taskType,
            String startDate,
            String formType, String endDate, String startTime,
            String endTime, String notHandleDay, String onlyWorkDay, String infoHandleType,
            String releasePersion, String releaseTime, String checkType, String checkCompanyCode,
            String checkCompanyName, String objectCompanyType, String objectCompanyParentCode,
            String objectCompany, String objectUser, String totalObjectNum, String applyPerson,
            String checkPerson, String checkDesc, String checkTime, String createTime,
            String isApply) {
        HashMap<String, String> map = new HashMap();
        map.put("task_id", taskId);
        map.put("task_name", taskName);
        map.put("task_category", "0");
        map.put("task_type", taskType);
        map.put("task_from", "TASK");
        map.put("start_date", startDate);
        map.put("end_date", endDate);
        map.put("start_time", startTime);
        map.put("end_time", endTime);
        map.put("not_handle_day", notHandleDay);
        map.put("only_work_day", onlyWorkDay);
        map.put("info_handle_type", infoHandleType);
        map.put("company_code", "ss");
        map.put("company_name", "ss");
        map.put("release_persion", releasePersion);
        map.put("release_time", releaseTime);
        map.put("check_type", checkType);
        //抽查任务执行单位
        map.put("check_compan_code", checkCompanyCode);
        map.put("check_company_name", checkCompanyName);
        //如果表单数大于一则为多表单，否则为单表单
        map.put("form_type", formType);
        map.put("info_status", isApply);
        map.put("object_company_type", objectCompanyType);
        map.put("object_company_parent_code", objectCompanyParentCode);
        map.put("object_company", objectCompany);
        map.put("object_user", objectUser);
        map.put("total_object_num", totalObjectNum);
        map.put("apply_person", applyPerson);
        map.put("check_person", checkPerson);
        map.put("check_desc", checkDesc);
        map.put("check_time", checkTime);
        map.put("create_time", createTime);
        map.put("create_user", "");
        return map;
    }

    /**
     * taskObject Map 组装
     * @param taskObjctType
     * @param taskId
     * @param map
     * @param companyName
     * @param companyCode
     * @param taskObjectId
     * @param checkCompanyCode
     * @param checkCompanyName
     * @param apportionUserId
     * @param apportionUserName
     * @param checkRemark
     * @param taskType
     * @return
     */
    private HashMap<String, String> wrapTaskObjectMap(String taskObjctType, String taskId,
            HashMap<String, String> map, String companyName, String companyCode,
            String taskObjectId,
            String checkCompanyCode, String checkCompanyName, String apportionUserId,
            String apportionUserName, String checkRemark, String taskType) {
        HashMap<String, String> taskObjectMap = new HashMap();
        taskObjectMap.put("task_objct_id", taskObjectId);
        taskObjectMap.put("task_id", taskId);
        taskObjectMap.put("company_code", companyCode);
        taskObjectMap.put("company_name", companyName);
        taskObjectMap.put("check_company_code", checkCompanyCode);
        taskObjectMap.put("check_company_name", checkCompanyName);
        taskObjectMap.put("user_id", apportionUserId);
        taskObjectMap.put("user_name", apportionUserName);
        taskObjectMap.put("task_objct_type", taskObjctType);
        taskObjectMap.put("status", "0");
        taskObjectMap.put("check_remark", checkRemark);
        taskObjectMap.put("create_time", DateUtils.formatDateToString(new Date()));
        taskObjectMap.put("create_user", "");
        taskObjectMap.put("task_type", taskType);
        return taskObjectMap;
    }
%>