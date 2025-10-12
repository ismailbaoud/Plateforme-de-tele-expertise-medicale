package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.Ticket;
import com.medicale.consultation.consultationmedicale.repositories.MedicalFileRepository;
import com.medicale.consultation.consultationmedicale.repositories.TicketRepository;

import java.util.List;

public class TicketService {
    private final TicketRepository ticketRepository;

    public TicketService() {
        this.ticketRepository = new TicketRepository();
    }

    public void save(Ticket ticket) {
        ticketRepository.save(ticket);
    }

    public List<Ticket> findAll() {
        return ticketRepository.findAll();
    }
}
