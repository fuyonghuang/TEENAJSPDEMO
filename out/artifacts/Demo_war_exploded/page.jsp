<%@ page language="java"  pageEncoding="UTF-8"%>
	<script>
	function doPage(sAction){    
		if(sAction=="change"){
			document.this_form.txtCurPage.value = "1";
		}
		 if (sAction=="first")
		 		document.this_form.txtCurPage.value = "1";
     if (sAction=="previous")
        document.this_form.txtCurPage.value =parseInt(document.this_form.txtCurPage.value) - 1;
     if (sAction=="next")
        document.this_form.txtCurPage.value =parseInt(document.this_form.txtCurPage.value) +1;
     if (sAction=="last")
     		document.this_form.txtCurPage.value =document.this_form.txtTotalPage.value;
     if (sAction=="jump"){
        if (!isNumeric(window.event.srcElement.value, 4, 0)){
           alert("请输入正确页数！");
           return false;
        }
        if (parseInt(window.event.srcElement.value)==0){
           alert("请输入正确页数！");
           return false;
        }
        if (parseInt(window.event.srcElement.value)>parseInt(document.this_form.txtTotalPage.value))
        	document.this_form.txtJumpPages.value =document.this_form.txtTotalPage.value;
        else
        	document.this_form.txtCurPage.value = window.event.srcElement.value;
     }

     document.this_form.submit();
  }



	</script>
	<!--  分页显示-->
	<table>
		<tr bgcolor="">
			<td height="30" colspan="15" align="center">共<%=pageQuery.getTotalNum()%>条记录，<%=pageQuery.getTotalPage()%>页，每页<input type="text" name="pagesize" onkeypress="if(event.keyCode == 13) doPage('change')" size="3" value="<%=intPageSize%>" style="width: 40px; height: 20px; border-radius: 2px; line-height: 20px; border: 1px solid #d4d8da">行&nbsp;&nbsp;
			<% if(pageQuery.getTotalNum()>0){ %>
				<% if(pageQuery.getPageIndex()!=1){%>
					<a href="javascript:doPage(&quot;first&quot;)" style="font-size: 15px; font-weight: bold;">|&lt;&lt;</a>&nbsp;&nbsp;
					<a href="javascript:doPage(&quot;previous&quot;)" style="font-size: 15px; font-weight: bold;">&lt;</a>&nbsp;&nbsp;
				<% }%>	
				第<input type="text" name="txtJumpPages" onkeypress="if(event.keyCode == 13) doPage('jump')" size="3" value='<%=pageQuery.getPageIndex()%>' style="width: 40px; height: 20px; line-height: 20px; border-radius: 2px; border: 1px solid #d4d8da">页
				<!--<a href="javascript:doPage(&quot;jump&quot;)">跳转</a>-->
				<%if(pageQuery.getPageIndex()<pageQuery.getTotalPage()){%>
					<a href="javascript:doPage(&quot;next&quot;)" style="font-size: 14px; padding:2px 5px; color: #ffffff; background-color: #5fafe4; border-radius: 4px; text-decoration: none">&gt;</a>&nbsp;&nbsp;
					<a href="javascript:doPage(&quot;last&quot;)" style="font-size: 14px; padding:2px 5px; color: #ffffff; background-color: #5fafe4; border-radius: 4px; text-decoration: none">&gt;&gt;|</a>&nbsp;&nbsp;
				<% }%>
			<%}%>
			</td> 
		</tr>
	</table>
<!--  分页显示结束-->