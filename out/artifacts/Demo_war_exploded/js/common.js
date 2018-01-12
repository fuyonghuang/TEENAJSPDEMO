

function common_delete()
	{
  	if(confirm("确定删除吗？")){
  		return true;
  	}
  	else return false;
  }


function common_status(val)
	{
  	if(confirm("确定"+val+"吗？")){
  		return true;
  	}
  	else return false;
  }

function common_submit()
{
	if(confirm("确定提交吗？")){
		return true;
	}
	else return false;
}
  
  /*--------------------验证身份证是否合法----------------------------*/
	function isdate(intYear,intMonth,intDay) { 
	  if(isNaN(intYear)||isNaN(intMonth)||isNaN(intDay)) return false;     
	  if(intMonth>12||intMonth<1) return false;  
	  if ( intDay<1||intDay>31)return false;  
	  if((intMonth==4||intMonth==6||intMonth==9||intMonth==11)&&(intDay>30)) return false;  
	  if(intMonth==2) {  
	     if(intDay>29) return false;    
	     if((((intYear%100==0)&&(intYear%400!=0))||(intYear%4!=0))&&(intDay>28))return false;  
	    }  
	  return true;  
	}
  
  //检查身份证是否是正确格式
	function isValidIDCard(txtField) {
			var pattern;
		
			if (txtField.value.length==15){
					pattern= /^\d{15}$/;					//正则表达式,15位且全是数字
					if (!pattern.test(txtField.value)){
						selectTextField(txtField,"15位身份证必须全部为数字！");
					  return false;
					}
					if (!isdate("19"+txtField.value.substring(6,8),txtField.value.substring(8,10),txtField.value.substring(10,12))){
						selectTextField(txtField,"身份证的出生日期部分必须为合法的日期格式！");
						return false;
					}
			}else if (txtField.value.length==18){
					pattern= /^d{17}(d|x|X)$/;//正则表达式,18位且前17位全是数字，最后一位只能数字,x,X
					if (!pattern.test(txtField.value)==null){
						selectTextField(txtField,"身份证格式不合法！18位身份证中前17位必须为数字，最后一位可以为'数字','x','X'");
					 	return false;
					}
					if (!isdate(txtField.value.substring(6,10),txtField.value.substring(10,12),txtField.value.substring(12,14))){
						selectTextField(txtField,"身份证格式不合法！身份证的出生日期部分必须为合法的日期格式！");
						return false;
					}
					var strJiaoYan  =["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"];
					var intQuan =[7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1];
					var intTemp=0;
					for(i = 0; i < txtField.value.length - 1; i++)
					intTemp +=  txtField.value.substring(i, i + 1)  * intQuan[i];  
					intTemp %= 11;
					if(txtField.value.substring(txtField.value.length-1,txtField.value.length).toUpperCase()!=strJiaoYan[intTemp]){
						selectTextField(txtField,"身份证格式不合法！最后一位不合法！");
						return false;
					}
			}else{
			
					selectTextField(txtField,"身份证长度必须为15或18！");
					return false;
			}
			return true;   
	}
/*-----------------------------验证身份证结束-------------------------*/
  
  
  


