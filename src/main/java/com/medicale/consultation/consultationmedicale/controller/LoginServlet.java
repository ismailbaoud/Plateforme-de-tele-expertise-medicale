package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.service.PersonService;
import com.medicale.consultation.consultationmedicale.utils.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends BaseServlet {

    public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("dashboard");
            return;
        }

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    public void authenticate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Email et mot de passe sont requis!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            PersonService service = new PersonService();
            List<Person> people = service.findAll();

            // Chercher l'utilisateur par email
            Person user = people.stream()
                    .filter(person -> person.getEmail() != null && person.getEmail().equals(email))
                    .findFirst()
                    .orElse(null);

            // Vérifier si l'utilisateur existe et si le mot de passe correspond
            if (user != null && PasswordUtils.checkPassword(password, user.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());

                System.out.println("✅ User logged in: " + user.getEmail() + " (Role: " + user.getRole() + ")");

                // Redirection basée sur le rôle
                if (user.getRole() != null && user.getRole().toString().equals("NURSE")) {
                    response.sendRedirect("nurse/dashboard");
                } else {
                    response.sendRedirect("dashboard");
                }
            } else {
                System.out.println("❌ Login failed for email: " + email);
                request.setAttribute("error", "Email ou mot de passe incorrect!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.err.println("❌ Error during authentication: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Une erreur est survenue lors de la connexion.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                System.out.println("🔓 User logging out: " + (session.getAttribute("user") != null ? ((Person)session.getAttribute("user")).getEmail() : "Unknown"));
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            logout(request, response);
        } else {
            index(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("authenticate".equals(action)) {
            authenticate(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action non reconnue");
        }
    }
}