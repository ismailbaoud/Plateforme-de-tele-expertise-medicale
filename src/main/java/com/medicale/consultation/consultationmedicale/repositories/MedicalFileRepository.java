package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.Ticket;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import jakarta.persistence.EntityManager;

import java.util.List;

public class MedicalFileRepository extends BaseRepository<MedicaleFile>{

    public MedicalFileRepository() {
        super(MedicaleFile.class);
    }

    public void save(MedicaleFile medicaleFile) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(medicaleFile);
        em.getTransaction().commit();
    }


    public List<MedicaleFile> findAll() {
        EntityManager em = emf.createEntityManager();
        List<MedicaleFile> tickets =em.createQuery("select t from MedicaleFile t order by t.id").getResultList();
        return tickets;
    }

}
