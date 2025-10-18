package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.GeneralRequest;
import com.medicale.consultation.consultationmedicale.repositories.GeneralRequestRepository;

import java.util.List;

public class GeneralRequestService {
    private final GeneralRequestRepository requestRepository;

    public GeneralRequestService() {
        this.requestRepository = new GeneralRequestRepository();
    }

    public GeneralRequestService(GeneralRequestRepository requestRepository) {
        this.requestRepository = requestRepository;
    }

    public void save(GeneralRequest request) {
        requestRepository.save(request);
    }

    public List<GeneralRequest> findAll() {
        return requestRepository.findAll();
    }
}
