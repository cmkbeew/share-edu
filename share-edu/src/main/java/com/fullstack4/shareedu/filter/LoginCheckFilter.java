package com.fullstack4.shareedu.filter;

import com.fullstack4.shareedu.service.LoginService;
import com.fullstack4.shareedu.util.CookieUtil;
import lombok.extern.log4j.Log4j2;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Log4j2
@WebFilter(urlPatterns = {"/", "/bbs/*", "/member/view", "/member/modify", "/member/delete"})
public class LoginCheckFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        log.info("LoginCheckFilter");

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        // 세션 o, 쿠키 x -> 자동 로그인 x
        if(session.getAttribute("user_id") != null && session.getAttribute("name") != null) {
            chain.doFilter(request, response);
            return;
        }

        String auto_login = CookieUtil.getCookieValue("auto_login", req);
        String user_name = CookieUtil.getCookieValue("user_name", req);

        // 세션 x, 쿠키 x
        if(session.getAttribute("user_id") == null && auto_login.equals("") && user_name.equals("")) {
            res.sendRedirect("/login/login");
            return;
        }
        //세션 x, 쿠키 o -> 자동 로그인
        if(session.getAttribute("user_id") == null && !auto_login.equals("") && !user_name.equals("")) {
            session.setAttribute("user_id", auto_login);
            session.setAttribute("name", user_name);
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}