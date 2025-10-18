package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import jakarta.persistence.EntityManager;
import java.util.List;

public class SpecialistRepository extends BaseRepository<Specialist> {

    public SpecialistRepository() {
        super(Specialist.class);
    }

    @Override
    public List<Specialist> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("select s from Specialist s", Specialist.class).getResultList();
        } finally {
            em.close();
        }
    }
}
