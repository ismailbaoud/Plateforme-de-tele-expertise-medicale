package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.repositories.MedicalFileRepository;

import java.util.List;

public class MedicalFileService {
    private final MedicalFileRepository medicalFileRepository;

    public MedicalFileService() {
        this.medicalFileRepository = new MedicalFileRepository();
    }

    public MedicalFileService(MedicalFileRepository medicalFileRepository) {
        this.medicalFileRepository = medicalFileRepository;
    }

    public List<MedicaleFile> findAll() {
        return medicalFileRepository.findAll();
    }

    public MedicaleFile findById(Long id) {
        return medicalFileRepository.findById(id);
    }

    public MedicaleFile findByPatientIdWithConsultations(Long patientId) {
        return medicalFileRepository.findByPatientIdWithConsultations(patientId);
    }

    public MedicaleFile save(MedicaleFile medicalFile) {
        return medicalFileRepository.save(medicalFile);
    }

    public void delete(Long id) {
        medicalFileRepository.delete(id);
    }
}

