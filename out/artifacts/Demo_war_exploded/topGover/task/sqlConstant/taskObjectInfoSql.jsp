<%!
    public final static String QUERY_TASKOBJECTINFO = "SELECT t.* FROM T_TASK_OBJECT_INFO t where 1=1 ";

    public final static String OBJECTINFO_AND_TASKINFO_JOIN_QUERY = "SELECT t.*,t2.TASK_NAME,t2.START_DATE, t2.END_DATE," +
            "  t2.START_TIME, t2.END_TIME,t2.RELEASE_TIME,t2.COMPANY_NAME,t2.COMPANY_CODE," +
            "  t2.CHECK_TYPE,t2.INFO_HANDLE_TYPE,t2.FORM_TYPE FROM T_TASK_OBJECT_INFO t LEFT JOIN " +
            "T_TASK_INFO T2 ON T.TASK_ID = T2.TASK_ID where 1=1 ";
%>
