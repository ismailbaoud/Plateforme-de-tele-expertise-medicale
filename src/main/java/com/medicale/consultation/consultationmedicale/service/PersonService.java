package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.repositories.PersonRepository;

import java.util.List;

public class PersonService {

    private final PersonRepository personRepository;

    public PersonService() {
        this.personRepository = new PersonRepository();
    }

    public List<Person> findAll() {
        return personRepository.findAll();
    }

    public void save(Person person) {
        personRepository.save(person);
    }

    public void update(Person person) {
        personRepository.update(person);
    }
}
