package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;
import com.medicale.consultation.consultationmedicale.repositories.MedicalActsRepository;

import java.util.List;

public class MedicalActsService {
    private final MedicalActsRepository medicalActsRepository;

    public MedicalActsService() {
        this.medicalActsRepository = new MedicalActsRepository();
    }

    public MedicalActsService(MedicalActsRepository medicalActsRepository) {
        this.medicalActsRepository = medicalActsRepository;
    }

    public List<MedicaleAct> findAll() {
        return medicalActsRepository.findAll();
    }

    public MedicaleAct save(MedicaleAct medicaleAct) {
        return medicalActsRepository.save(medicaleAct);
    }

    public MedicaleAct findById(Long id) {
        return medicalActsRepository.findById(id);
    }

    public void delete(Long id) {
        medicalActsRepository.delete(id);
    }
}
