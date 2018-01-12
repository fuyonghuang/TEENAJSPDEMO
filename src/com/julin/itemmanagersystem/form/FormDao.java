//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.julin.itemmanagersystem.form;

import com.julin.model.ElementInfo;
import com.rad.db.CommonDaoAction;
import com.rad.db.Record;
import com.rad.db.SqlManager;
import com.rad.util.CommonUtil;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
import java.util.Vector;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

public class FormDao {
    public FormDao() {
    }

    public static HashMap htmlFileParse(String html) throws Exception {
        File file = new File(html);
        Document doc = Jsoup.parse(file, "utf-8");
        return docParse(doc);
    }

    public static HashMap htmlParse(String html) throws Exception {
        Document doc = Jsoup.parse(html, "utf-8");
        return docParse(doc);
    }

    public static HashMap docParse(Document doc) throws Exception {
        ElementInfo elementInfo = null;
        String dataType = "";
        List list = new ArrayList();
        HashMap<String, String> hKeyValue = new HashMap();
        String fieldCode = "";
        String fieldLength = "";
        String fieldTitle = "";
        String fieldType = "";
        String tmpText = "";
        String dataCheck = "";
        String showOrHideHtml = "";
        HashMap<String, Object> hHtml = new HashMap();
        int i = 0;
        Iterator var15 = doc.getElementsByAttribute("datatype").iterator();

        while(true) {
            Element element;
            do {
                do {
                    if (!var15.hasNext()) {
                        String html = doc.body().html();
                        html = "<form method='post' name='this_form' action='../itemInputSave.jsp'>" + html;
                        html = html + "<input type='hidden' name='instanceId'>";
                        html = html + "<input type='hidden' name='formId'>";
                        html = html + "<input type='hidden' name='txtAction'>";
                        html = html + "<input type='hidden' name='saveType'></form>";
                        if (!showOrHideHtml.equals("")) {
                            html = html + showOrHideHtml;
                        }

                        doc.body().html(html);
                        String docHtml = doc.html();
                        docHtml = docHtml.replaceAll("<!--julin-includefile>", "<%@include file=\"");
                        docHtml = docHtml.replaceAll("</julin-includefile-->", "\"%>");
                        docHtml = docHtml.replaceAll("<!--julin-script>", "<script>");
                        docHtml = docHtml.replaceAll("</julin-script-->", "</script>");
                        hHtml.put("fieldList", list);
                        hHtml.put("html", docHtml);
                        return hHtml;
                    }

                    element = (Element)var15.next();
                    elementInfo = new ElementInfo();
                    dataType = element.attr("datatype");
                    fieldCode = element.attr("fieldcode");
                    fieldLength = element.attr("fieldlength");
                    fieldTitle = element.attr("fieldtitle");
                    fieldType = element.attr("fieldtype");
                } while(fieldCode == null);
            } while(fieldCode.equals(""));

            if (fieldLength == null || fieldLength.equals("")) {
                fieldLength = "50";
            }

            if (fieldTitle == null || fieldTitle.equals("")) {
                fieldTitle = fieldCode;
            }

            if (fieldType == null || fieldType.equals("")) {
                fieldType = "text";
            }

            dataCheck = element.attr("datacheck");
            if (dataCheck == null || dataCheck.equals("")) {
                dataCheck = "0";
            }

            elementInfo.setFieldCode(fieldCode);
            elementInfo.setFieldName(fieldTitle);
            elementInfo.setFieldLength(fieldLength);
            elementInfo.setFieldType(fieldType);
            elementInfo.setDataCheck(dataCheck);
            elementInfo.setDataType(dataType);
            ++i;
            element.attr("name", fieldCode);
            if (element.attr("id") == null || element.attr("id").equals("")) {
                element.attr("id", "julin" + i);
            }

            if (element.attr("valueShow") != null && !element.attr("valueShow").equals("")) {
                if (!"radio".equals(element.attr("datatype")) && !"checkbox".equals(element.attr("datatype"))) {
                    showOrHideHtml = showOrHideHtml + "<script>if(document.getElementById('" + element.attr("id") + "').value!='')" + "document.getElementById('" + element.attr("valueshow") + "').style.display='';</script>\n";
                } else {
                    showOrHideHtml = showOrHideHtml + "<script>if(document.getElementById('" + element.attr("id") + "').checked){document.getElementById('" + element.attr("valueshow") + "').style.display='';}</script>\n";
                }
            }

            if (dataType.startsWith("user_")) {
                setValueByUser(element, dataType.split("_")[1]);
            } else if (dataType.startsWith("para_")) {
                setValueByPara(element, dataType.split("_")[1]);
            } else {
                setValueByRecord(element);
            }

            element.removeAttr("fieldcode");
            element.removeAttr("fieldlength");
            element.removeAttr("filedtitle");
            element.removeAttr("fieldtype");
            element.removeAttr("datatype");
            element.removeAttr("fieldvalue");
            element.removeAttr("datacheck");
            if (!hKeyValue.containsKey(fieldCode) && !dataType.startsWith("para_")) {
                list.add(elementInfo);
            }

            if (dataType.equalsIgnoreCase("deleteAfterCreate")) {
                element.remove();
            }

            hKeyValue.put(fieldCode, "1");
        }
    }

