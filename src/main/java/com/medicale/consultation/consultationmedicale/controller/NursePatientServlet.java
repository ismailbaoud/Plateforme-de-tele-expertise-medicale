package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.service.ConsultationService;
import com.medicale.consultation.consultationmedicale.service.MedicalFileService;
import com.medicale.consultation.consultationmedicale.service.PatientService;
import com.medicale.consultation.consultationmedicale.utils.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/nurse/patients")
public class NursePatientServlet extends HttpServlet {
    private PatientService patientService;
    private MedicalFileService medicalFileService;
    private ConsultationService consultationService;

    @Override
    public void init() throws ServletException {
        patientService = new PatientService();
        medicalFileService = new MedicalFileService();
        consultationService = new ConsultationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            action = "list";
        }

        switch (action) {
            case "list":
                listPatients(request, response);
                break;
            case "view":
                viewPatientDetails(request, response);
                break;
            case "search":
                searchPatients(request, response);
                break;
            default:
                listPatients(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            registerPatient(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/nurse/patients");
        }
    }

    private void listPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Patient> patients = patientService.findAll();
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/WEB-INF/views/nursePatients.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des patients: " + e.getMessage());
            request.setAttribute("patients", List.of());
            request.getRequestDispatcher("/WEB-INF/views/nursePatients.jsp").forward(request, response);
        }
    }

    private void viewPatientDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String patientIdStr = request.getParameter("id");

        if (patientIdStr == null || patientIdStr.isEmpty()) {
            listPatients(request, response);
            return;
        }

        try {
            Long patientId = Long.parseLong(patientIdStr);
            Patient patient = patientService.findById(patientId);

            if (patient == null) {
                request.setAttribute("infoMessage", "Patient non trouvé.");
                listPatients(request, response);
                return;
            }

            // Récupérer les dossiers médicaux du patient
            List<MedicaleFile> allMedicalFiles = medicalFileService.findAll();
            List<MedicaleFile> patientFiles = allMedicalFiles.stream()
                    .filter(file -> file.getPatient() != null &&
                           file.getPatient().getId().equals(patientId))
                    .collect(Collectors.toList());

            // Récupérer toutes les consultations du patient
            List<Consultation> allConsultations = consultationService.findAll();
            List<Consultation> patientConsultations = allConsultations.stream()
                    .filter(consultation -> consultation.getPatient() != null &&
                           consultation.getPatient().getId().equals(patientId))
                    .collect(Collectors.toList());

            request.setAttribute("patient", patient);
            request.setAttribute("medicalFiles", patientFiles);
            request.setAttribute("consultations", patientConsultations);
            request.getRequestDispatcher("/WEB-INF/views/nursePatientDetails.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("infoMessage", "ID patient invalide.");
            listPatients(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des détails: " + e.getMessage());
            listPatients(request, response);
        }
    }

    private void registerPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Récupérer les données du formulaire
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String genderStr = request.getParameter("gender");

            // Validation des champs obligatoires
            if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                genderStr == null || genderStr.trim().isEmpty()) {

                request.setAttribute("error", "Tous les champs obligatoires doivent être remplis.");
                listPatients(request, response);
                return;
            }

            // Créer un nouveau patient
            Patient patient = new Patient();
            patient.setFirstName(firstName.trim());
            patient.setLastName(lastName.trim());
            patient.setUsername(username.trim());
            patient.setPassword(PasswordUtils.hashPassword(password)); // Hasher le mot de passe
            patient.setEmail(email.trim());
            patient.setPhone(phone != null && !phone.trim().isEmpty() ? phone.trim() : null);
            patient.setGender(Gender.valueOf(genderStr));
            patient.setCreatedAt(LocalDate.now());
            patient.setRole(Role.PATIENT);

            // Sauvegarder le patient
            Patient savedPatient = patientService.save(patient);

            // Rediriger avec un message de succès
            request.setAttribute("successMessage",
                "Patient " + savedPatient.getFirstName() + " " + savedPatient.getLastName() +
                " enregistré avec succès !");
            listPatients(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Genre invalide. Veuillez sélectionner Homme ou Femme.");
            listPatients(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de l'enregistrement du patient: " + e.getMessage());
            listPatients(request, response);
        }
    }

    private void searchPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String query = request.getParameter("query");

        try {
            List<Patient> allPatients = patientService.findAll();
            List<Patient> filteredPatients = allPatients.stream()
                    .filter(patient -> {
                        if (query == null || query.trim().isEmpty()) {
                            return false;
                        }
                        String searchLower = query.toLowerCase().trim();
                        String fullName = (patient.getFirstName() + " " + patient.getLastName()).toLowerCase();
                        return fullName.contains(searchLower) ||
                               patient.getFirstName().toLowerCase().contains(searchLower) ||
                               patient.getLastName().toLowerCase().contains(searchLower) ||
                               (patient.getEmail() != null && patient.getEmail().toLowerCase().contains(searchLower));
                    })
                    .limit(10) // Limiter à 10 résultats
                    .collect(Collectors.toList());

            // Construire la réponse JSON manuellement
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < filteredPatients.size(); i++) {
                Patient p = filteredPatients.get(i);
                if (i > 0) json.append(",");
                json.append("{")
                    .append("\"id\":").append(p.getId()).append(",")
                    .append("\"firstName\":\"").append(escapeJson(p.getFirstName())).append("\",")
                    .append("\"lastName\":\"").append(escapeJson(p.getLastName())).append("\",")
                    .append("\"username\":\"").append(escapeJson(p.getUsername())).append("\",")
                    .append("\"email\":\"").append(escapeJson(p.getEmail() != null ? p.getEmail() : "")).append("\",")
                    .append("\"phone\":\"").append(escapeJson(p.getPhone() != null ? p.getPhone() : "")).append("\",")
                    .append("\"gender\":\"").append(p.getGender() != null ? p.getGender().toString() : "").append("\"")
                    .append("}");
            }
            json.append("]");

            response.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
