<%@ page language="java"  pageEncoding="UTF-8"%>

<!--关于查询action-->
 <input type="hidden" name="txtAction" value="query">

<!--关于分页的隐藏字段-->
<input type="hidden" name="txtCurPage" value="<%=pageQuery.getPageIndex()%>">
<input type="hidden" name="txtTotalPage" value="<%=pageQuery.getTotalpage()%>">

<!--关于排序的隐藏字段-->
<input type="hidden" name="orderByKey" value="<%=orderByKey%>">
<input type="hidden" name="orderByKeyPara" value="<%=orderByKeyPara%>">