    private static void setValueByRecord(Element element) throws Exception {
        String dValue = "";
        String tmpString = "";
        if (element.tagName().equalsIgnoreCase("input")) {
            if ("radio".equals(element.attr("datatype"))) {
                element.attr("value", element.attr("fieldvalue"));
                element.after("<script>document.getElementById('" + element.attr("id") + "').checked=<%=(record.getString(\"" + element.attr("fieldcode") + "\").equals(\"" + element.attr("fieldvalue") + "\")?\"true\":\"false\")%></script>");
            } else if ("checkbox".equals(element.attr("datatype"))) {
                element.attr("value", element.attr("fieldvalue"));
                element.after("<script>document.getElementById('" + element.attr("id") + "').checked=<%=(record.getString(\"" + element.attr("fieldcode") + "\").indexOf(\"" + element.attr("fieldvalue") + "\")>=0?\"true\":\"false\")%></script>");
            } else {
                element.attr("value", "<%=record.getString(\"" + element.attr("fieldcode") + "\")%>");
            }
        } else if (element.tagName().equalsIgnoreCase("textarea")) {
            element.text("<%=record.getString(\"" + element.attr("fieldcode") + "\")%>");
        } else if (element.tagName().equalsIgnoreCase("select")) {
            element.attr("value", "<%=record.getString(\"" + element.attr("fieldcode") + "\")%>");
            Iterator var4 = element.children().iterator();

            while(var4.hasNext()) {
                Element child = (Element)var4.next();
                child.attr("selected", "<%=(record.getString(\"" + element.attr("fieldcode") + "\").equals(\"" + child.attr("value") + "\")?\"selected\":\"\")%>");
            }

            element.after("<script>document.getElementById('" + element.attr("id") + "').value='<%=record.getString(\"" + element.attr("fieldcode") + "\")%>'</script>");
        }

    }

    private static void setValueByUser(Element element, String userFieldCode) throws Exception {
        String dValue = "";
        String tmpString = "";
        element.attr("readonly", "true");
        if (element.tagName().equalsIgnoreCase("input")) {
            element.attr("value", "<%=(record.getString(\"" + userFieldCode + "\").equals(\"\")?userInfo.getString(\"" + userFieldCode + "\"):record.getString(\"" + userFieldCode + "\"))%>");
        } else if (element.tagName().equalsIgnoreCase("textarea")) {
            element.text("<%=userInfo.getString(\"" + userFieldCode + "\")%>");
        }

    }

