package com.medicale.consultation.consultationmedicale.controller;

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

@WebServlet("/medicalFiles")
public class MedicalFileServlet extends BaseServlet{
    private final MedicalFileSevice medicalFileSevice =  new MedicalFileSevice();

    public void index(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer id = Integer.parseInt(req.getParameter("id"));
            MedicaleFile medicaleFile = medicalFileSevice.findAll()
                    .stream()
                    .filter(a -> a.getId() == id)
                    .findFirst()
                    .get();
            Integer age = Period.between(
                    medicaleFile.getPatient().getDateOfBirth(),
                    LocalDate.now()
            ).getYears();
            ConsultationService  consultationService = new ConsultationService();
            Consultation consultation = consultationService.findAll().stream().filter(a -> a.getId() == id).findFirst().get();
            System.out.println(medicaleFile.getPatient().getDateOfBirth());
            req.setAttribute("consultation", consultation);
            req.setAttribute("age", age);
            req.setAttribute("medicalFile", medicaleFile);
            view(req,resp,"medicalFile.jsp");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
