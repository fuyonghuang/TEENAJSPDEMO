package com.jt.utils;

import com.rad.db.CommonDaoAction;
import com.rad.db.Record;
import com.rad.db.SqlManager;
import java.text.MessageFormat;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by  2018/1/9.
 */
public class TableToMapUtils {

  /**
   * 下划线转驼峰法
   *
   * @param line 源字符串
   * @param smallCamel 大小驼峰,是否为小驼峰
   * @return 转换后的字符串
   */
  private static String underline2Camel(String line, boolean smallCamel) {
    if (line == null || "".equals(line)) {
      return "";
    }
    StringBuffer sb = new StringBuffer();
    Pattern pattern = Pattern.compile("([A-Za-z\\d]+)(_)?");
    Matcher matcher = pattern.matcher(line);
    while (matcher.find()) {
      String word = matcher.group();
      sb.append(smallCamel && matcher.start() == 0 ? Character.toLowerCase(word.charAt(0))
          : Character.toUpperCase(word.charAt(0)));
      int index = word.lastIndexOf('_');
      if (index > 0) {
        sb.append(word.substring(1, index).toLowerCase());
      } else {
        sb.append(word.substring(1).toLowerCase());
      }
    }
    return sb.toString();
  }


  public static void toParameter(Record checkResult) {
    Vector columnName = checkResult.getColumnName();
    while (checkResult.next()) {
      System.out.println(checkResult.getString("REMARKS"));
    }
    String MapStr = "String {0} = request.getParameter( \"{1}\" ) == null ? \"\": request.getParameter( \"{2}\" );";
    for (Object bean : columnName
        ) {

      System.out.println(
          MessageFormat.format(MapStr, underline2Camel(bean.toString(), true),
              underline2Camel(bean.toString(), true), underline2Camel(bean.toString(), true)));
    }
  }


  public static void toMapUtils(Record checkResult) {
    Vector columnName = checkResult.getColumnName();

    String MapStr = "map.put(\"%s\",%s)";
    for (Object bean : columnName
        ) {

      System.out.println(
          MessageFormat.format("checkResultMap.put(\"{0}\",{1});", bean.toString().toLowerCase(),
              underline2Camel(bean.toString(), true)));
    }
  }


  public static void main(String[] args) {
    try {
      Record checkResult = CommonDaoAction.getInfo("T_CHECK_INFO");
      SqlManager sqlManager = new SqlManager();

      toMapUtils(checkResult);
      System.out.println("================================================");

      toParameter(checkResult);

    } catch (Exception e) {

    }


  }
}