    private static void setValueByPara(Element element, String userFieldCode) throws Exception {
        String dValue = "";
        String tmpString = "";
        element.attr("readonly", "true");
        if (element.tagName().equalsIgnoreCase("input")) {
            element.attr("value", "<%=hPara.get(\"" + userFieldCode + "\")==null?\"\":hPara.get(\"" + userFieldCode + "\")%>");
        } else if (element.tagName().equalsIgnoreCase("textarea")) {
            element.text("<%=hPara.get(\"" + userFieldCode + "\")==null?\"\":hPara.get(\"" + userFieldCode + "\")%>");
        }

    }

    public static boolean createTable(String tableName, List list) throws Exception {
        ElementInfo elementInfo = null;
        String strSql = "CREATE TABLE  " + tableName;
        String tmpSql = "";
        String field = "";
        String fieldCode = "";
        String fieldLength = "";
        String fieldTitle = "";
        String fieldType = "";
        String dataType = "";
        String dataCheck = "";
        new HashMap();
        CommonDaoAction.deleteInfoByKeyValue("s_entityinfo", "tableName", tableName);
        strSql = strSql + "( instanceId varchar(100) COMMENT '实例id号'";
        strSql = strSql + " ,companyId varchar(100) COMMENT '单位id号'";
        strSql = strSql + " ,companyName varchar(100) COMMENT '单位名称'";
        strSql = strSql + " ,itemId varchar(100) COMMENT '项目Id号'";
        strSql = strSql + " ,itemCode varchar(100) COMMENT '项目编号'";
        strSql = strSql + " ,itemName varchar(100) COMMENT '项目名称'";
        strSql = strSql + " ,itemType varchar(100) COMMENT '项目类型'";
        strSql = strSql + " ,formId varchar(100) COMMENT '表单id号'";
        strSql = strSql + " ,formName varchar(100) COMMENT '表单名称'";
        strSql = strSql + " ,formType varchar(50) COMMENT '表单类型'";
        strSql = strSql + " ,createTime varchar(50) COMMENT '创建时间'";
        strSql = strSql + " ,createUser varchar(50) COMMENT '创建用户'";
        strSql = strSql + " ,updateTime varchar(50) COMMENT '更新时间'";
        strSql = strSql + " ,updateUser varchar(50) COMMENT '更新用户名称'";
        strSql = strSql + " ,status varchar(20) COMMENT '信息状态0未提交1已提交'";
        String alreadHaveField = ",instanceId,companyId,companyName,itemId,itemCode,itemName,itemType,formId,formName,status,createTime,createUser,updateTime,updateUser,status,";
        alreadHaveField = alreadHaveField.toLowerCase();

        for(int i = 0; i < list.size(); ++i) {
            elementInfo = (ElementInfo)list.get(i);
            fieldCode = elementInfo.getFieldCode();
            if (alreadHaveField.indexOf("," + fieldCode.toLowerCase() + ",") < 0) {
                fieldLength = elementInfo.getFieldLength();
                fieldTitle = elementInfo.getFieldName();
                fieldType = elementInfo.getFieldType();
                dataType = elementInfo.getDataType();
                dataCheck = elementInfo.getDataCheck();
                if (fieldCode != null && !fieldCode.equals("")) {
                    if (fieldLength == null || fieldLength.equals("")) {
                        fieldLength = "50";
                    }

                    if (fieldTitle == null || fieldTitle.equals("")) {
                        fieldTitle = fieldCode;
                    }

                    if (fieldType == null || fieldType.equals("")) {
                        fieldType = "text";
                    }

                    if (dataType == null || dataType.equals("")) {
                        dataType = "text";
                    }

                    if (dataCheck == null || dataCheck.equals("")) {
                        dataCheck = "0";
                    }

                    if (fieldType.equals("int")) {
                        fieldLength = "11";
                        field = fieldCode + " int(11) DEFAULT '0' COMMENT '" + fieldTitle + "' ";
                    } else if (Integer.parseInt(fieldLength) >= 500) {
                        field = fieldCode + " text  COMMENT '" + fieldTitle + "' ";
                    } else {
                        field = fieldCode + " varchar(" + fieldLength + ")  COMMENT '" + fieldTitle + "' ";
                    }

                    HashMap<String, String> hKeyValue = new HashMap();
                    hKeyValue.put("detailId", UUID.randomUUID().toString() + "-" + (new Date()).getTime());
                    hKeyValue.put("tableName", tableName);
                    hKeyValue.put("fieldCode", fieldCode);
                    hKeyValue.put("fieldName", fieldTitle);
                    hKeyValue.put("fieldType", fieldType);
                    hKeyValue.put("fieldLength", fieldLength);
                    hKeyValue.put("dataType", dataType);
                    hKeyValue.put("dataCheck", dataCheck);
                    tmpSql = tmpSql + "," + field;
                    CommonDaoAction.insertInfo("s_entityinfo", hKeyValue);
                }
            }
        }

        strSql = strSql + tmpSql + ",PRIMARY KEY (instanceId),KEY (itemId),KEY (itemName),KEY (formId)) ENGINE=InnoDB DEFAULT CHARSET=utf8;";
        SqlManager sqlManager = new SqlManager();
        sqlManager.addSql(strSql);
        System.out.println(strSql);

        try {
            sqlManager.execte();
            return true;
        } catch (Exception var16) {
            var16.printStackTrace();
            return false;
        }
    }

