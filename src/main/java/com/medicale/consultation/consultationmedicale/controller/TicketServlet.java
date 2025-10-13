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

    public void allTickets(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            TicketService ticketService = new TicketService();
            List<Ticket> tickets = ticketService.findAll().stream()
                    .filter(a -> a.getCreatedAt().toLocalDate().isEqual(LocalDate.now()) && a.getTicketStatus() ==  TicketStatus.PENDING)
                    .sorted(Comparator.comparing(Ticket::getCreatedAt))
                    .toList();
            req.setAttribute("tickets", tickets);
            view(req, resp, "tickets.jsp");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
