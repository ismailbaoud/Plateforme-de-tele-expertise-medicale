package com.medicale.consultation.consultationmedicale.controller;

import com.medicale.consultation.consultationmedicale.enums.TicketStatus;
import com.medicale.consultation.consultationmedicale.models.Ticket;
import com.medicale.consultation.consultationmedicale.service.TicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;

@WebServlet("/allTickets")
public class TicketServlet extends BaseServlet {

    private final TicketService ticketService = new TicketService();

    public void index(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Ticket> tickets = ticketService.findAll().stream()
                    .filter(ticket -> ticket.getCreatedAt().toLocalDate().isEqual(LocalDate.now())
                            && (TicketStatus.ACTIVE.equals(ticket.getStatus()) || TicketStatus.PENDING.equals(ticket.getStatus())))
                    .sorted(Comparator.comparing(Ticket::getCreatedAt))
                    .toList();

            req.setAttribute("tickets", tickets);
            view(req, resp, "tickets.jsp");
        } catch (Exception e) {
            System.err.println("Error loading tickets: " + e.getMessage());
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Une erreur est survenue lors du traitement des tickets");
        }
    }
}
