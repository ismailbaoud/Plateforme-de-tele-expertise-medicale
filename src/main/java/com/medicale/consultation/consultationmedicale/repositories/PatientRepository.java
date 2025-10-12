package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.models.person.Person;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class PatientRepository extends BaseRepository<Patient> {

    public PatientRepository() {

        super(Patient.class);
    }

    public void save(Patient patient) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(patient);
        em.getTransaction().commit();
    }


    public List<Patient> findAll() {
        EntityManager em = emf.createEntityManager();
        TypedQuery<Patient> query = em.createQuery("SELECT p FROM Patient p", Patient.class);;
        return query.getResultList();
    }

}
