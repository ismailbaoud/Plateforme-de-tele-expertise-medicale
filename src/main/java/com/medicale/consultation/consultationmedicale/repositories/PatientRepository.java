package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Patient;
import jakarta.persistence.EntityManager;
import java.util.List;

public class PatientRepository extends BaseRepository<Patient> {

    public PatientRepository() {
        super(Patient.class);
    }

    @Override
    public List<Patient> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT p FROM Patient p", Patient.class).getResultList();
        } finally {
            em.close();
        }
    }
}