    public static boolean updateTable(String tableName, List list) throws Exception {
        ElementInfo elementInfo = null;
        String strSql = "select * from " + tableName + " where 0=1";
        SqlManager sqlManager = new SqlManager();
        Record record = sqlManager.getRecords(strSql);
        Vector cols = record.getColumnName();
        HashMap<String, String> hCols = new HashMap();

        for(int i = 0; i < cols.size(); ++i) {
            hCols.put((String)cols.get(i), "1");
        }

        strSql = "ALTER TABLE  " + tableName;
        String tmpSql = "";
        String field = "";
        String fieldCode = "";
        String fieldLength = "";
        String fieldTitle = "";
        String fieldType = "";
        String dataType = "";
        String dataCheck = "";
        new HashMap();
        CommonDaoAction.deleteInfoByKeyValue("s_entityinfo", "tableName", tableName);

        for(int i = 0; i < list.size(); ++i) {
            elementInfo = (ElementInfo)list.get(i);
            fieldCode = elementInfo.getFieldCode();
            fieldLength = elementInfo.getFieldLength();
            fieldTitle = elementInfo.getFieldName();
            fieldType = elementInfo.getFieldType();
            dataType = elementInfo.getDataType();
            dataCheck = elementInfo.getDataCheck();
            if (fieldCode != null && !fieldCode.equals("")) {
                if (fieldLength == null || fieldLength.equals("")) {
                    fieldLength = "50";
                }

                if (fieldTitle == null || fieldTitle.equals("")) {
                    fieldTitle = fieldCode;
                }

                if (fieldType == null || fieldType.equals("")) {
                    fieldType = "text";
                }

                if (dataType == null || dataType.equals("")) {
                    dataType = "text";
                }

                if (dataCheck == null || dataCheck.equals("")) {
                    dataCheck = "0";
                }

                if (fieldType.equals("int")) {
                    fieldLength = "11";
                    field = fieldCode + " int(11) DEFAULT '0' COMMENT '" + fieldTitle + "' ";
                } else if (Integer.parseInt(fieldLength) >= 500) {
                    field = fieldCode + " text  COMMENT '" + fieldTitle + "' ";
                } else {
                    field = fieldCode + " varchar(" + fieldLength + ")  COMMENT '" + fieldTitle + "' ";
                }

                if (hCols.containsKey(fieldCode.toUpperCase())) {
                    field = "MODIFY COLUMN " + field;
                } else {
                    field = "ADD COLUMN " + field;
                }

                HashMap<String, String> hKeyValue = new HashMap();
                hKeyValue.put("detailId", UUID.randomUUID().toString() + "-" + (new Date()).getTime());
                hKeyValue.put("tableName", tableName);
                hKeyValue.put("fieldCode", fieldCode);
                hKeyValue.put("fieldName", fieldTitle);
                hKeyValue.put("fieldType", fieldType);
                hKeyValue.put("fieldLength", fieldLength);
                hKeyValue.put("dataType", dataType);
                hKeyValue.put("dataCheck", dataCheck);
                if (tmpSql.equals("")) {
                    tmpSql = field;
                } else {
                    tmpSql = tmpSql + "," + field;
                }

                CommonDaoAction.insertInfo("s_entityinfo", hKeyValue);
            }
        }

        strSql = strSql + " " + tmpSql;
        sqlManager.addSql(strSql);

        try {
            sqlManager.execte();
            return true;
        } catch (Exception var18) {
            var18.printStackTrace();
            return false;
        }
    }

