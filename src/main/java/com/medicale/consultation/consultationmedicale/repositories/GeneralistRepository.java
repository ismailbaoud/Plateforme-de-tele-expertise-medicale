package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Nurse;
import com.medicale.consultation.consultationmedicale.models.person.Generalist;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class GeneralistRepository extends BaseRepository<Generalist> {

    public GeneralistRepository() {
        super(Generalist.class);
    }


}
