package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;

public class MedicalActsRepository extends BaseRepository<MedicaleAct>{

    public MedicalActsRepository(){
        super(MedicaleAct.class);
    }
}
