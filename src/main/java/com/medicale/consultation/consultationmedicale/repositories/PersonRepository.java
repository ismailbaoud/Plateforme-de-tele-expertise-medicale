package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.models.person.Generalist;
import com.medicale.consultation.consultationmedicale.models.person.Nurse;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import jakarta.persistence.EntityManager;

import java.util.ArrayList;
import java.util.List;

public class PersonRepository extends BaseRepository<Person> {

    public PersonRepository() {
        super(Person.class);
    }

    public List<Person> findAll() {
        EntityManager em = emf.createEntityManager();
        List<Person> allPersons = new ArrayList<>();

        try {
            allPersons.addAll(em.createQuery("SELECT n FROM Nurse n", Person.class).getResultList());
            allPersons.addAll(em.createQuery("SELECT g FROM Generalist g", Person.class).getResultList());
            allPersons.addAll(em.createQuery("SELECT s FROM Specialist s", Person.class).getResultList());
        } finally {
            em.close();
        }

        return allPersons;
    }

    public Person findByUsername(String username) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT p FROM Person p WHERE p.username = :username", Person.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (Exception e) {
            return null; // No result
        } finally {
            em.close();
        }
    }

    public void update(Person person) {
        try {
            EntityManager em = emf.createEntityManager();
            em.getTransaction().begin();
            em.merge(person);
            em.getTransaction().commit();
            em.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
