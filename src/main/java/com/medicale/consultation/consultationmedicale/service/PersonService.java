package com.medicale.consultation.consultationmedicale.service;

import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.repositories.PersonRepository;

import java.util.List;

public class PersonService {

    private final PersonRepository personRepository;

    public PersonService() {
        this.personRepository = new PersonRepository();
    }

    /**
     * Get all persons (Nurses, Generalists, Specialists)
     */
    public List<Person> findAll() {
        return personRepository.findAll();
    }

    /**
     * Find person by username
     */
    public Person findByUsername(String username) {
        return personRepository.findByUsername(username);
    }

    /**
     * Save a person (insert into DB)
     */
    public void save(Person person) {
        personRepository.save(person);
    }

    /**
     * Find person by ID
     */
    public Person findById(Long id) {
        return personRepository.findById(id);
    }

    /**
     * Delete person by ID
     */
    public void delete(Long id) {
        personRepository.delete(id);
    }

    public void update(Person person) {
        personRepository.update(person);
    }
}
