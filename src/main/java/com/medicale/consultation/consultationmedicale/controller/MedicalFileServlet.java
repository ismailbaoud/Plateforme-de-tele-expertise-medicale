package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.service.ConsultationService;
import com.medicale.consultation.consultationmedicale.service.MedicalFileSevice;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;
import java.util.List;

@WebServlet("/medicalFiles")
public class MedicalFileServlet extends BaseServlet{
    private final MedicalFileSevice medicalFileSevice =  new MedicalFileSevice();

    public void index(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(req.getParameter("id"));
            MedicaleFile medicaleFile = medicalFileSevice.findAll()
                    .stream()
                    .filter(a -> a.getPatient().getId() == id)
                    .findFirst().orElse(null);
            Integer age = Period.between(
                    medicaleFile.getPatient().getDateOfBirth(),
                    LocalDate.now()
            ).getYears();
            ConsultationService  consultationService = new ConsultationService();
            req.setAttribute("age", age);
            req.setAttribute("medicalFile", medicaleFile);

            List<Consultation> consultations = consultationService.findAll().stream().filter(a -> a.getMedicalFile().getId() == medicaleFile.getId() && a.getConsultationStatus().equals(ConsultationStatus.COMPLETED)).toList();
            req.setAttribute("consultations", consultations);
            view(req,resp,"medicalFile.jsp");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
