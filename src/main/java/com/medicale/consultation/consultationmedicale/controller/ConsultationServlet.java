package com.medicale.consultation.consultationmedicale.controller;


import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.service.ConsultationService;
import com.medicale.consultation.consultationmedicale.service.MedicalFileSevice;
import com.medicale.consultation.consultationmedicale.service.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/consultation")
public class ConsultationServlet extends BaseServlet {

    public void index(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(req.getParameter("patientId"));
            PatientService patientService = new PatientService();
            Patient patient = patientService.findAll().stream().filter(a -> a.getId() == id).findFirst().get();
            req.setAttribute("patient", patient);
            view(req,resp,"consultation.jsp");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    public void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");

            Long patientId = Long.parseLong(req.getParameter("patientId"));
            PatientService patientService = new PatientService();

            Patient patient = patientService.findAll().stream()
                    .filter(a -> a.getId() == patientId)
                    .findFirst()
                    .orElse(null);

            if (patient == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                        "Patient not found with ID: " + patientId);
                return;
            }

            MedicalFileSevice medicalFileSevice = new MedicalFileSevice();
            MedicaleFile medicaleFile = medicalFileSevice.findAll().stream()
                    .filter(a -> a.getPatient().getId() == patient.getId())
                    .findFirst()
                    .orElse(null);

            if (medicaleFile == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                        "Medical file not found for patient ID: " + patientId);
                return;
            }

            Consultation consultation = new Consultation();
            consultation.setPatient(patient);
            consultation.setMedicalFile(medicaleFile);
            consultation.setReason(req.getParameter("reason"));
            consultation.setSymptoms(req.getParameter("symptoms"));
            consultation.setClinicalExam(req.getParameter("clinicalExam"));
            consultation.setDiagnosis(req.getParameter("diagnosis"));
            consultation.setObservations(req.getParameter("observations"));
            consultation.setTreatmentPlan(req.getParameter("treatmentPlan"));
            consultation.setCreatedAt(LocalDateTime.now());

            String statusParam = req.getParameter("status");
            consultation.setConsultationStatus(
                    ConsultationStatus.valueOf(statusParam)
            );

            List<MedicaleAct> medicalActs = new ArrayList<>();
            int index = 0;

            while (true) {
                String label = req.getParameter("acts[" + index + "].label");
                String priceStr = req.getParameter("acts[" + index + "].price");

                if (label == null && priceStr == null) {
                    break;
                }

                if (label != null && !label.trim().isEmpty()
                        && priceStr != null && !priceStr.trim().isEmpty()) {
                    try {
                        MedicaleAct act = new MedicaleAct();
                        act.setLabel(label.trim());
                        act.setPrice(Double.parseDouble(priceStr.trim()));
                        act.setConsultation(consultation);
                        medicalActs.add(act);

                        System.out.println("✅ Added act: " + label + " - " + priceStr + "€");
                    } catch (NumberFormatException e) {
                        System.err.println("⚠️ Invalid price format at index "
                                + index + ": " + priceStr);
                    }
                }
                index++;
            }

            System.out.println("💡 Total medical acts found: " + medicalActs.size());
            consultation.setMedicaleActs(medicalActs);

            ConsultationService consultationService = new ConsultationService();
            consultationService.save(consultation);

            resp.sendRedirect("/medicalFiles?id=" + patientId + "&creation=success");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid number format: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid consultation status: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error creating consultation: " + e.getMessage(), e);
        }
    }

}