    public static String getFormHeader(String tableName) {
        StringBuffer jspString = new StringBuffer();
        jspString.append("<%@ page language=\"java\"  pageEncoding=\"UTF-8\"%>\r\n");
        jspString.append("<%@ include file=\"/import.jsp\"%>\r\n");
        jspString.append("<%@ include file=\"/sessionCheck.jsp\"%>\r\n");
        jspString.append("<% String instanceId=request.getParameter(\"instanceId\")==null?\"\":request.getParameter(\"instanceId\") ; \r\n");
        jspString.append("   String action=request.getParameter(\"txtAction\")==null?\"insert\":request.getParameter(\"txtAction\") ;  \r\n");
        jspString.append("   String itemId=request.getParameter(\"itemId\")==null?\"\":request.getParameter(\"itemId\") ; \r\n");
        jspString.append("   String formId=request.getParameter(\"formId\")==null?\"insert\":request.getParameter(\"formId\") ;  \r\n");
        jspString.append("   String isCanModify=request.getParameter(\"isCanModify\")==null?\"insert\":request.getParameter(\"isCanModify\") ;  \r\n");
        jspString.append("   java.util.Enumeration<String> checkParas=request.getParameterNames();\r\n");
        jspString.append("   java.util.HashMap<String,String> hPara=new java.util.HashMap<String,String>();\r\n");
        jspString.append("   String checkPara=\"\";\r\n");
        jspString.append("   while(checkParas.hasMoreElements()){  \r\n");
        jspString.append("      checkPara = checkParas.nextElement();\r\n");
        jspString.append("      hPara.put(checkPara,request.getParameter(checkPara));\r\n");
        jspString.append("   }\r\n");
        jspString.append("   Record record=new Record(); \r\n");
        jspString.append("    if(action.equals(\"update\")){ \r\n");
        jspString.append("       record=CommonDaoAction.getInfoByKeyValue(\"" + tableName + "\",\"instanceId\",instanceId); \r\n");
        jspString.append("       record.next(); \r\n");
        jspString.append("       itemId=record.getString(\"itemId\"); \r\n");
        jspString.append("       formId=record.getString(\"formId\"); \r\n");
        jspString.append("       action=\"update\"; \r\n");
        jspString.append("   }else if(!itemId.equals(\"\")){\r\n");
        jspString.append("       record=CommonDaoAction.getInfoByKeyValue(\"t_itemInfo\",\"itemId\",itemId); \r\n");
        jspString.append("       record.next(); \r\n");
        jspString.append("   }%>\r\n");
        return jspString.toString();
    }

    public static void createJspFile(String fileName, String tableName, String htmlFile) throws Exception {
        StringBuffer jspFile = new StringBuffer();
        jspFile.append(getFormHeader(tableName));
        jspFile.append(htmlFile);
        CommonUtil.writeStringToFile(fileName, jspFile.toString(), "utf-8");
    }

    public static void main(String[] args) throws Exception {
        HashMap hHtml = htmlFileParse("d:/safeJob.html");
        List list = (List)hHtml.get("fieldList");
        String html = (String)hHtml.get("html");
        createTable("infosafe19", list);
        createJspFile("D:/tomcat8/webapps/zongqiao/manager/itemManager/jsp/infosafe19.jsp", "infosafe19", html);
    }
}
