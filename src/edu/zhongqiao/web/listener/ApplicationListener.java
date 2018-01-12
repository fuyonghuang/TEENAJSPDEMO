//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package edu.zhongqiao.web.listener;

import com.rad.db.CommonDaoAction;
import com.rad.util.CommonUtil;
import java.io.InputStream;
import java.util.Properties;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ApplicationListener implements ServletContextListener {

  private String globalConfigFileName = "/WEB-INF/classes/globalconfig.cfg";
  private static Log log;

  static {
    LogFactory.getFactory();
    log = LogFactory.getLog(ApplicationListener.class);
  }

  public ApplicationListener() {
  }

  /**
   *
   * @param sce
   */
  public void contextInitialized(ServletContextEvent sce) {
    Properties props = null;
    Object is = null;

    try {
      log.debug(sce.getServletContext().getRealPath(this.globalConfigFileName));
      props = CommonUtil
          .LoadProperties(sce.getServletContext().getRealPath(this.globalConfigFileName));
      CommonDaoAction.reLoadSystemConfig(props);
    } catch (Exception var13) {
      var13.printStackTrace();
      log.error("load " + this.globalConfigFileName + " ex:" + var13.fillInStackTrace());
    } finally {
      if (is != null) {
        try {
          ((InputStream) is).close();
        } catch (Exception var12) {
          ;
        }
      }

    }

  }

  public void contextDestroyed(ServletContextEvent sce) {
  }
}
