package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.GeneralRequest;
import jakarta.persistence.EntityManager;
import java.util.List;

public class GeneralRequestRepository extends BaseRepository<GeneralRequest> {

    public GeneralRequestRepository() {
        super(GeneralRequest.class);
    }

    @Override
    public List<GeneralRequest> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("select r from GeneralRequest r", GeneralRequest.class).getResultList();
        } finally {
            em.close();
        }
    }
}
