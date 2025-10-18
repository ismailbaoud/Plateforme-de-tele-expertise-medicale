package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.repositories.ConsultationRepository;

import java.util.List;

public class ConsultationService {
    private final ConsultationRepository consultationRepository;

    public ConsultationService() {
        this.consultationRepository = new ConsultationRepository();
    }

    public ConsultationService(ConsultationRepository consultationRepository) {
        this.consultationRepository = consultationRepository;
    }

    public List<Consultation> findAll() {
        return consultationRepository.findAll();
    }

    public Consultation save(Consultation consultation) {
        return consultationRepository.save(consultation);
    }

    public Consultation update(Consultation consultation) {
        return consultationRepository.update(consultation);
    }

    public Consultation findById(Long id) {
        return consultationRepository.findById(id);
    }

    public void delete(Long id) {
        consultationRepository.delete(id);
    }
}