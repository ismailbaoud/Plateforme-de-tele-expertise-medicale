package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class ConsultationRepository extends BaseRepository<Consultation> {

    public ConsultationRepository() {
        super(Consultation.class);
    }



    public void save(Consultation consultation) {
            EntityManager em = emf.createEntityManager();
            EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(consultation);
            tx.commit();
            em.close();
        }catch (Exception e) {
            tx.rollback();
            e.printStackTrace();
        }
    }


    public List<Consultation> findAll() {
        EntityManager em = emf.createEntityManager();
        List<Consultation> consultations = em.createQuery("select c from Consultation c").getResultList();
        return consultations;
    }

    public void Update(Consultation consultation) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(consultation);
            tx.commit();
            em.close();
        }catch (Exception e) {
            tx.rollback();
        }
    }

}
