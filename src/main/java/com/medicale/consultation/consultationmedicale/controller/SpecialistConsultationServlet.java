package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.service.ConsultationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/specialist/consultations")
public class SpecialistConsultationServlet extends BaseServlet {

    private final ConsultationService consultationService;

    public SpecialistConsultationServlet() {
        this.consultationService = new ConsultationService();
    }

    public void index(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Person user = (Person) req.getSession().getAttribute("user");
            if (user == null || !(user instanceof Specialist)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
                return;
            }

            Specialist specialist = (Specialist) user;
            
            // Récupérer toutes les consultations pour ce spécialiste
            List<Consultation> allConsultations = consultationService.findAll();
            List<Consultation> specialistConsultations = allConsultations.stream()
                    .filter(c -> c.getSpecialist() != null && c.getSpecialist().getId().equals(specialist.getId()))
                    .toList();

            System.out.println("Loading consultations for specialist ID: " + specialist.getId());
            System.out.println("Found " + specialistConsultations.size() + " consultations");

            req.setAttribute("consultations", specialistConsultations);
            req.setAttribute("specialist", specialist);
            view(req, resp, "specialistConsultations.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error loading consultations: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors du chargement des consultations");
        }
    }

    public void respond(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Person user = (Person) req.getSession().getAttribute("user");
            if (user == null || !(user instanceof Specialist)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
                return;
            }

            Long consultationId = Long.parseLong(req.getParameter("consultationId"));
            String expertOpinion = req.getParameter("expertOpinion");
            String recommendations = req.getParameter("recommendations");

            Consultation consultation = consultationService.findById(consultationId);
            
            if (consultation == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Consultation non trouvée");
                return;
            }

            // Vérifier que c'est bien le spécialiste assigné
            Specialist specialist = (Specialist) user;
            if (!consultation.getSpecialist().getId().equals(specialist.getId())) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Vous n'êtes pas assigné à cette consultation");
                return;
            }

            // Mettre à jour la consultation avec la réponse
            consultation.setExpertOpinion(expertOpinion);
            consultation.setRecommendations(recommendations);
            consultation.setStatus(ConsultationStatus.COMPLETED);
            consultation.setUpdatedAt(LocalDateTime.now());

            consultationService.update(consultation);

            System.out.println("Consultation " + consultationId + " updated by specialist " + specialist.getId());

            // Rediriger vers la liste des consultations avec un message de succès
            req.getSession().setAttribute("successMessage", "Réponse envoyée avec succès");
            resp.sendRedirect(req.getContextPath() + "/specialist/consultations");

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de consultation invalide");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error responding to consultation: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de l'enregistrement de la réponse");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            index(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("respond".equals(action)) {
            respond(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}

