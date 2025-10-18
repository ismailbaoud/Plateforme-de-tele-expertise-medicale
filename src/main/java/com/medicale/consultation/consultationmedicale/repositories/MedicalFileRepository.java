package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import jakarta.persistence.EntityManager;
import java.util.List;

public class MedicalFileRepository extends BaseRepository<MedicaleFile> {

    public MedicalFileRepository() {
        super(MedicaleFile.class);
    }

    @Override
    public List<MedicaleFile> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT m FROM MedicaleFile m", MedicaleFile.class).getResultList();
        } finally {
            em.close();
        }
    }

    public MedicaleFile findByPatientIdWithConsultations(Long patientId) {
        EntityManager em = emf.createEntityManager();
        try {
            List<MedicaleFile> results = em.createQuery(
                    "SELECT DISTINCT m FROM MedicaleFile m " +
                    "LEFT JOIN FETCH m.consultations c " +
                    "LEFT JOIN FETCH c.patient " +
                    "WHERE c.patient.id = :patientId",
                    MedicaleFile.class)
                    .setParameter("patientId", patientId)
                    .getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
}
