package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.ScheduleSlot;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.service.ConsultationService;
import com.medicale.consultation.consultationmedicale.service.MedicalFileSevice;
import com.medicale.consultation.consultationmedicale.service.PatientService;
import com.medicale.consultation.consultationmedicale.service.SpecialistService;
import com.medicale.consultation.consultationmedicale.service.ScheduleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/consultations")
public class ConsultationServlet extends BaseServlet {
    private final ConsultationService consultationService;
    private final PatientService patientService;
    private final SpecialistService specialistService;
    private final ScheduleService scheduleService;
    private final MedicalFileSevice medicalFileSevice;

    public ConsultationServlet() {
        this.consultationService = new ConsultationService();
        this.patientService = new PatientService();
        this.specialistService = new SpecialistService();
        this.scheduleService = new ScheduleService();
        this.medicalFileSevice = new MedicalFileSevice();
    }

    public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long patientId = Long.parseLong(request.getParameter("patientId"));
            Patient patient = patientService.findById(patientId);
            if (patient != null) {
                request.setAttribute("patient", patient);
                request.setAttribute("specialists", specialistService.findAll());
                request.setAttribute("schedules", scheduleService.findAll());
                view(request, response, "consultation.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Patient non trouvé");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de patient invalide");
        }
    }

    public void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long patientId = Long.parseLong(request.getParameter("patientId"));
            Patient patient = patientService.findById(patientId);

            if (patient == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Patient non trouvé");
                return;
            }

            String reason = request.getParameter("reason");
            if (reason == null || reason.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "La raison est requise");
                return;
            }

            // Get or create medical file for the patient
            MedicaleFile medicalFile = medicalFileSevice.findByPatientIdWithConsultations(patientId);
            if (medicalFile == null) {
                medicalFile = new MedicaleFile();
                medicalFile.setPatient(patient);
                medicalFile.setDiagnosis(request.getParameter("diagnosis") != null ? request.getParameter("diagnosis") : "");
                medicalFile.setTreatmentPlan(request.getParameter("treatmentPlan"));
                medicalFile.setNotes(request.getParameter("observations"));
                medicalFile.setCreatedAt(LocalDateTime.now());
                medicalFile = medicalFileSevice.save(medicalFile);
            }

            ConsultationStatus status = ConsultationStatus.valueOf(request.getParameter("status"));

            Consultation consultation = new Consultation();
            consultation.setPatient(patient);
            consultation.setMedicalFile(medicalFile);
            consultation.setReason(reason);
            consultation.setSymptoms(request.getParameter("symptoms"));
            consultation.setClinicalExam(request.getParameter("clinicalExam"));
            consultation.setObservations(request.getParameter("observations"));
            consultation.setDiagnosis(request.getParameter("diagnosis"));
            consultation.setTreatmentPlan(request.getParameter("treatmentPlan"));
            consultation.setConsultationStatus(status);
            consultation.setCreatedAt(LocalDateTime.now());

            // Log received data for debugging
            System.out.println("=== DEBUG CONSULTATION CREATE ===");
            System.out.println("Reason: " + reason);
            System.out.println("Symptoms: " + request.getParameter("symptoms"));
            System.out.println("Clinical Exam: " + request.getParameter("clinicalExam"));
            System.out.println("Observations: " + request.getParameter("observations"));
            System.out.println("Diagnosis: " + request.getParameter("diagnosis"));
            System.out.println("Treatment Plan: " + request.getParameter("treatmentPlan"));

            // Handle medical acts
            List<MedicaleAct> acts = new ArrayList<>();
            int actIndex = 0;
            while (request.getParameter("acts[" + actIndex + "].label") != null) {
                String label = request.getParameter("acts[" + actIndex + "].label");
                String priceStr = request.getParameter("acts[" + actIndex + "].price");
                System.out.println("Act " + actIndex + ": label=" + label + ", price=" + priceStr);
                if (label != null && !label.trim().isEmpty() && priceStr != null) {
                    MedicaleAct act = new MedicaleAct();
                    act.setLabel(label);
                    act.setPrice(Double.parseDouble(priceStr));
                    act.setConsultation(consultation);
                    acts.add(act);
                }
                actIndex++;
            }
            consultation.setMedicaleActs(acts);
            System.out.println("Total medical acts: " + acts.size());

            System.out.println("Saving consultation...");
            Consultation savedConsultation = consultationService.save(consultation);
            System.out.println("Consultation saved with ID: " + savedConsultation.getId());

            // Handle specialist if status is WAITING_SPECIALIST - AFTER saving consultation
            if (status == ConsultationStatus.WAITING_SPECIALIST) {
                String selectedSlotJson = request.getParameter("selectedSlot");
                String specialistIdStr = request.getParameter("selectedSpecialistId");

                System.out.println("Specialist ID: " + specialistIdStr);
                System.out.println("Selected Slot JSON: " + selectedSlotJson);

                if (selectedSlotJson != null && !selectedSlotJson.isEmpty() && specialistIdStr != null) {
                    try {
                        JSONObject slotData = new JSONObject(selectedSlotJson);
                        Long specialistId = Long.parseLong(specialistIdStr);

                        Specialist specialist = specialistService.findById(specialistId);
                        if (specialist != null) {
                            // Find or create the schedule slot
                            int day = slotData.getInt("day");
                            String timeStr = slotData.getString("time");
                            java.time.LocalTime time = java.time.LocalTime.parse(timeStr);

                            // Find existing slot or create new one
                            List<ScheduleSlot> allSlots = scheduleService.findAll();
                            ScheduleSlot slot = allSlots.stream()
                                .filter(s -> s.getSpecialist().getId().equals(specialistId)
                                    && s.getDay() == day
                                    && s.getTime().equals(time))
                                .findFirst()
                                .orElse(null);

                            if (slot == null) {
                                slot = new ScheduleSlot();
                                slot.setSpecialist(specialist);
                                slot.setDay(day);
                                slot.setTime(time);
                            }

                            slot.setStatus(com.medicale.consultation.consultationmedicale.enums.SlotStatus.RESERVED);
                            slot.setConsultation(savedConsultation);
                            scheduleService.save(slot);
                            System.out.println("Schedule slot saved for specialist: " + specialistId);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        // Continue without specialist if parsing fails
                    }
                }
            }

            System.out.println("=== END DEBUG ===");

            response.sendRedirect(request.getContextPath() + "/medicalFiles?id=" + patientId);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètres invalides: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la création de la consultation: " + e.getMessage());
        }
    }
}
