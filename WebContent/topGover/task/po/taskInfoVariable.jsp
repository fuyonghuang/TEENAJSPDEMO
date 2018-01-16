<%@ page import="com.jt.utils.DateUtils" %>
<%
    /**
     * 变量定义
     */
    String taskId = request.getParameter("taskId") == null ? "" : request.getParameter("taskId");
    //任务名称
    String taskName =
            request.getParameter("taskName") == null ? "" : request.getParameter("taskName");
    //任务类型
    String taskCategory = request.getParameter("taskCategory") == null ? ""
            : request.getParameter("taskCategory");
    //单任务/多任务
    String taskType =
            request.getParameter("taskType") == null ? "" : request.getParameter("taskType");
    //任务来源
    String taskFrom =
            request.getParameter("taskFrom") == null ? "" : request.getParameter("taskFrom");

    //任务开始时间
    String startDate =
            request.getParameter("startDate") == null ? "" : request.getParameter("startDate");

    //结束时间
    String endDate = request.getParameter("endDate") == null ? "" : request.getParameter("endDate");

    String startTime =
            request.getParameter("startTime") == null ? "" : request.getParameter("startTime");
    String endTime = request.getParameter("endTime") == null ? "" : request.getParameter("endTime");
    //工作日历
    String notHandleDay = request.getParameter("notHandleDay") == null ? ""
            : request.getParameter("notHandleDay");
    //周末限制
    String onlyWorkDay =
            request.getParameter("onlyWorkDay") == null ? "" : request.getParameter("onlyWorkDay");
    //检查频率
    String infoHandleType = request.getParameter("infoHandleType") == null ? ""
            : request.getParameter("infoHandleType");
    //发布单位
    String companyCode =
            request.getParameter("companyCode") == null ? "" : request.getParameter("companyCode");

    String companyName =
            request.getParameter("companyName") == null ? "" : request.getParameter("companyName");
    //发布人
    String releasePersion = request.getParameter("releasePersion") == null ? ""
            : request.getParameter("releasePersion");

    String releaseTime =
            request.getParameter("releaseTime") == null ? "" : request.getParameter("releaseTime");
    //检查方式0目标单位自查1检查单位抽查2以上2者',
    String checkType =
            request.getParameter("checkType") == null ? "" : request.getParameter("checkType");
    //有抽查时才有数据，抽查单位
    String checkCompanyCode = request.getParameter("checkCompanCode") == null ? ""
            : request.getParameter("checkCompanCode");

    String checkCompanyName = request.getParameter("checkCompanyName") == null ? ""
            : request.getParameter("checkCompanyName");
    //任务内容类型(0单表单1多表单。)
    String formType =
            request.getParameter("formType") == null ? "" : request.getParameter("formType");
    //任务状态 ,0待审核，1审核通过，2审核拒绝，3已发布，4已完成
    String infoStatus =
            request.getParameter("infoStatus") == null ? "0" : request.getParameter("infoStatus");
    //对象单位类型(对应单位类型中COMPANY_TYPE,可多个（依赖单位信息分类正确）。按单位类型来选择，多个逗号分隔)
    String objectCompanyType = request.getParameter("objectCompanyType") == null ? ""
            : request.getParameter("objectCompanyType");
    //对象父代码,单位类型中PARENT_CODE,按上级单位选择，多个逗号分隔
    String objectCompanyParentCode = request.getParameter("objectCompanyParentCode") == null ? ""
            : request.getParameter("objectCompanyParentCode");
    //指定单位,0所有下级，1本单位，2本单位及下级，3指定单位，9为所有 (注册类型为0,1的只能是0,1,2、3)
    String objectCompany = request.getParameter("objectCompany") == null ? ""
            : request.getParameter("objectCompany");
    //指定用户 0不指定1，指定人
    String objectUser =
            request.getParameter("objectUser") == null ? "" : request.getParameter("objectUser");
    //总指定对象数
    String totalObjectNum = request.getParameter("totalObjectNum") == null ? ""
            : request.getParameter("totalObjectNum");

    String applyPerson =
            request.getParameter("applyPerson") == null ? "" : request.getParameter("applyPerson");
    String checkPerson =
            request.getParameter("checkPerson") == null ? "" : request.getParameter("checkPerson");
    String checkDesc =
            request.getParameter("checkDesc") == null ? "" : request.getParameter("checkDesc");
    String checkTime = DateUtils.formatDateToString(new Date());
    String createTime = DateUtils.formatDateToString(new Date());
    String createUser = "";
    String updateTime = DateUtils.formatDateToString(new Date());

    String updateUser =
            request.getParameter("updateUser") == null ? "" : request.getParameter("updateUser");
    //流程扭转信息
    String procFlowInfo = request.getParameter("procFlowInfo") == null ? ""
            : request.getParameter("procFlowInfo");
    //备注
    String checkRemark =
            request.getParameter("checkRemark") == null ? "" : request.getParameter("checkRemark");

    //获取表单数据
    String formIdStr =
            request.getParameter("formIdStr") == null ? "" : request.getParameter("formIdStr");

    String isApply =
            request.getParameter("isApply") == null ? "0" : request.getParameter("isApply");
    //指定人
    String apportionUserIds = request.getParameter("apportionUserIds") == null ? ""
            : request.getParameter("apportionUserIds");
    //指定人name
    String apportionUserNames = request.getParameter("apportionUserNames") == null ? ""
            : request.getParameter("apportionUserNames");
    //选择的表单id
    String formIds = request.getParameter("formIds") == null ? ""
            : request.getParameter("formIds");
    String userIdStr =
            request.getParameter("userIdStr") == null ? "" : request.getParameter("userIdStr");
    String action =
            request.getParameter("txtAction") == null ? "query" : request.getParameter("txtAction");
%>