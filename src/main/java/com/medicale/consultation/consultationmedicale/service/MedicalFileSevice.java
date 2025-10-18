package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.repositories.MedicalFileRepository;

import java.util.List;

public class MedicalFileSevice {
    private final MedicalFileRepository medicalFileRepository;

    public MedicalFileSevice() {
        this.medicalFileRepository = new MedicalFileRepository();
    }

    public MedicalFileSevice(MedicalFileRepository medicalFileRepository) {
        this.medicalFileRepository = medicalFileRepository;
    }

    public List<MedicaleFile> findAll() {
        return medicalFileRepository.findAll();
    }

    public MedicaleFile save(MedicaleFile medicaleFile) {
        return medicalFileRepository.save(medicaleFile);
    }

    public MedicaleFile findById(Long id) {
        return medicalFileRepository.findById(id);
    }

    public void delete(Long id) {
        medicalFileRepository.delete(id);
    }

    public MedicaleFile findByPatientIdWithConsultations(Long patientId) {
        return medicalFileRepository.findByPatientIdWithConsultations(patientId);
    }
}
