package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Nurse;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class SpecialistRepository extends BaseRepository<Specialist> {

    public SpecialistRepository() {
        super(Specialist.class);
    }

    public Nurse findByUsernameAndPassword(String username, String password) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Nurse> query = em.createQuery(
                    "SELECT s FROM Specialist s WHERE s.username = :username AND s.password = :password",
                    Nurse.class
            );
            query.setParameter("username", username);
            query.setParameter("password", password);

            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
