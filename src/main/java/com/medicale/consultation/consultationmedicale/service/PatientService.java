package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.repositories.PatientRepository;

import java.util.List;

public class PatientService {
    PatientRepository patientRepository =  new PatientRepository();

    public List<Patient> findAll() {
        return patientRepository.findAll();
    }

}
