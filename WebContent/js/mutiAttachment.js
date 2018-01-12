/*------------增加和删除附件列表操作-------------------------*/
	//增加附件行
	function insertAttachmentRow(objId){
		alert(1);
			var row,col;
			var aTable=document.getElementById(objId)
			row = aTable.insertRow(aTable.rows.length);
			var seqNo=parseInt(document.getElementById("attachFileSeqNo").value)+1;
			document.getElementById("attachFileSeqNo").value=seqNo;
			row.setAttribute("id",seqNo);
			col = row.insertCell(0);
			col.innerHTML = "<td><input type='hidden' name='attachFileId' value='"+seqNo+"'><input type='file' name='attachFile"+seqNo+"'></td>";
			col = row.insertCell(1);
			col.innerHTML = "<td><input type='button' class='button' value='删除附件' onClick='delAttachmentRow(\""+objId+"\","+row.getAttribute("id")+")'></td>";
	}
	
	//删除附件行
	function delAttachmentRow(objId,rowId) {
		
			//获取表格体
			var tableBody = document.getElementById(objId);
			//找到要删除的行对象
			var row = document.getElementById(rowId);
			//删除该行
		
			tableBody.deleteRow(row.rowIndex);
	}
	
	//删除选中的附件
	function delAccessory(){
       if(confirm("要删除附件吗")) {
       	  var checkboxList = document.getElementsByName("attachViewFileId");
					for(var i=0; checkboxList&&i<checkboxList.length; i++)
					{					
						if(checkboxList[i].checked)
						{ 						
							 attachDiv.removeChild(checkboxList[i].parentNode);
						}
					}
			}		
  }
   
 	//删除所有的附件
	function deleteAll(){
		if(confirm("要删除附件吗")) {
			 var checkboxList = document.getElementsByName("attachViewFileId");
					for(var i=0; checkboxList&&i<checkboxList.length; i++)
					{				
						
						attachDiv.innerHTML="";
					}
	  }
}
 
	//检查上传文件
	function checkUpload(){
	  for(i=0;i<attachDiv.all.length;i++){	     				     			
			if(!isNaN(attachDiv.children(i).checked) && !attachDiv.children(i).checked){	 	     			   
			   attachDiv.children(i).checked=true;
			}
		}
	}
 
 
   
