package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
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

    public void index(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ConsultationService consultationService = new ConsultationService();
            Long id =Long.parseLong(req.getParameter("id"));
            Consultation consultation = consultationService.findAll().stream().filter(a -> a.getMedicalFile().getId() == id).findFirst().get();
            req.setAttribute("consultationId", consultation.getId());
            view(req , resp , "medicalActs.jsp");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    public void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MedicalActsService  medicalActsService = new MedicalActsService();
        try {
            String label = req.getParameter("label");
            Double price = Double.parseDouble(req.getParameter("price"));
            MedicaleAct medicaleAct = new MedicaleAct();
            ConsultationService consultationService = new ConsultationService();
            Consultation consultation = consultationService.findById(Long.parseLong(req.getParameter("id")));
            medicaleAct.setConsultation(consultation);
            medicaleAct.setLabel(label);
            medicaleAct.setPrice(price);
            medicalActsService.save(medicaleAct);
            view(req , resp , "medicalActs.jsp");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
