//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package filters;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {
    private FilterConfig config;

    public LoginFilter() {
    }

    public void destroy() {
        this.config = null;
    }

    public void init(FilterConfig filterconfig) throws ServletException {
        this.config = filterconfig;
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
        HttpServletRequest req = (HttpServletRequest)request;
        HttpServletResponse rpo = (HttpServletResponse)response;
        HttpSession session = req.getSession();
        String userId = (String)session.getAttribute("user");
        String preloginUrl = "sysLoginCheck.jsp";
        String request_uri = req.getRequestURI();
        System.out.println(request_uri);
        String ctxPath = req.getContextPath();
        System.out.println(ctxPath);

        try {
            if (userId == null) {
                if (request_uri.indexOf(preloginUrl) == -1 && request_uri.indexOf(".jsp") != -1) {
                    rpo.sendRedirect(ctxPath);
                    return;
                }

                chain.doFilter(request, response);
                return;
            }

            chain.doFilter(request, response);
        } catch (Exception var12) {
            var12.printStackTrace();
        }

    }
}