//使指定的控件不可用
	function disabledControl(vState){
		if(vState == "view"){
	 		for(var i=0; i<document.forms[0].elements.length; i++){
	 			document.forms[0].elements[i].disabled = true;
	 		}
	 		
	 		if( document.getElementById("docPathDiv") != undefined){
		 		for(var j=0;j<docPathDiv.all.length;j++){	   
		 			docPathDiv.children(j).disabled = false;
	   		}
	   	}
	   	
		}
	}
	
	function resetEmpty()
	{
		 for(var i=0; i<document.forms[0].elements.length; i++){
		 	  if( document.forms[0].elements[i].type!='button'&&document.forms[0].elements[i].type!='hidden')
		 	      document.forms[0].elements[i].value='';
		} 
	}
  
  //打开一个新的窗口
	function openNewWindow(sURL) {
		/*var newValue;
		var str = "left=0,screenX=0,top=0,screenY=0,scrollbars=yes";//fullscreen=yes只对IE有效！ 
　　 if (window.screen) {
　　	var ah = screen.availHeight - 100;
　　	var aw = screen.availWidth - 10;
　　	str += ",height=" + ah;
　　	str += ",innerHeight=" + ah;
　　	str += ",width=" + aw;
　　	str += ",innerWidth=" + aw;
　　 } else {
　　	str += ",resizable"; // 对于不支持screen属性的浏览器，可以手工进行最大化。 manually
　　 }
		newValue=window.open(sURL,"",str);*/
		//window.open(sURL,"","fullscreen=yes,scrollbars=yes");
		location.href=sURL;
 }
 	//弹出错误信息，让字段获得焦点并选中文本内容
	function selectTextField(txtField,msg){
 	 		alert(msg);
 	 		txtField.select();
 	 		txtField.focus();
 	}
 //验证字段是否为空
	function isEmpty(txtField,name){		 
	 		if(isEmptyString(txtField.value)){	 			
					selectTextField(txtField,"'"+name+"'不能为空");
					return true;
	 		}
	 	  return false;
	}
	
	//验证字段是否为合法的日期类型
	function isValidDate(txtField,name){	
 		if(!isEmptyString(txtField.value)){ 			 
 				if(!isDate(txtField.value) && !isSpecialDate(txtField.value)){
						selectTextField(txtField,"'"+name+"'为非法的日期格式,正确日期为:yyyy-mm-dd/yyyymmdd");
						return false;
 				}
 		}
 		return true;
	}	
	
	function isSpecialDate(sDate){
		var reg = /(19|20\d{2})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])/;
		return  reg.test(sDate);
	}
	
	function isValidNum(txtField,name){
		if(!isEmptyString(txtField.value)){
			 if(!isInteger(txtField.value))
			 {
			 	    selectTextField(txtField,"'"+name+"'为非法的数字格式");
					return false;
			 }
	  }
	  return true;
	}
	
	function isSelected(sCheckname){		//判断用户是否至少选中了一行
	  var num=0;
	  for (var i = 0 ; i < document.all.length; i++){
			if (document.all.item(i).name==sCheckname && document.all.item(i).checked)
				return true;
	  }
	  alert("至少要选择一行");
	  return false;
	}
	
	function isMoreThanOne(sCheckname){	//判断复选框的个数是否多于一个
		var num=0;
	  for (var i = 0 ; i < document.all.length; i++){
	       if (document.all.item(i).name==sCheckname) num=num+1;
	       if(num>1) return true;
	  }
	  return false;
	}
	
	//选择全部记录
	function selectAll(oCheckAll,sCheckList){
		var checkboxList = document.getElementsByName(sCheckList);
		if(checkboxList){
			for(var i=0; i<checkboxList.length; i++)
				checkboxList[i].checked = oCheckAll.checked;
		}
	}
	
	function changeColor(oCheck){		
		if(oCheck.checked)
			oCheck.parentElement.parentElement.bgColor="#eeeeee";
		else
			oCheck.parentElement.parentElement.bgColor="#ffffff";
	}
	
	/*-------------------------通用的选择功能-----------------------*/
  function selectChoice(radioButton){	//获取选中的redio的value值
  		result = radioButton.value;
  }
	
	//删除所有表格行
	function delRows(sTableID) {
			var oTable = document.getElementById(sTableID);
		  for(var i=oTable.rows.length-1; i>=1; i--){
				 oTable.deleteRow(i);
		  }
	}
	
	//删除指定id的行
	function delRow(rowId) {
	
		var oRow = document.getElementById(rowId);			//找到要删除的行对象
		
		oRow.parentNode.removeChild(oRow);							//删除指定的节点
	}
	
	//打开窗口需要手动调用callBackFunction 函数，多个选择窗口可通过callFunctionName进行跳转。
	function doSelect(checkName)
	{
		 result="";
	   
	   var j=0;
		if( isSelected(checkName) ){
   		var oOpener = window.opener;
   		if( oOpener && isMoreThanOne(checkName) ){
   			for(var i=0; i<this_form[checkName].length; i++){
   				if( this_form[checkName][i].checked ){
   					if(j==0)
   					  result=this_form[checkName][i].value;
   					else 
   						 result+=","+this_form[checkName][i].value;
   				 j++;
   				}
   			}
   		}else{
   			  result=this_form[checkName].value;
   			  
   		}
   		
   		if(oOpener)
   		{
   			result="["+result+"]";   	
   			try{
   			  result=eval("("+result+")"); 
   			  window.opener.callBackFunction(this_form.callFunctionName.value,result);
   		  }catch(e){alert("无法组成json数据:"+e.message)}   				
   			
   		}   		
      	window.close();
		}
	}
	
	//打开窗口需要手动调用callBackFunction 函数，多个选择窗口可通过callFunctionName进行跳转。
	function getSelect(checkName)
	{
		 var result="";
	  
	   var j=0;
	   var rowName="";
 		if(isMoreThanOne(checkName) ){ 		
 			for(var i=0; i<this_form[checkName].length; i++){
 				if( this_form[checkName][i].checked ){
 				rowName=checkName+this_form[checkName][i].value+"_RowValue"; 				
 					if(j==0)
 					   result=this_form[rowName].value;
 					else 
 						 result+=","+this_form[rowName].value;
 				 j++;
 				}
 			}
 		}else{ 		
 			  
 			  if(this_form[checkName]&&this_form[checkName].checked)
 			  {
 			  	 rowName=checkName+this_form[checkName].value+"_RowValue";
 			     result=this_form[rowName].value;
 			  }
 			  
 		}
 		result="["+result+"]";
   	return result;
   		
	 
 }
	
	//如果有超级链接且需要主键，必须包含一个IDX列.如果没有IDX列，则需变换一个字段为IDX
	function setTableList(sTableID,columnNames,jsObject,ctrlName,colTypes,colDefaultValues,isClear)//
	{
		
		 if(jsObject==null||jsObject.length==0) return;
		
	  if( isClear ) delRows(sTableID);
	  var newRow,newCell;
	  var oTable = document.getElementById(sTableID);
	  var fieldNames=columnNames.split(",");
	  var field="";
	  var rowValues="";
	  var strSplit=",";
	  
	  for(var i=0;i<jsObject.length;i++){  //begin for jsobject	  	  
	  	  
	  	 rowValues=jsObject[i].toJSONString();
	  	
	  	  var idx=0;//插入时取最后一个id值，以方便删除,避免名称重复
	  	  if(oTable.rows.length>1)
	  	  {
	  	  	var lastRows=oTable.rows[oTable.rows.length-1];
	  	  	var lastRowId=lastRows.id;	  	  
	  	   	idx=parseInt(lastRowId.substring(ctrlName.length+5))+10;
	  	   
	  	  }
	  	  idx=idx+1;
	  	  newRow = oTable.insertRow(oTable.rows.length);
	  	  newRow.setAttribute("id",(ctrlName+"rowId"+idx));
	  	 
	  	  
	  	  newCell = newRow.insertCell(0);//第一个始终是checkbox,数据库通过这个隐藏值可以不组装直接取值保存
	  	  newCell.innerHTML = "<input type='checkbox' id='"+ctrlName+"' name='"+ctrlName+"' checked value='"+idx+"'>"+
	  	                      "<input type='hidden' id='"+ctrlName+idx+"_RowValue' name='"+ctrlName+idx+"_RowValue' value='"+rowValues+"'>";
	  	  var colHtml="";
	  	  var m=0;
	  	  for(var j=0;j<fieldNames.length;j++)//从第二列开始插入数据 begin for insert cell
	  	  {
	  	  	  field=fieldNames[j].toUpperCase();
	  	  	  
	  	  	  
	  	  	  if(colTypes&&colTypes.length>0)//check colTypes
	  	  	  {
	  	  	  	 if(colTypes[j]=="hidden")
	  	  	  	 {
	  	  	  	 	   if(jsObject[i][field])
	  	  	  	 	   {
	  	  	  	 	   	  colHtml+="<input type='hidden'  id='"+ctrlName+idx+"_"+fieldNames[j]+"' name='"+ctrlName+idx+"_"+fieldNames[j]+"' value='"+jsObject[i][field]+"'>";
	  	  	  	 	   }
	  	  	  	 	   else if(colDefaultValues&&colDefaultValues.length>0)
	  	  	  	 	   {		  	  	  	 	   	
	  	  	  	 	   	   colHtml+="<input type='hidden' id='"+ctrlName+idx+"_"+fieldNames[j]+"' name='"+ctrlName+idx+"_"+fieldNames[j]+"' value='"+colDefaultValues[j]+"'>" 
	  	  	  	 	   }
	  	  	  	 	   var newInput = document.createElement("input"); 
	  	  	  	 	   newInput.type="hidden";
	  	  	  	 	   newInput.name=ctrlName+idx+"_"+fieldNames[j];
	  	  	  	 	   newInput.id=ctrlName+idx+"_"+fieldNames[j];
	  	  	  	 	   if(jsObject[i][field])
	  	  	  	 	   {
	  	  	  	 	   		newInput.value=jsObject[i][field];
	  	  	  	 	   }else if(colDefaultValues&&colDefaultValues.length>0)
	  	  	  	 	   {	
	  	  	  	 	   	   newInput.value=colDefaultValues[j];
	  	  	  	 	   }
	  	  	  	 	   newRow.appendChild(newInput);
	  	  	  	 	   colHtml="";
	  	  	  	 	   continue;
	  	  	  	 }else if(colTypes[j]=="link")
	  	  	  	 {
	  	  	  	 	   if(jsObject[i][field])
	  	  	  	 	   {
	  	  	  	 	   	  colHtml+="<a target='_blank' href='"+colDefaultValues[j]+"?urlType=1&idxList="+jsObject[i].IDX+"&idx="+jsObject[i].IDX+"&txtAction=view'>"+jsObject[i][field]+"&nbsp;&nbsp;&nbsp;&nbsp;</a>&nbsp;"+
	  	  	  	 	   	            "<input type='hidden' id='"+ctrlName+idx+"_"+fieldNames[j]+"' name='"+ctrlName+idx+"_"+fieldNames[j]+"' value='"+jsObject[i][field]+"'>";
	  	  	  	 	   }
	  	  	  	 	   else if(colDefaultValues&&colDefaultValues.length>0)
	  	  	  	 	   {		  	  	  	 	   	
	  	  	  	 	   	   colHtml+=colDefaultValues[j]+"&nbsp;<input type='hidden' id='"+ctrlName+idx+"_"+fieldNames[j]+"' name='"+ctrlName+idx+"_"+fieldNames[j]+"' value='"+colDefaultValues[j]+"'>" 
	  	  	  	 	   }
	  	  	  	 } else if(colTypes[j]=="text")
	  	  	  	 {
	  	  	  	 	   if(jsObject[i][field])
	  	  	  	 	   {
	  	  	  	 	   	  colHtml+="<input type='text' size='12' id='"+ctrlName+idx+"_"+fieldNames[j]+"' name='"+ctrlName+idx+"_"+fieldNames[j]+"' value='"+jsObject[i][field]+"'>";
	  	  	  	 	   }
	  	  	  	 	   else if(colDefaultValues&&colDefaultValues.length>0)
	  	  	  	 	   {
	  	  	  	 	   	  colHtml+="<input type='text' size='12' id='"+ctrlName+idx+"_"+fieldNames[j]+"' name='"+ctrlName+idx+"_"+fieldNames[j]+"' value='"+colDefaultValues[j]+"'>";	  	  	  	 	   	
	  	  	  	 	   	  
	  	  	  	 	   }
	  	  	  	 	   
	  	  	  	 }else if(colTypes[j]=="select")
	  	  	  	 {
	  	  	  	 	  
	  	  	  	 	   if(colDefaultValues&&colDefaultValues.length>0)
	  	  	  	 	   {
	  	  	  	 	       colHtml+="<select id='"+ctrlName+idx+"_"+fieldNames[j]+"' name='"+ctrlName+idx+"_"+fieldNames[j]+"'>";
	  	  	  	 	      
	  	  	  	 	       var colSelectValues=colDefaultValues[j].split(",");
	  	  	  	 	       for(var p=0;colSelectValues&&p<colSelectValues.length;p++)
	  	  	  	 	       {
	  	  	  	 	       	  if((jsObject[i][field])&&(jsObject[i][field]==colSelectValues[p]))
	  	  	  	 	       	  {
	  	  	  	 	             colHtml+="<option selected value='"+colSelectValues[p]+"'>"+colSelectValues[p]+"</option>";
	  	  	  	 	          }else
	  	  	  	 	          	  colHtml+="<option value='"+colSelectValues[p]+"'>"+colSelectValues[p]+"</option>";
	  	  	  	 	       }
	  	  	  	 	       colHtml+="</select>";
	  	  	  	 	    }
	  	  	  	 	 
	  	  	  	 }else if(colTypes[j]=="delete")
	  	  	  	 {
	  	  	  	 	  colHtml+="<input type='button' class='button' value='删除' onclick='delRow(\""+newRow.id+"\")'>";
	  	  	  	 	  
	  	  	  	 } 
	  	  	  	  else{
	  	  	  	 	   if(jsObject[i][field])
	  	  	  	 	   {
	  	  	  	 	   	  colHtml+=jsObject[i][field]+"&nbsp;<input type='hidden' id='"+ctrlName+idx+"_"+fieldNames[j]+"' name='"+ctrlName+idx+"_"+fieldNames[j]+"' value='"+jsObject[i][field]+"'>";
	  	  	  	 	   }
	  	  	  	 	   else if(colDefaultValues&&colDefaultValues.length>0)
	  	  	  	 	   {		  	  	  	 	   	
	  	  	  	 	   	   colHtml+=colDefaultValues[j]+"<input type='hidden' id='"+ctrlName+idx+"_"+fieldNames[j]+"' name='"+ctrlName+idx+"_"+fieldNames[j]+"' value='"+colDefaultValues[j]+"'>" 
	  	  	  	 	   }
	  	  	  	 	}//end check colTypes
	  	  	  	 	
	  	  	  }else{
	  	  	  	     if(jsObject[i][field])
	  	  	  	 	   {
	  	  	  	 	   	  colHtml+=jsObject[i][field]+"<input type='hidden' id='"+ctrlName+idx+"_"+fieldNames[j]+"' name='"+ctrlName+idx+"_"+fieldNames[j]+"' value='"+jsObject[i][field]+"'>";
	  	  	  	 	   }else
	  	  	  	 	   	  colHtml+="&nbsp;";
	  	  	  	 	   
	  	  	  	   
	  	  	  	}
	  	  	  	m++;
	  	  	  newCell = newRow.insertCell(m);
	  	  	  newCell.innerHTML =	colHtml;
	  	  	 
	  	  	  colHtml="";
	  	  	  
	  	  	  
	  	  	 
	  	  }//end for insert cell
	  	
	  	
	  	  
	  } //end  for jsobject
	  
	  
	  
	}
	
	  


