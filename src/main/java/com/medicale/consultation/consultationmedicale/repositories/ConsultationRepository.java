package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class ConsultationRepository extends BaseRepository<Consultation> {

    public ConsultationRepository() {
        super(Consultation.class);
    }

    @Override
    public List<Consultation> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery(
                "SELECT DISTINCT c FROM Consultation c " +
                "LEFT JOIN FETCH c.scheduleSlot ss " +
                "LEFT JOIN FETCH ss.specialist " +
                "LEFT JOIN FETCH c.patient", 
                Consultation.class
            ).getResultList();
        } finally {
            em.close();
        }
    }

    public void Update(Consultation consultation) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(consultation);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    public Consultation update(Consultation consultation) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Consultation updated = em.merge(consultation);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }
}