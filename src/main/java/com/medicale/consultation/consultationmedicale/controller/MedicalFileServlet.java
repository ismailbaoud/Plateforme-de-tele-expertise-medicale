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
public class MedicalFileServlet extends BaseServlet {
    private final MedicalFileSevice medicalFileSevice = new MedicalFileSevice();
    private final ConsultationService consultationService = new ConsultationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(req.getParameter("id"));

            // Utiliser la nouvelle méthode qui charge les consultations avec JOIN FETCH
            MedicaleFile medicaleFile = medicalFileSevice.findByPatientIdWithConsultations(id);

            // Determine patient from the first consultation if available
            var patient = (medicaleFile != null && medicaleFile.getConsultations() != null && !medicaleFile.getConsultations().isEmpty())
                    ? medicaleFile.getConsultations().get(0).getPatient()
                    : null;

            if (patient != null && patient.getDateOfBirth() != null) {
                Integer age = Period.between(
                        patient.getDateOfBirth(),
                        LocalDate.now()
                ).getYears();
                req.setAttribute("age", age);
            }

            req.setAttribute("medicalFile", medicaleFile);

            if (medicaleFile != null) {
                // Filtrer les consultations déjà chargées au lieu de faire une nouvelle requête
                List<Consultation> consultations = medicaleFile.getConsultations()
                        .stream()
                        .filter(c -> ConsultationStatus.COMPLETED.equals(c.getConsultationStatus()))
                        .toList();
                req.setAttribute("consultations", consultations);
            }

            view(req, resp, "medicalFile.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Une erreur est survenue lors du traitement de votre demande");
        }
    }
}
