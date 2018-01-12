<%
    //主表ID值（对应的主表名ID值）
    String tableId = request.getParameter("tableId") == null ? "" : request.getParameter("tableId");
//检查点名称(冗余字段)
    String formName =
            request.getParameter("formName") == null ? "" : request.getParameter("formName");
//检查单位(执行填报的单位名称)
    String checkCompanyName = request.getParameter("checkCompanyName") == null ? ""
            : request.getParameter("checkCompanyName");
//创建时间(YYYY-MM-DD HH:MM:SS)
    String createTime =
            request.getParameter("createTime") == null ? "" : request.getParameter("createTime");
//街道（乡镇）
    String streetname =
            request.getParameter("streetname") == null ? "" : request.getParameter("streetname");
//检查单位代码
    String checkCompanyCode = request.getParameter("checkCompanyCode") == null ? ""
            : request.getParameter("checkCompanyCode");
//创建用户名
    String createUser =
            request.getParameter("createUser") == null ? "" : request.getParameter("createUser");
//表单ID
    String formId = request.getParameter("formId") == null ? "" : request.getParameter("formId");
//4位年
    String checkYear =
            request.getParameter("checkYear") == null ? "" : request.getParameter("checkYear");
//用户ID,检查人ID
    String checkUserId =
            request.getParameter("checkUserId") == null ? "" : request.getParameter("checkUserId");
//1-7周1，7周日
    String checkWeek =
            request.getParameter("checkWeek") == null ? "" : request.getParameter("checkWeek");
//任务来源
    String taskFrom =
            request.getParameter("taskFrom") == null ? "" : request.getParameter("taskFrom");
//单位名称（检查点单位名称）
    String companyName =
            request.getParameter("companyName") == null ? "" : request.getParameter("companyName");
//区县
    String dname = request.getParameter("dname") == null ? "" : request.getParameter("dname");
//市
    String cname = request.getParameter("cname") == null ? "" : request.getParameter("cname");
//8位日期YYYYMMDD
    String checkDate =
            request.getParameter("checkDate") == null ? "" : request.getParameter("checkDate");
//ID
    String checkResultId = request.getParameter("checkResultId") == null ? ""
            : request.getParameter("checkResultId");
//两位月01,02
    String checkMonth =
            request.getParameter("checkMonth") == null ? "" : request.getParameter("checkMonth");
//所属单位代码（目标单位、检查点（设备等）单位代码）
    String companyCode =
            request.getParameter("companyCode") == null ? "" : request.getParameter("companyCode");
//检查归属单位,(检查表单归属单位，冗余同表单归属相同。)
    String checkBelongCompanyCode = request.getParameter("checkBelongCompanyCode") == null ? ""
            : request.getParameter("checkBelongCompanyCode");
//检查用户名
    String checkUserName = request.getParameter("checkUserName") == null ? ""
            : request.getParameter("checkUserName");
//更新时间(YYYY-MM-DD HH:MM:SS)
    String updateTime =
            request.getParameter("updateTime") == null ? "" : request.getParameter("updateTime");
//任务ID
    String taskId = request.getParameter("taskId") == null ? "" : request.getParameter("taskId");
//状态 0未开始，1未完成，2已完成
    String checkStatus =
            request.getParameter("checkStatus") == null ? "" : request.getParameter("checkStatus");
//是否正常（0正常1异常（有隐患））
    String checkResult =
            request.getParameter("checkResult") == null ? "" : request.getParameter("checkResult");
//父代码(检查点单位父代码)
    String parentCode =
            request.getParameter("parentCode") == null ? "" : request.getParameter("parentCode");
//主表名（根据TASK_FROM 对应不同的表）
    String tableName =
            request.getParameter("tableName") == null ? "" : request.getParameter("tableName");
//省
    String pname = request.getParameter("pname") == null ? "" : request.getParameter("pname");
//所属单位ID号
    String companyId =
            request.getParameter("companyId") == null ? "" : request.getParameter("companyId");
//更新用户名
    String updateUser =
            request.getParameter("updateUser") == null ? "" : request.getParameter("updateUser");
//得分（获得分数，1位小数）
    String score = request.getParameter("score") == null ? "" : request.getParameter("score");

%>
