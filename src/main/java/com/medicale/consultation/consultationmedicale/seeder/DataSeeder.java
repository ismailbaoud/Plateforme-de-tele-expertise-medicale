package com.medicale.consultation.consultationmedicale.seeder;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.enums.Speciality;
import com.medicale.consultation.consultationmedicale.models.person.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.time.LocalDate;
import java.util.List;

@WebListener
public class DataSeeder implements ServletContextListener {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("MyPU");

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("🚀 Running Database Seeder...");

        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();

            long userCount = em.createQuery("SELECT COUNT(p) FROM Nurse p", Long.class).getSingleResult()
                    + em.createQuery("SELECT COUNT(p) FROM Generalist p", Long.class).getSingleResult()
                    + em.createQuery("SELECT COUNT(p) FROM Specialist p", Long.class).getSingleResult();

            if (userCount == 0) {
                System.out.println(" Seeding default users...");

                // === NURSE ===
                Nurse nurse = new Nurse(
                        0,
                        "Nora",
                        "Benali",
                        "nora",
                        "1234",
                        "0650000001",
                        Gender.FEMALE,
                        LocalDate.of(1998, 5, 21),
                        Role.NURSE
                );
                nurse.setEmail("nora.nurse@hospital.com");

                // === GENERALIST ===
                Generalist generalist = new Generalist(
                        0,
                        "Amine",
                        "Tahar",
                        "amine",
                        "1234",
                        "hhh",
                        Gender.MALE,
                        LocalDate.now(),
                        Role.GENERALIST,
                        "hhhh",
                        "uuuuu0",
                        "kkkkk",
                        122.2
                );
                generalist.setEmail("amine.generalist@hospital.com");

                // === SPECIALIST ===
                Specialist specialist = new Specialist(
                        0,
                        "Amina",
                        "Tahari",
                        "amina",
                        "1234",
                        "hhh",
                        Gender.MALE,
                        LocalDate.now(),
                        Role.SPECIALIST,
                        "hhhh",
                        Speciality.ANESTHESIOLOGY,
                        200               );
                specialist.setEmail("sara.specialist@hospital.com");

                List<Person> people = List.of(nurse, generalist, specialist);
                for (Person p : people) {
                    em.persist(p);
                }

                System.out.println(" 4 users added successfully to database.");
            } else {
                System.out.println(" Users already exist, skipping seeding.");
            }

            em.getTransaction().commit();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        emf.close();
        System.out.println(" EntityManagerFactory closed.");
    }
}
