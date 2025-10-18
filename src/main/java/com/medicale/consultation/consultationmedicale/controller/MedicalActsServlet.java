package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;
import com.medicale.consultation.consultationmedicale.service.ConsultationService;
import com.medicale.consultation.consultationmedicale.service.MedicalActsService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/medicalActs")
public class MedicalActsServlet extends BaseServlet {

    private final ConsultationService consultationService = new ConsultationService();
    private final MedicalActsService medicalActsService = new MedicalActsService();

    public void index(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(req.getParameter("id"));

            Consultation consultation = consultationService.findAll().stream()
                    .filter(a -> a.getMedicalFile().getId().equals(id))
                    .findFirst()
                    .orElseThrow(() -> new ServletException("Consultation non trouvée"));

            req.setAttribute("consultation", consultation);
            view(req, resp, "medicalActs.jsp");
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de consultation invalide");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Une erreur est survenue: " + e.getMessage());
        }
    }

    public void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String label = req.getParameter("label");
            double price = Double.parseDouble(req.getParameter("price"));
            Long consultationId = Long.parseLong(req.getParameter("id"));

            if (label == null || label.trim().isEmpty()) {
                throw new IllegalArgumentException("Le libellé est requis");
            }

            Consultation consultation = consultationService.findById(consultationId);
            if (consultation == null) {
                throw new ServletException("Consultation non trouvée");
            }

            MedicaleAct medicaleAct = new MedicaleAct();
            medicaleAct.setLabel(label);
            medicaleAct.setPrice(price);
            medicaleAct.setConsultation(consultation);

            medicalActsService.save(medicaleAct);

            resp.sendRedirect(req.getContextPath() + "/medicalActs?id=" + consultation.getMedicalFile().getId());
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Prix ou ID invalide");
        } catch (IllegalArgumentException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Une erreur est survenue: " + e.getMessage());
        }
    }
}
