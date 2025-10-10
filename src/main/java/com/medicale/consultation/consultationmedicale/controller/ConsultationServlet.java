package com.medicale.consultation.consultationmedicale.controller;


import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.service.ConsultationService;
import com.mysql.cj.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/consultation")
public class ConsultationServlet extends BaseServlet {




    public void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String consultationIdParam = req.getParameter("id");
            String reason = req.getParameter("reason");
            String symptoms = req.getParameter("symptoms");
            String clinicalExam = req.getParameter("clinicalExam");
            String observations = req.getParameter("observations");

            if (consultationIdParam == null) {
                throw new IllegalArgumentException("Identifiant de la consultation manquant.");
            }

            Long consultationId = Long.parseLong(consultationIdParam);

            ConsultationService consultationService = new ConsultationService();
            Consultation consultation = consultationService.findById(consultationId);

            if (consultation == null) {
                throw new RuntimeException("Consultation introuvable avec l'ID : " + consultationId);
            }

            if (reason != null && !reason.isEmpty()) consultation.setReason(reason);
            if (symptoms != null && !symptoms.isEmpty()) consultation.setSymptoms(symptoms);
            if (clinicalExam != null && !clinicalExam.isEmpty()) consultation.setClinicalExam(clinicalExam);
            if (observations != null && !observations.isEmpty()) consultation.setObservations(observations);
            String statusParam = req.getParameter("status");
            if (statusParam != null && !statusParam.isEmpty()) {
                try {
                    ConsultationStatus status = ConsultationStatus.valueOf(statusParam.toUpperCase());
                    consultation.setConsultationStatus(status);
                } catch (IllegalArgumentException ignored) {
                    System.out.println("Invalid consultation status: " + statusParam);
                }
            }

            consultationService.update(consultation);

            view(req, resp, "consultation.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la mise à jour de la consultation : " + e.getMessage());
        }
    }


}
