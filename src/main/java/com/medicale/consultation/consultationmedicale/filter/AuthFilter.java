package com.medicale.consultation.consultationmedicale.filter;


import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization (ma khass walo daba)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Check wach user f session
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        String path = req.getRequestURI().substring(req.getContextPath().length());

        if (path.startsWith("/login") || path.startsWith("/css") || path.startsWith("/js")) {
            chain.doFilter(request, response); // allow access
            return;
        }
        if (isLoggedIn) {
            // User connecté, khallih ydouz
            chain.doFilter(request, response);
        } else {
            // Ma connectach, redd'o l login
            res.sendRedirect(req.getContextPath() + "/login?action=index");
        }
    }

    @Override
    public void destroy() {
        // Cleanup (ma khass walo daba)
    }
}