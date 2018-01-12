<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@page import="org.apache.poi.hssf.util.*"%>
<%@ include file="/import.jsp"%>

<%
   String rightCode="export";
%>

<%    
	  String currentPosition = "系统管理 >导出文件"; 
      String viewPage="expFile";       
      String action=request.getParameter("txtAction")==null?"":request.getParameter("txtAction");
      String outType=request.getParameter("outType")==null?"":request.getParameter("outType");
      String idxList="";
      PageQuery pageQuery=new PageQuery();
      int pageSize=100;
		 int curPage=1;
	
		 pageQuery.setPageSize(pageSize);
		 pageQuery.setPageIndex(curPage);
      if(outType.equals("selected"))
      {
          idxList=request.getParameter("idxList")==null?"":request.getParameter("idxList");
		      idxList=idxList.replaceAll(";","','");
		      idxList="'"+idxList+"'";
      }
      
      
      String sPage=request.getParameter("sPage")==null?"":request.getParameter("sPage");
      String[] colNames="".split(",");
      String[] colFields="".split(",");
      String[] colWidths="".split(",");
      String strSql="";
      SqlManager sqlManager=new SqlManager(); 
      java.util.Vector vPara=new Vector(); 
      com.rad.db.Record record=new Record();
      Record tmpRecord=null;
    if(sPage.equals("userInfo"))
      {
           colNames="姓名,手机号".split(",");
	       colFields="userName,userTel".split(",");
	       colWidths="10%,10%".split(",");
	       if(outType.equals("selected"))
	       {
	             strSql="select * from userInfo where userId in("+idxList+") order by userId asc ";
	             vPara=null;
	       }else if(outType.equals("all")) 
	       {
	             strSql="select * from userInfo order by userId ";
	       }else if(outType.equals("query")) 
	       {
              strSql=(String)request.getSession().getAttribute("expExcel_sql");
              vPara=(Vector)request.getSession().getAttribute("expExcel_para");
              if(strSql==null||strSql.equals(""))
              {
                 out.println("<script>alert('导出查询必须先点击查询按钮后才能导出！');window.close();</script>");
    	         out.close();
              }
              request.getSession().setAttribute("expExcel_sql",null);
              request.getSession().setAttribute("expExcel_para",null);
	       }         
    }
	else{
     	   out.println("<script>alert('该表未实现导出，请联系管理员!');window.close();</script>");
     	   out.close();
    }
   	
   	if(strSql.equals(""))
   	{
   	   out.println("<script>alert('未匹配到相关数据，请联系系统管理员!');window.close();</script>");
   	   out.close();
   	}
   	
   	
   	
   	
   	
   	
   	
   	
    org.apache.poi.hssf.usermodel.HSSFWorkbook workBook=new org.apache.poi.hssf.usermodel.HSSFWorkbook();
	org.apache.poi.hssf.usermodel.HSSFSheet sheet=workBook.createSheet("sheet1"); 
		 
				 // 创建单元格样式
	org.apache.poi.ss.usermodel.CellStyle style = workBook.createCellStyle(); 
    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);  
    style.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);  
    style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  
     // 设置边框  
    style.setBottomBorderColor(HSSFColor.RED.index);  
    style.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
    style.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
    style.setBorderRight(HSSFCellStyle.BORDER_THIN);  
    style.setBorderTop(HSSFCellStyle.BORDER_THIN); 
    style.setWrapText(true);// 自动换行  
	org.apache.poi.hssf.usermodel.HSSFRow row=null;
	org.apache.poi.hssf.usermodel.HSSFCell cell=null;
			
	for(int i=0;i<colNames.length;i++)
    { 
        sheet.setColumnWidth(i, 5000);
    }
	row=sheet.createRow(0); 
	row.setHeight((short) 500);// 设定行的高度
	for(int i=0;i<colNames.length;i++)
	{
	    cell=row.createCell(i); 
	    cell.setCellStyle(style); 
	    cell.setCellValue(colNames[i]);
	}
	int iRow=1;
     	
   	while(true)
	{
	    record = sqlManager.getRecords(strSql, vPara,pageQuery);
	    while(record.next())
	    {   			         
	       row=sheet.createRow(iRow);  
	       for(int i=0;i<colFields.length;i++)
		   {
			    cell=row.createCell(i); 
			    //导出数据处理，比如0,1换为未处理与已处理
				 /*    if(sPage.equals("userInfo")&&i==(colFields.length-1))
			    {
			        String statuslocal=record.getString("status");
			        String statusName="";
			        if(statuslocal.equals("0"))statusName="不可用";
			        else if(statuslocal.equals("1"))statusName="可用";
			        cell.setCellValue(statusName);
			    }else{
			    	cell.setCellValue(record.getString(colFields[i]));
             	} */
             	//直接放数据，不处理
			    cell.setCellValue(record.getString(colFields[i]));
		   }
	       iRow++;  
	    }
	    if(pageQuery.getPageIndex()<pageQuery.getTotalPage())
	    {
	       curPage++;
	       pageQuery.setPageIndex(curPage);
	    }else{
	    	  break;
	    }
	    
	    
	 }
	response.setContentType("application/vnd.ms-excel");    
    response.setHeader("Content-disposition", "attachment;filename=exp1.xls");    
    java.io.OutputStream ouputStream = response.getOutputStream();    
    workBook.write(ouputStream);    
    ouputStream.flush();    
    ouputStream.close(); 
	     	  
	     
     
	
%>


