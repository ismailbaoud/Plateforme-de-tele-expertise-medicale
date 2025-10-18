package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.consultation.Request;
import jakarta.persistence.EntityManager;
import java.util.List;

public class ConsultationRequestRepository extends BaseRepository<Request> {

    public ConsultationRequestRepository() {
        super(Request.class);
    }

    @Override
    public List<Request> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT r FROM Request r", Request.class).getResultList();
        } finally {
            em.close();
        }
    }
}
