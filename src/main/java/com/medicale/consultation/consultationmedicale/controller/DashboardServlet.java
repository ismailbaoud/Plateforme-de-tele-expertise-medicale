package com.medicale.consultation.consultationmedicale.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends BaseServlet {

    public void index(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException {
        Object user = req.getSession().getAttribute("user");
        if (user != null) {
            req.setAttribute("user" , user);
            req.getRequestDispatcher("dashboard.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "Username ou password ghaltin!");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
        }
    }

    public void logout(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Object user = req.getSession().getAttribute("user");
        if (user != null) {
            session.removeAttribute("user");
            req.setAttribute("user" , user);
            req.getRequestDispatcher("dashboard.jsp").forward(req, res);
        }
    }
}
