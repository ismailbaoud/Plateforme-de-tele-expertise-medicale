package com.medicale.consultation.consultationmedicale.seeder;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.enums.Speciality;
import com.medicale.consultation.consultationmedicale.models.person.*;
import com.medicale.consultation.consultationmedicale.utils.PasswordUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.time.LocalDate;
import java.util.ArrayList;
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

            // Vérifier si des utilisateurs existent déjà
            long userCount = em.createQuery("SELECT COUNT(p) FROM Person p", Long.class).getSingleResult();

            if (userCount == 0) {
                System.out.println("📝 Seeding default users...");

                List<Person> users = new ArrayList<>();

                // === INFIRMIÈRES (NURSES) ===
                Nurse nurse1 = new Nurse(
                        null,
                        "Nora",
                        "Benali",
                        "nora",
                        PasswordUtils.hashPassword("1234"),
                        "0650000001",
                        Gender.FEMALE,
                        LocalDate.of(1998, 5, 21),
                        Role.NURSE
                );
                nurse1.setEmail("nora.benali@hospital.com");
                users.add(nurse1);

                Nurse nurse2 = new Nurse(
                        null,
                        "Fatima",
                        "Zahra",
                        "fatima",
                        PasswordUtils.hashPassword("1234"),
                        "0650000002",
                        Gender.FEMALE,
                        LocalDate.of(1995, 3, 15),
                        Role.NURSE
                );
                nurse2.setEmail("fatima.zahra@hospital.com");
                users.add(nurse2);

                // === GÉNÉRALISTES (GENERALISTS) ===
                Generalist generalist1 = new Generalist(
                        null,
                        "Amine",
                        "Tahar",
                        "amine",
                        PasswordUtils.hashPassword("1234"),
                        "0660000001",
                        Gender.MALE,
                        LocalDate.of(1985, 8, 10),
                        Role.GENERALIST,
                        "RPPS12345",
                        "123 Avenue Mohammed V",
                        "Casablanca",
                        150.0
                );
                generalist1.setEmail("amine.tahar@hospital.com");
                users.add(generalist1);

                Generalist generalist2 = new Generalist(
                        null,
                        "Leila",
                        "Alami",
                        "leila",
                        PasswordUtils.hashPassword("1234"),
                        "0660000002",
                        Gender.FEMALE,
                        LocalDate.of(1988, 11, 25),
                        Role.GENERALIST,
                        "RPPS12346",
                        "456 Rue Hassan II",
                        "Rabat",
                        140.0
                );
                generalist2.setEmail("leila.alami@hospital.com");
                users.add(generalist2);

                // === SPÉCIALISTES (SPECIALISTS) ===
                Specialist specialist1 = new Specialist(
                        null,
                        "Amina",
                        "Tahari",
                        "amina",
                        PasswordUtils.hashPassword("1234"),
                        "0670000001",
                        Gender.FEMALE,
                        LocalDate.of(1980, 6, 5),
                        Role.SPECIALIST,
                        "RPPS54321",
                        Speciality.CARDIOLOGY,
                        250.0
                );
                specialist1.setEmail("amina.tahari@hospital.com");
                users.add(specialist1);

                Specialist specialist2 = new Specialist(
                        null,
                        "Youssef",
                        "Benjelloun",
                        "youssef",
                        PasswordUtils.hashPassword("1234"),
                        "0670000002",
                        Gender.MALE,
                        LocalDate.of(1982, 4, 18),
                        Role.SPECIALIST,
                        "RPPS54322",
                        Speciality.NEUROLOGY,
                        280.0
                );
                specialist2.setEmail("youssef.benjelloun@hospital.com");
                users.add(specialist2);

                Specialist specialist3 = new Specialist(
                        null,
                        "Sara",
                        "Mansouri",
                        "sara",
                        PasswordUtils.hashPassword("1234"),
                        "0670000003",
                        Gender.FEMALE,
                        LocalDate.of(1987, 9, 22),
                        Role.SPECIALIST,
                        "RPPS54323",
                        Speciality.DERMATOLOGY,
                        220.0
                );
                specialist3.setEmail("sara.mansouri@hospital.com");
                users.add(specialist3);

                // === PATIENTS ===
                Patient patient1 = new Patient(
                        null,
                        "Mohammed",
                        "Alaoui",
                        "mohammed",
                        PasswordUtils.hashPassword("1234"),
                        "0680000001",
                        Gender.MALE,
                        LocalDate.of(2000, 1, 1),
                        Role.PATIENT,
                        "DOS001",
                        LocalDate.of(1990, 7, 15),
                        175.0,
                        75.0
                );
                patient1.setEmail("mohammed.alaoui@email.com");
                patient1.setBloodType("O+");
                users.add(patient1);

                Patient patient2 = new Patient(
                        null,
                        "Khadija",
                        "Benjelloun",
                        "khadija",
                        PasswordUtils.hashPassword("1234"),
                        "0680000002",
                        Gender.FEMALE,
                        LocalDate.of(2000, 1, 1),
                        Role.PATIENT,
                        "DOS002",
                        LocalDate.of(1992, 3, 20),
                        165.0,
                        60.0
                );
                patient2.setEmail("khadija.benjelloun@email.com");
                patient2.setBloodType("A+");
                users.add(patient2);

                Patient patient3 = new Patient(
                        null,
                        "Hassan",
                        "Tazi",
                        "hassan",
                        PasswordUtils.hashPassword("1234"),
                        "0680000003",
                        Gender.MALE,
                        LocalDate.of(2000, 1, 1),
                        Role.PATIENT,
                        "DOS003",
                        LocalDate.of(1985, 11, 8),
                        180.0,
                        82.0
                );
                patient3.setEmail("hassan.tazi@email.com");
                patient3.setBloodType("B+");
                users.add(patient3);

                // Persister tous les utilisateurs
                for (Person user : users) {
                    em.persist(user);
                }

                em.getTransaction().commit();

                System.out.println("✅ " + users.size() + " users created successfully!");
                System.out.println("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
                System.out.println("📋 DEFAULT USERS CREDENTIALS:");
                System.out.println("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
                System.out.println("👩‍⚕️ NURSES:");
                System.out.println("   • Username: nora     | Password: 1234");
                System.out.println("   • Username: fatima   | Password: 1234");
                System.out.println("");
                System.out.println("👨‍⚕️ GENERALISTS:");
                System.out.println("   • Username: amine    | Password: 1234");
                System.out.println("   • Username: leila    | Password: 1234");
                System.out.println("");
                System.out.println("🩺 SPECIALISTS:");
                System.out.println("   • Username: amina    | Password: 1234 (Cardiology)");
                System.out.println("   • Username: youssef  | Password: 1234 (Neurology)");
                System.out.println("   • Username: sara     | Password: 1234 (Dermatology)");
                System.out.println("");
                System.out.println("🧑‍🦱 PATIENTS:");
                System.out.println("   • Username: mohammed | Password: 1234");
                System.out.println("   • Username: khadija  | Password: 1234");
                System.out.println("   • Username: hassan   | Password: 1234");
                System.out.println("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

            } else {
                System.out.println("ℹ️  Users already exist, skipping seeding.");
                em.getTransaction().rollback();
            }

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("❌ Error during database seeding:");
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (emf != null && emf.isOpen()) {
            emf.close();
            System.out.println("🔌 EntityManagerFactory closed.");
        }
    }
}
