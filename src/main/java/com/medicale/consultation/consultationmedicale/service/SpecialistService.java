package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.repositories.SpecialistRepository;

import java.util.List;

public class SpecialistService {
    private final SpecialistRepository specialistRepository;

    public SpecialistService() {
        this.specialistRepository = new SpecialistRepository();
    }

    public SpecialistService(SpecialistRepository specialistRepository) {
        this.specialistRepository = specialistRepository;
    }

    public void save(Specialist specialist) {
        specialistRepository.save(specialist);
    }

    public List<Specialist> findAll() {
        return specialistRepository.findAll();
    }

    public Specialist findById(Long id) {
        return specialistRepository.findById(id);
    }
}
