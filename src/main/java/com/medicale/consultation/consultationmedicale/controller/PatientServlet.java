package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.Ticket;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/savePatientOrVitals")
public class PatientServlet extends BaseServlet {

    public void findPatient(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MedicalFileSevice medicalFileSevice = new MedicalFileSevice();
        try {
            String fullName = req.getParameter("fullName");
            String firstName = fullName.split(" ")[0];
            String lastName = fullName.split(" ")[1];
            MedicaleFile medicaleFile = medicalFileSevice.findAll().stream()
                    .filter(p -> p.getPatient().getFirstName().trim().equalsIgnoreCase(firstName.trim())
                            && p.getPatient().getLastName().trim().equalsIgnoreCase(lastName.trim()))
                    .findFirst()
                    .orElse(null);
            if(medicaleFile == null) {
                view(req, resp, "patientAdd.jsp");
                return;
            }

            req.setAttribute("medicalFile", medicaleFile);
            view(req, resp, "patientAdd.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de l'enregistrement du patient !");
            req.getRequestDispatcher("/dashboard").forward(req, resp);
        }
    }

    public void createPatient(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PersonService personService = new PersonService();
        MedicalFileSevice medicalFileSevice = new MedicalFileSevice();
        TicketService ticketService = new TicketService();
        ConsultationService consultationService = new ConsultationService();

        try {
            Patient patient = new Patient();
            patient.setFirstName(req.getParameter("firstName"));
            patient.setLastName(req.getParameter("lastName"));
            patient.setDateOfBirth(LocalDate.parse(req.getParameter("dateOfBirth")));
            patient.setEmail(req.getParameter("email"));
            patient.setRole(Role.PATIENT);
            patient.setPhone(req.getParameter("phone"));
            patient.setCreatedAt(LocalDate.now());
            patient.setWeight(Double.parseDouble(req.getParameter("weight")));
            patient.setHeight(Double.parseDouble(req.getParameter("height")));
            patient.setDossierNumber(req.getParameter("dossierNumber"));
            patient.setPassword("1234");
            System.out.println(patient.getWeight());
            System.out.println(patient.getHeight());
            personService.save(patient);


            MedicaleFile medicaleFile = new MedicaleFile();
            medicaleFile.setPatient(patient);
            medicaleFile.setTemperature(Double.parseDouble(req.getParameter("temperature")));
            medicaleFile.setPulse(Integer.parseInt(req.getParameter("pulse")));
            medicaleFile.setBloodPresure(Integer.parseInt(req.getParameter("bloodPressure")));
            medicaleFile.setRespiratoryRate(Integer.parseInt(req.getParameter("respiratoryRate")));
            medicaleFile.setOxygenSaturation(Integer.parseInt(req.getParameter("oxygenSaturation")));
            medicaleFile.setPain(Integer.parseInt(req.getParameter("pain")));
            medicalFileSevice.save(medicaleFile);

            Ticket ticket = new Ticket();
            ticket.setCreatedAt(LocalDateTime.now());
            ticket.setPatient(patient);
            ticketService.save(ticket);

            Consultation consultation = new Consultation();
            consultation.setCreatedAt(LocalDateTime.now());
            consultation.setConsultationStatus(ConsultationStatus.CREATED);
            consultation.setMedicalFile(medicaleFile);
            consultationService.save(consultation);

            view(req, resp, "patientAdd.jsp");



        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public void updatePatient(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PersonService personService = new PersonService();
        MedicalFileSevice medicalFileSevice = new MedicalFileSevice();
        TicketService ticketService = new TicketService();
        try {
            Long fileId = Long.parseLong(req.getParameter("id"));
            MedicaleFile medicaleFile = medicalFileSevice.findAll().stream().filter(a -> a.getPatient().getId() == fileId).findFirst().orElse(null);

            if (medicaleFile == null) {
                req.setAttribute("error", "Dossier médical introuvable !");
                view(req, resp, "patientAdd.jsp");
                return;
            }

            Patient patient = medicaleFile.getPatient();
            patient.setFirstName(req.getParameter("firstName"));
            patient.setLastName(req.getParameter("lastName"));
            patient.setEmail(req.getParameter("email"));
            patient.setPhone(req.getParameter("phone"));
            patient.setDateOfBirth(LocalDate.parse(req.getParameter("dateOfBirth")));
            patient.setWeight(Double.parseDouble(req.getParameter("weight")));
            patient.setHeight(Double.parseDouble(req.getParameter("height")));
            patient.setDossierNumber(req.getParameter("dossierNumber"));
            personService.update(patient);

            Ticket ticket = new Ticket();
            ticket.setCreatedAt(LocalDateTime.now());
            ticket.setPatient(patient);
            ticketService.save(ticket);

            medicaleFile.setTemperature(Double.parseDouble(req.getParameter("temperature")));
            medicaleFile.setPulse(Integer.parseInt(req.getParameter("pulse")));
            medicaleFile.setBloodPresure(Integer.parseInt(req.getParameter("bloodPressure")));
            medicaleFile.setRespiratoryRate(Integer.parseInt(req.getParameter("respiratoryRate")));
            medicaleFile.setOxygenSaturation(Integer.parseInt(req.getParameter("oxygenSaturation")));
            medicaleFile.setPain(Integer.parseInt(req.getParameter("pain")));

            medicalFileSevice.update(medicaleFile);

            req.setAttribute("medicalFile", medicaleFile);
            req.setAttribute("success", "Patient mis à jour avec succès !");
            view(req, resp, "patientAdd.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la mise à jour du patient !");
            view(req, resp, "patientAdd.jsp");
        }
    }
}
