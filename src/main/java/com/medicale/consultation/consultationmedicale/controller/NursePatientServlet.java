package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.service.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/nurse/patients")
public class NursePatientServlet extends BaseServlet {

    private final PatientService patientService;

    public NursePatientServlet() {
        this.patientService = new PatientService();
    }

    public void index(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Person user = (Person) req.getSession().getAttribute("user");
            if (user == null || user.getRole() != Role.NURSE) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
                return;
            }

            // Récupérer tous les patients
            List<Patient> allPatients = patientService.findAll();

            System.out.println("Loading patients for nurse: " + user.getEmail());
            System.out.println("Found " + allPatients.size() + " patients");

            req.setAttribute("patients", allPatients);
            view(req, resp, "nursePatients.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error loading patients: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors du chargement des patients");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        index(req, resp);
    }
}

