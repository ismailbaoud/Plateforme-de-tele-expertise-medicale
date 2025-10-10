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
//
//        /**
//         * Get all persons (Nurses, Generalists, Specialists)
//         */
//        public List<Person> findAll() {
//            return medicalFileRepository.findAll();
//        }
//
//        /**
//         * Find person by username
//         */
//public Person findByUsername(String username) {
//    return medicalFileRepository.findByUsername(username);
//}
        public List<MedicaleFile> findAll() {
            return medicalFileRepository.findAll();
        }

        /**
         * Save a person (insert into DB)
         */
        public void save(MedicaleFile medicaleFile) {
            medicalFileRepository.save(medicaleFile);
        }
//
//        /**
//         * Find person by ID
//         */
//        public Person findById(Long id) {
//            return medicalFileRepository.findById(id);
//        }
//
//        /**
//         * Delete person by ID
//         */
//        public void delete(Long id) {
//            medicalFileRepository.delete(id);
//        }

}
