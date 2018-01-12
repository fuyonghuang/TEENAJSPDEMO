<%@ page language="java" pageEncoding="UTF-8"%>
<%
					
		//设置每页显示的记录条数
		String sessPagesize = (String)(request.getSession().getAttribute("pagesize")==null ? "" : request.getSession().getAttribute("pagesize"));
		String strPageSize = (request.getParameterValues("pagesize")==null) ? "" : request.getParameterValues("pagesize")[0];
		
		int intPageSize = 20;
		try{
			if( !sessPagesize.equals("") )
				intPageSize = Integer.parseInt(sessPagesize);
			if( !strPageSize.equals("") )
				intPageSize = Integer.parseInt(strPageSize);
		}catch(Exception ex){
			System.out.println(ex.getMessage());
			intPageSize = 15;
		}
		com.rad.db.PageQuery pageQuery=new com.rad.db.PageQuery();
		pageQuery.setPageSize(intPageSize);   
		long curPage=new Long(request.getParameterValues("txtCurPage")==null?"1":request.getParameterValues("txtCurPage")[0]).longValue(); 
		if(curPage==0) curPage=1;
		pageQuery.setPageIndex(curPage);
		

	%>
	
		