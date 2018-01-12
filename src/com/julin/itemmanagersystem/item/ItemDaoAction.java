//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.julin.itemmanagersystem.item;

import com.rad.db.SqlManager;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;
import org.json.JSONArray;
import org.json.JSONObject;

public class ItemDaoAction {
    public ItemDaoAction() {
    }

    public static void deleteAttchFile(String itemAttachConfigId, String tableId) {
        try {
            SqlManager sqlManager = new SqlManager();
            String strSql = "delete from s_itemattachfile where itemAttachConfigId=? and tableId=?";
            Vector vPara = new Vector();
            vPara.add(itemAttachConfigId);
            vPara.add(tableId);
            sqlManager.addSql(strSql, vPara);
            sqlManager.execte();
        } catch (Exception var5) {
            var5.printStackTrace();
        }

    }

    public static void deleteAttchFileByTable(String tableName, String key, String value) {
        try {
            SqlManager sqlManager = new SqlManager();
            String strSql = "delete from s_itemattachfile where tableName=? and talbeKeyField=? and tableId=?";
            Vector vPara = new Vector();
            vPara.add(tableName);
            vPara.add(key);
            vPara.add(value);
            sqlManager.addSql(strSql, vPara);
            sqlManager.execte();
        } catch (Exception var6) {
            var6.printStackTrace();
        }

    }

    public static void deleteAttchFileById(String attachId) {
        JSONArray jsonArray = new JSONArray("");
        JSONObject var2 = jsonArray.getJSONObject(0);

        try {
            SqlManager sqlManager = new SqlManager();
            String strSql = "delete from s_itemattachfile where attachId=?";
            Vector vPara = new Vector();
            vPara.add(attachId);
            sqlManager.addSql(strSql, vPara);
            sqlManager.execte();
        } catch (Exception var6) {
            var6.printStackTrace();
        }

    }

    public static void insertAttchFile(JSONObject jsonObject) {
        SqlManager sqlManager = new SqlManager();
        String curTime = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());

        try {
            String[] fields = "fileName,url,originalName,extName,fileSize,tableName,moduleName,attachTag,extendValue,updateUser,itemAttachConfigId,attachFileCheckCode,attachFileItemTypeId,talbeKeyField,tableId,itemId".split(",");
            Vector vPara = new Vector();

            for(int i = 0; i < fields.length; ++i) {
                try {
                    vPara.add(jsonObject.getString(fields[i]));
                } catch (Exception var7) {
                    vPara.add("");
                }
            }

            vPara.add(curTime);
            String strSql = "insert into s_itemattachfile(fileName,url,originalName,extName,fileSize,tableName,moduleName,attachTag,extendValue,updateUser,itemAttachConfigId,attachFileCheckCode,attachFileItemTypeId,talbeKeyField,tableId,itemId,updateTime)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            sqlManager.addSql(strSql, vPara);
            sqlManager.execte();
        } catch (Exception var8) {
            var8.printStackTrace();
        }

    }
}
