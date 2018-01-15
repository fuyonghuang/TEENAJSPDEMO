<%@ tag import="net.sf.json.JSONArray" %>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@attribute name="checkContentRecord" type="com.rad.db.Record" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-2.1.1.min.js">

</script>


<div id="u0" class="">
    <div id="u0_text" class="text ">
        <p>
        <h3>检查项信息</h3></p>
    </div>
</div>

<div style="width: 100%;">

    <%
        //表单检查项信息

        int num = 1;
        while (checkContentRecord.next()) {
    %>
    <div style="margin-left: 15%;margin-top: 2%;">
        <%=checkContentRecord.getString("CONTENT_TITLE")%>
        <%=num%>.<%=checkContentRecord.getString("CONTENT_TITLE")%><%
        if (!"".equals(checkContentRecord.getString("SHOW_TYPE"))) {
            if (checkContentRecord.getString("SHOW_TYPE").equals("text")) {
    %>
        (文本填空)
        <%
            }
            if (checkContentRecord.getString("SHOW_TYPE").equals("radio")) {
        %>
        (单选)
        <%
            }
            if (checkContentRecord.getString("SHOW_TYPE").equals("checkbox")) {
        %>
        (多选)
        <%
                }
            }
        %>
    </div>
    <div style="margin-top: 1%;">
        <%
            JSONArray itemArray = JSONArray
                    .fromObject(checkContentRecord.getString("CONTENT_ITEMS"));
            String dangerValue = checkContentRecord.getString("DANGER_VALUE");
            String contentAnswer = checkContentRecord.getString("CONTENT_ANSWER");
            for (int i = 0; i < itemArray.size(); i++) {
                net.sf.json.JSONObject iteminfo = itemArray.getJSONObject(i);
                String itemNo = iteminfo.get("itemNo").toString();
        %>
        <span style="margin-left: 15%;">
					<%=(char) (65 + i) %>.
					<%=iteminfo.get("itemTitle")%>
				</span>
        <%} %></div>


    <%
            num++;
        }
    %>
</div>

