package com.etc.filter;

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

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/LoginFilter")
public class LoginFilter implements Filter {

    /**
     * Default constructor. 
     */
    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		System.out.println("进入访问控制的过滤器~");
		HttpServletRequest request=(HttpServletRequest)req;
		HttpServletResponse response=(HttpServletResponse)res;
		//获取请求的url
		String url = request.getServletPath();
		System.out.println(url);
		response.setContentType("text/html");
		HttpSession session = request.getSession();
		if(session.getAttribute("user")!=null) {
			//放行
			chain.doFilter(request, response);
		}else {
			//如果没有登录,就跳转到登录页面
			//如果请求时login.jsp,那就放行
			if ("/mvc/login.jsp".equals(url)) {
				//放行
				chain.doFilter(request, response);
			}else {
				response.getWriter().print("<script>alert('请登录');location.href='/cms1.5/mvc/login.jsp'</script>");
			}
		}
		
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
