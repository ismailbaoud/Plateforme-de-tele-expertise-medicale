package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;
import jakarta.persistence.EntityManager;
import java.util.List;

public class MedicalActsRepository extends BaseRepository<MedicaleAct> {

    public MedicalActsRepository() {
        super(MedicaleAct.class);
    }

    @Override
    public List<MedicaleAct> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT m FROM MedicaleAct m", MedicaleAct.class).getResultList();
        } finally {
            em.close();
        }
    }
}