function setOptionHour(sObject,selectedValue)
{
	 var obj;	
	 var option; 
	 var oText,oValue;
	 if(selectedValue==null||selectedValue=='')
	   selectedValue=0;
	 for(var i=0;i<24;i++)
	 {
	 	  oValue=i;
	 	  if(i<10)
	 	    oText="0"+i;
	 	  else
	 	  	oText=i;
	 	  option=new Option(oText,oValue);
	 	  if(selectedValue==oValue)
	 	  {
	 	    option.selected=true;
	 	  }
	 	  sObject.options.add(option);
	 	  
	 }
} 

function setOptionMinute(sObject,selectedValue)
{
	 var obj;	
	 var option; 
	 var oText,oValue
	 if(selectedValue==null||selectedValue=='')
	   selectedValue=0;
	 for(var i=0;i<60;i++)
	 {
	 	  oValue=i;
	 	  if(i<10)
	 	    oText="0"+i;
	 	  else
	 	  	oText=i;
	 	  option=new Option(oText,oValue);
	 	  if(selectedValue==oValue)
	 	  {
	 	    option.selected=true;
	 	  }
	 	  sObject.options.add(option);
	 	  
	 }
} 


   function createXMLHttpRequest()
    {
    	 var xmlHttp;
        if(window.XMLHttpRequest)
        {
            xmlHttp=new XMLHttpRequest();

            if(xmlHttp.overrideMimeType)
                {
                    xmlHttp.overrideMimeType("text/xml");
                }
        }
        else if(window.ActiveXObject)
        {
            try
            {
                xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");   
            }
            catch(e)
            {
                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");   
            }
        }
        if(!xmlHttp)
        {
            window.alert("你的浏览器不支持创建XMLhttpRequest对象");
        }
        return xmlHttp;
    }
    
    
    function trim(str)
    {
    	  return str.replace(/(^\s*)|(\s*$)/g, "");

    }
    
    	//按回车提交表单
	function submitWhenKeypress(){
		var oForm = document.forms[0];
		if(oForm){
			var count = document.forms[0].elements.length;
			
			for(var i=0; i<count; i++){
				if(oForm.elements[i].type == "text"){
					oForm.elements[i].onkeypress = function(){
						if(event.keyCode == 13){
							if(this.name == "txtJumpPages"){					//如果文本框的值是"跳转页"
								doPage("jump");
							}
							else if(this.name == "pagesize"){				//如果文本框的值是"每页的记录条数"
								var pagesizeArray = document.getElementsByName("pagesize");
								for(var i=0; pagesizeArray&&i<pagesizeArray.length; i++){
									pagesizeArray[i].value = this.value;
								}
								oForm.submit();
							}
							else																		//如果文本框的值是"查询项"
								oForm.submit();
						}
					}
				}
			}
		}
	}
	
	
	function gridclickcheckhead() //表头按下
  {
  	
    for (var i = 0 ; i < document.all.length; i++)
    {
    	if (document.all.item(i).name=="checkbody")
       {
       	
    		document.all.item(i).checked = document.all.item("checkhead").checked;
          
       }
    }
 }
 function gridIsSelected()
 {
    for (var i = 0 ; i < document.all.length; i++)
    {
       if (document.all.item(i).name=="checkbody")
       {
           if(document.all.item(i).checked)
           {
                  return true;
           }
       }        
    }
    alert("至少要选择一行");
    return false
 }
 
 	//判断是否至少选中一项
	function isChecked(sCheckboxName){
		
		var checkboxList = document.getElementsByName(sCheckboxName);
		for(var i=0; checkboxList&&i<checkboxList.length; i++)
			if(checkboxList[i].checked)
				return true;
		return false;
	}
 
 //把选中的记录的idx拼接起来，之间用";"进行分隔
	function getIdxList(sCheckboxId){
		var result = "";
		var checkboxList = document.getElementsByName(sCheckboxId);
		
		var j=0;
		for(var i=0; checkboxList&&i<checkboxList.length; i++){
			if(checkboxList[i].checked){
				if(result=="")
				   result = checkboxList[i].value;
				else
					 result +=";"+ checkboxList[i].value;
				
			}
		}
		return result;
	}
 
 
 //function list
 
 //查看选中的记录
	function doView(sPage){
		
		if(isChecked("ckIdx")){
			var idxList = getIdxList("ckIdx");
			var specialParam = "";
			openNewWindow(sPage+".jsp?txtAction=view&index=0&idxList="+idxList);
		}else
			alert("至少选中一项.");
	}	
	 //查看选中的记录
	function doAdd(sPage){
	 	 openNewWindow(sPage+".jsp?txtAction=insert");
	}
	
	 //查看选中的记录
	function doModify(sPage){
		if(isChecked("ckIdx")){
			var idxList = getIdxList("ckIdx");
			var specialParam = "";
			openNewWindow(sPage+".jsp?txtAction=update&index=0&idxList="+idxList);
		}else
			alert("至少选中一项.");	 	
	}
	
	 //查看选中的记录
