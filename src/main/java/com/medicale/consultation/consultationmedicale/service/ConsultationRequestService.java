package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.consultation.Request;
import com.medicale.consultation.consultationmedicale.repositories.ConsultationRequestRepository;

import java.util.List;

public class ConsultationRequestService {
    private final ConsultationRequestRepository requestRepository;

    public ConsultationRequestService() {
        this.requestRepository = new ConsultationRequestRepository();
    }

    public ConsultationRequestService(ConsultationRequestRepository requestRepository) {
        this.requestRepository = requestRepository;
    }

    public void save(Request request) {
        requestRepository.save(request);
    }

    public List<Request> findAll() {
        return requestRepository.findAll();
    }
}
