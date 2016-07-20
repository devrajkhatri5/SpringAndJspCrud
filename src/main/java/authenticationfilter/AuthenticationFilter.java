package authenticationfilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.spring.controller.GlobalExceptionHandler;

/**
 * Servlet Filter implementation class AuthenticationFilter
 */
@WebFilter(filterName="AuthenticationFilter" , urlPatterns={"/"})
public class AuthenticationFilter implements Filter {
	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /**
     * Default constructor. 
     */
    public AuthenticationFilter() {
    	//constructor

    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {

		//destroy after the process completes
		
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;
            HttpSession session = req.getSession(false);

            String requestURI = req.getRequestURI();

            if (requestURI.equalsIgnoreCase("/home/Login")) {
                
            	if(req.getMethod().equalsIgnoreCase("POST")){
                    chain.doFilter(request, response);
                }
            }else if (requestURI.equalsIgnoreCase("/Admin/AddUser")) {
                if (req.getMethod().equalsIgnoreCase("POST")) {
                    chain.doFilter(request, response);
                }
            }else if (requestURI.equalsIgnoreCase("/Admin/ajaxForUserRole")) {
                if (req.getMethod().equalsIgnoreCase("GET")) {
                    chain.doFilter(request, response);
                }
            } else if (requestURI.indexOf("/Index") >= 0
                    || (session != null && session.getAttribute("userId") != null)){

            		chain.doFilter(request, response);
            } else{
                res.sendRedirect(req.getContextPath() + "/Home/Index");
            }
        } catch (Exception e) {
            logger.info(e.getMessage());
        }
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		//initialization of filter

	}

}
