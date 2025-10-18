package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.Ticket;
import jakarta.persistence.EntityManager;
import java.util.List;

public class TicketRepository extends BaseRepository<Ticket> {

    public TicketRepository() {
        super(Ticket.class);
    }

    @Override
    public List<Ticket> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT t FROM Ticket t", Ticket.class).getResultList();
        } finally {
            em.close();
        }
    }
}
