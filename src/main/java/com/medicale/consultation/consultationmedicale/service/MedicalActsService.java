package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;
import com.medicale.consultation.consultationmedicale.repositories.MedicalActsRepository;

public class MedicalActsService {
    MedicalActsRepository medicalActsRepository = new MedicalActsRepository();
    public void save(MedicaleAct ma){
        medicalActsRepository.save(ma);
    }
}
