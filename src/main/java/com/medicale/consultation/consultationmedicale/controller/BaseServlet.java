package com.medicale.consultation.consultationmedicale.controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

public abstract class BaseServlet extends HttpServlet {
    protected void view(HttpServletRequest request, HttpServletResponse response, String viewName) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/" + viewName).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        dispatch(req, resp, "index");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // default action param for POST is 'action', fallback to 'index' or 'create' depending on controller
        String action = req.getParameter("action");
        if (action == null || action.isBlank()) action = "index";
        dispatch(req, resp, action);
    }

    private void dispatch(HttpServletRequest req, HttpServletResponse resp, String action) throws ServletException, IOException {
        try {
            Method method = this.getClass().getMethod(action, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this, req, resp);
        } catch (NoSuchMethodException e) {
            // If method not found, try 'index' as fallback for GET
            if (!"index".equals(action)) {
                try {
                    Method index = this.getClass().getMethod("index", HttpServletRequest.class, HttpServletResponse.class);
                    index.invoke(this, req, resp);
                    return;
                } catch (Exception ex) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not found: " + action);
                    return;
                }
            }
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not found: " + action);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
