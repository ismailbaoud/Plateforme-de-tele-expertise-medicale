package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.enums.TicketStatus;
import com.medicale.consultation.consultationmedicale.models.Ticket;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.service.PatientService;
import com.medicale.consultation.consultationmedicale.service.TicketService;
import com.medicale.consultation.consultationmedicale.utils.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/nurse/dashboard")
public class NurseDashboardServlet extends HttpServlet {
    private PatientService patientService;
    private TicketService ticketService;

    @Override
    public void init() throws ServletException {
        patientService = new PatientService();
        ticketService = new TicketService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Récupérer tous les patients et tickets
            List<Patient> allPatients = patientService.findAll();
            List<Ticket> allTickets = ticketService.findAll();
            
            // Filtrer les tickets par statut
            List<Ticket> activeTickets = allTickets.stream()
                    .filter(t -> t.getStatus() == TicketStatus.ACTIVE)
                    .collect(Collectors.toList());
            
            List<Ticket> usedTickets = allTickets.stream()
                    .filter(t -> t.getStatus() == TicketStatus.USED)
                    .collect(Collectors.toList());
            
            List<Ticket> expiredTickets = allTickets.stream()
                    .filter(t -> t.getStatus() == TicketStatus.EXPIRED)
                    .collect(Collectors.toList());
            
            // Statistiques
            request.setAttribute("totalPatients", allPatients.size());
            request.setAttribute("totalTickets", allTickets.size());
            request.setAttribute("activeTicketsCount", activeTickets.size());
            request.setAttribute("usedTicketsCount", usedTickets.size());
            request.setAttribute("expiredTicketsCount", expiredTickets.size());
            
            // Données pour affichage
            request.setAttribute("patients", allPatients);
            request.setAttribute("tickets", allTickets);
            request.setAttribute("activeTickets", activeTickets);
            
            request.getRequestDispatcher("/WEB-INF/views/nurseDashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement du dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/nurseDashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "addPatient":
                    addPatient(request, response);
                    break;
                case "addTicket":
                    addTicket(request, response);
                    break;
                case "searchPatient":
                    searchPatient(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/nurse/dashboard");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void addPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String genderStr = request.getParameter("gender");

            // Validation
            if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                genderStr == null || genderStr.trim().isEmpty()) {
                
                request.setAttribute("error", "Tous les champs obligatoires doivent être remplis.");
                doGet(request, response);
                return;
            }

            // Créer le patient
            Patient patient = new Patient();
            patient.setFirstName(firstName.trim());
            patient.setLastName(lastName.trim());
            patient.setUsername(username.trim());
            patient.setPassword(password != null && !password.isEmpty() ? 
                               PasswordUtils.hashPassword(password) : 
                               PasswordUtils.hashPassword("password123"));
            patient.setEmail(email.trim());
            patient.setPhone(phone != null && !phone.trim().isEmpty() ? phone.trim() : null);
            patient.setGender(Gender.valueOf(genderStr));
            patient.setCreatedAt(LocalDate.now());
            patient.setRole(Role.PATIENT);

            Patient savedPatient = patientService.save(patient);
            
            request.setAttribute("successMessage", 
                "Patient " + savedPatient.getFirstName() + " " + savedPatient.getLastName() + 
                " ajouté avec succès !");
            
            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de l'ajout du patient: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void addTicket(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String patientIdStr = request.getParameter("patientId");
            
            if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
                request.setAttribute("error", "Veuillez sélectionner un patient.");
                doGet(request, response);
                return;
            }

            Long patientId = Long.parseLong(patientIdStr);
            Patient patient = patientService.findById(patientId);
            
            if (patient == null) {
                request.setAttribute("error", "Patient non trouvé.");
                doGet(request, response);
                return;
            }

            // Créer le ticket
            Ticket ticket = new Ticket();
            ticket.setPatient(patient);
            ticket.setStatus(TicketStatus.ACTIVE);
            ticket.setCreatedAt(LocalDateTime.now());
            
            // Générer le numéro de ticket
            String ticketNumber = generateTicketNumber();
            ticket.setTicketNumber(ticketNumber);

            ticketService.save(ticket);
            
            request.setAttribute("successMessage", 
                "Ticket N° " + ticketNumber + " créé pour " + 
                patient.getFirstName() + " " + patient.getLastName());
            
            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de la création du ticket: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void searchPatient(HttpServletRequest request, HttpServletResponse response)
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
                    .limit(10)
                    .collect(Collectors.toList());
            
            // Construire JSON
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < filteredPatients.size(); i++) {
                Patient p = filteredPatients.get(i);
                if (i > 0) json.append(",");
                json.append("{")
                    .append("\"id\":").append(p.getId()).append(",")
                    .append("\"firstName\":\"").append(escapeJson(p.getFirstName())).append("\",")
                    .append("\"lastName\":\"").append(escapeJson(p.getLastName())).append("\",")
                    .append("\"email\":\"").append(escapeJson(p.getEmail() != null ? p.getEmail() : "")).append("\",")
                    .append("\"phone\":\"").append(escapeJson(p.getPhone() != null ? p.getPhone() : "")).append("\"")
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

    private String generateTicketNumber() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        return "T" + now.format(formatter) + String.format("%03d", (int)(Math.random() * 1000));
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