function doSubmit(sPage) {
	if (isChecked("ckIdx")) {
		if (common_submit()) {
			var idxList = getIdxList("ckIdx");
			this_form.action = sPage + "Save.jsp?txtAction=submit&idxList="+idxList;
			this_form.submit();
		}
	} else
		alert("至少选中一项.");

}

// 查看选中的记录
function doDelete(sPage) {
	if (isChecked("ckIdx")) {
		if (common_delete()) {
			var idxList = getIdxList("ckIdx");
			this_form.action = sPage + "Save.jsp?txtAction=delete&idxList="+idxList;

			this_form.submit();
		}
	} else
		alert("至少选中一项.");

}
	
	// 查看选中的记录
	function doHistory(sPage){
		 if(isChecked("ckIdx")){
			var idxList = getIdxList("ckIdx");
			var specialParam = "";
			 openNewWindow("../historyQuery.jsp?txtAction=history&idxList="+idxList+"&sPage="+sPage);
		}else
			alert("至少选中一项.");	 	
	 	
	}
	
	//查看选中的记录
	function doOutput(sPage,outType){
		
		 if(outType=='selected'){
			 	if(isChecked("ckIdx"))
			 	{
					 var idxList = getIdxList("ckIdx");
					 openNewWindow("expExcel.jsp?txtAction=exp&idxList="+idxList+"&sPage="+sPage+"&outType="+outType);
				}else{
				   alert("至少选中一项.");
				   return;
				}
		}else{
			  openNewWindow("expExcel.jsp?txtAction=exp&sPage="+sPage+"&outType="+outType);
		 }	 	
	 	
	}
	
	
		//根据指定字段进行排序
	function sortByKey(param){
		var orderByKey=this_form.orderByKey.value;
		if(orderByKey!=null) orderByKey=orderByKey.toLowerCase();
		param=param.toLowerCase();
		
		if(orderByKey.indexOf(param)==-1)
		  orderByKey=param+" asc ";
		else if(orderByKey.indexOf("desc")==-1)
			 orderByKey=param+" desc ";
	  else orderByKey=param+" asc ";
	  
		this_form.orderByKey.value=orderByKey;
		this_form.orderByKeyPara.value=param;
			
		if(this_form.txtCurPage)
			  this_form.txtCurPage.value=1;
			this_form.submit();
	}
	
	//输入界面打印按钮
	function printForm(){
		 document.printForm.printContent.value=document.documentElement.innerHTML;
		 document.printForm.submit();
	}
	
	String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {  
        if (!RegExp.prototype.isPrototypeOf(reallyDo)) {  
            return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);  
        } else {  
            return this.replace(reallyDo, replaceWith);  
        }  
    }
    
   
   function setOrderByImg(param,orderByKey,strRoot)
   {
   	   
   	    if(param==null||param==""||orderByKey==null||orderByKey=="") return ;
				 orderByKey=orderByKey.toLowerCase();
				 param=param.toLowerCase();
				 if((","+orderByKey+" ").indexOf(","+param+" ")==-1) return ;
				 var obj=document.getElementById("sort_"+param);
				 if(obj&&orderByKey.indexOf("desc")!=-1){
					 obj.innerHTML=obj.innerHTML+"<img align='middle' style='vertical-align:middle' src='"+ strRoot+"/images/desc.gif'>";
				 	}else if(obj){
				 		obj.innerHTML=obj.innerHTML+"<img align='middle'  style='vertical-align:middle' src='"+ strRoot+"/images/asc.gif'>"; 	
				 	}
				 return ;
   }
	
   
   
   /**
    * 判断正整数
    * @param txtField
    * @param name
    * @returns {Boolean}
    */
   function isPositiveInteger1(txtField, name){
	   if(isEmptyString(txtField.value)){	 
			selectTextField(txtField,"'"+name+"'不能为空");
			return false;
	   }
	   var tt=/^\d+$/g;
	   if(tt.test(txtField.value)){
	   	   if(parseInt(txtField.value)<=0)
	   	   {
	   	   	  selectTextField(txtField,"'"+name+"'必须大00"); 
	   	   	  return false;
	   	   }else
	   	     return true;
	   }else{
		    selectTextField(txtField,"'"+name+"'为非法的数字格式");
			return false;
	   }
	   
   }
   
   /**
    * 判断年份
    * */
   function isYear(txtField, name){
	   if(isEmptyString(txtField.value)){	 
			selectTextField(txtField,"'"+name+"'不能为空");
			return false;
	   }
	   var tt=/^[1-9]\d{0,3}$/;
	   if(tt.test(txtField.value)){
			return true;
	   }else{
		    selectTextField(txtField,"'"+name+"'为非法年份");
			return false;
	   }
   }
   
  
   /**
    * 判断手机号码
    * @param txtField
    * @param name
    * @returns {Boolean}
    */
   function isMobile(txtField, name) {
	   if(isEmptyString(txtField.value)){	 
			selectTextField(txtField,"'"+name+"'不能为空");
			return false;
	   }
	   var reQQ = /^[1]\d{10}$/;
	   if (reQQ.test(txtField.value)){//输入正确
		   return true;
	   }else{
		    selectTextField(txtField,"'"+name+"'为非法的手机号码");
		   return false;
	   }
	   
   	}
   
   /**
    * 判断姓名
    */
   function isName(txtField, name)
   {
	   var inputName=txtField.value;
	   if(isEmptyString(inputName)){	 
			selectTextField(txtField,"'"+name+"'不能为空");
			return false;
	   }
       var CheckTestName=/((^[\u4E00-\u9FA5]{2,5}$)|(^[a-zA-Z]+[\s\.]?([a-zA-Z]+[\s\.]?){0,4}[a-zA-Z]$))/
       inputName=inputName.replace(/^\s+/g,"");
       inputName=inputName.replace(/\s+$/g,"");
       if(inputName.length!=0)
       {
           if(!CheckTestName.test(inputName))
           {
        	   selectTextField(txtField,"'"+name+"'错误:汉字2-5个英文2-30个!");
        	   return false;
           }
          return true;
       }
   }
   
   /**
    * 判断年龄
    * */
   function isAge(txtField, name){
	   if(isEmptyString(txtField.value)){	 
			selectTextField(txtField,"'"+name+"'不能为空");
			return false;
	   }
	   var tt=/^[1-9]\d{0,2}$/;
	   if(tt.test(txtField.value)){
			return true;
	   }else{
		    selectTextField(txtField,"'"+name+"'为非法年龄");
			return false;
	   }
   }
   
   
   /**
    * 判断手机号码或固定号码
    */
   function isPhone(txtField, name){
 	  if(isEmptyString(txtField.value)){	
			selectTextField(txtField,"'"+name+"'不能为空");
			return false;
	  	   }
	  	   var reQQ = /^[1]\d{10}$|^0\d{2,3}-?\d{7,8}$/;
	  	   if (reQQ.test(txtField.value)){//输入正确
	  		   return true;
	  	   }else{
	  		    selectTextField(txtField,"'"+name+"'为非法的联系方式");
	  		   return false;
	  	   }
   }
   
   /**
    * 判断邮箱
    * @param txtField
    * @param name
    * @returns {Boolean}
    */
   function isEmail(txtField, name) {
   	if (isEmptyString(txtField.value)) {
   		selectTextField(txtField, "'" + name + "'不能为空");
   		return false;
   	}
   	var reMail = /^\w+@[a-z0-9]+\.[a-z]+$/i;
   	if (reMail.test(txtField.value)) {//输入正确
   		return true;
   	} else {
   		selectTextField(txtField, "'" + name + "'为非法的邮箱地址");
   		return false;
   	}

   }
   
   
   