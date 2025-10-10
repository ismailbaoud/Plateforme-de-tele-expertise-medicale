package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.Ticket;
import jakarta.persistence.EntityManager;

import java.util.ArrayList;
import java.util.List;

public class TicketRepository extends BaseRepository<Ticket> {

    public TicketRepository() {
        super(Ticket.class);
    }

    public List<Ticket> findAll() {
        EntityManager em = emf.createEntityManager();
        List<Ticket> tickets = new ArrayList<>();
        tickets.addAll(em.createQuery("select t from Ticket t", Ticket.class).getResultList());
        return tickets;
    }


}
