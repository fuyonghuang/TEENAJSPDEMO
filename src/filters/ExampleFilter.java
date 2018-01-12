//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public final class ExampleFilter implements Filter {
    private String attribute = null;
    private FilterConfig filterConfig = null;

    public ExampleFilter() {
    }

    public void destroy() {
        this.attribute = null;
        this.filterConfig = null;
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        if (this.attribute != null) {
            request.setAttribute(this.attribute, this);
        }

        long startTime = System.currentTimeMillis();
        chain.doFilter(request, response);
        long stopTime = System.currentTimeMillis();
        this.filterConfig.getServletContext().log(this.toString() + ": " + (stopTime - startTime) + " milliseconds");
    }

    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        this.attribute = filterConfig.getInitParameter("attribute");
    }

    public String toString() {
        if (this.filterConfig == null) {
            return "InvokerFilter()";
        } else {
            StringBuffer sb = new StringBuffer("InvokerFilter(");
            sb.append(this.filterConfig);
            sb.append(")");
            return sb.toString();
        }
    }
}
