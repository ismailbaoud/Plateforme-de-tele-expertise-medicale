package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.repositories.ConsultationRepository;

import java.util.List;

public class ConsultationService {
    private final ConsultationRepository consultationRepository = new ConsultationRepository();

    public void save(Consultation consultation) {
        consultationRepository.save(consultation);
    }

    public List<Consultation> findAll() {
        return consultationRepository.findAll();
    }

    public Consultation findById(Long id) {
        return consultationRepository.findById(id);
    }

    public void update(Consultation consultation) {
        consultationRepository.Update(consultation);
    }
}
