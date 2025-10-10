package com.medicale.consultation.consultationmedicale.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;


public class BaseServlet extends HttpServlet {
    private static final String VIEW_PATH = "/WEB-INF/views/";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        processRequest(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        processRequest(req, res);
    }


    private void processRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.isBlank()) action = "index";
        try {
            Method method = this.getClass().getMethod(action, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this,req, res);
        }catch (Exception e){
            throw new ServletException("action not found" + action + " " + e.getMessage());
        }
    }

    protected  void view(HttpServletRequest req , HttpServletResponse res, String view) throws   ServletException, IOException {
        req.getRequestDispatcher(VIEW_PATH+ view).forward(req, res);
    }
}

