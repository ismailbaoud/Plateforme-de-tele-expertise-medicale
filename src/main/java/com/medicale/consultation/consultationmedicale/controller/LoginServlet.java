package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.models.person.Nurse;
import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.repositories.BaseRepository;
import com.medicale.consultation.consultationmedicale.service.PersonService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
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
            PersonService service = new PersonService();

            List<Person> people = service.findAll();
            Boolean emailExist = people.stream().anyMatch(person -> person.getEmail().equals(email));
            Boolean passwordExist = people.stream().anyMatch(person -> person.getPassword().equals(password));

            if (emailExist && passwordExist) {

                Person user = people.stream().filter(person -> person.getEmail().equals(email)).findFirst().orElse(null);

                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                assert user != null;
                session.setAttribute("role", user.getRole());

                response.sendRedirect("dashboard");

            } else {
                request.setAttribute("error", "Username ou password ghaltin!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                session.invalidate();
                response.sendRedirect("dashboard");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
