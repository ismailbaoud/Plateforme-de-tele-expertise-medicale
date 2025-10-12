package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.Ticket;
import com.medicale.consultation.consultationmedicale.repositories.MedicalFileRepository;

import java.util.List;

public class MedicalFileSevice {
        private final MedicalFileRepository medicalFileRepository;

        public MedicalFileSevice() {
            this.medicalFileRepository = new MedicalFileRepository();
        }

        public List<MedicaleFile> findAll() {
            return medicalFileRepository.findAll();
        }

        public void save(MedicaleFile medicaleFile) {
            medicalFileRepository.save(medicaleFile);
        }

        public void update(MedicaleFile medicaleFile) {
            medicalFileRepository.update(medicaleFile);
    }

}
