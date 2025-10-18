-- Script pour insérer les utilisateurs de test avec le bon hash BCrypt
USE hospital;

SET FOREIGN_KEY_CHECKS = 0;

-- Hash BCrypt pour le mot de passe "1234"
SET @password_hash = '$2a$12$GXWeoiXrp5w02qodZ.7lUeY8oOkFw0nuBlocBdUK6fDkWnMMpfvkm';

-- Insérer Nora (Nurse)
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES ('Nora', 'Benali', 'nora', @password_hash, '0650000001', 'nora.benali@hospital.com', 'FEMALE', '1998-05-21', 'NURSE', 'NURSE');
SET @nora_id = LAST_INSERT_ID();
INSERT INTO nurses (id) VALUES (@nora_id);

-- Insérer Fatima (Nurse)
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES ('Fatima', 'Zahra', 'fatima', @password_hash, '0650000002', 'fatima.zahra@hospital.com', 'FEMALE', '1995-03-15', 'NURSE', 'NURSE');
SET @fatima_id = LAST_INSERT_ID();
INSERT INTO nurses (id) VALUES (@fatima_id);

-- Insérer Amine (Generalist)
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES ('Amine', 'Tahar', 'amine', @password_hash, '0660000001', 'amine.tahar@hospital.com', 'MALE', '1985-08-10', 'GENERALIST', 'generalists');
SET @amine_id = LAST_INSERT_ID();
INSERT INTO generalists (id, numero_RPPS, address, city, fee)
VALUES (@amine_id, 'RPPS12345', '123 Avenue Mohammed V', 'Casablanca', 150.0);

-- Insérer Leila (Generalist)
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES ('Leila', 'Alami', 'leila', @password_hash, '0660000002', 'leila.alami@hospital.com', 'FEMALE', '1988-11-25', 'GENERALIST', 'generalists');
SET @leila_id = LAST_INSERT_ID();
INSERT INTO generalists (id, numero_RPPS, address, city, fee)
VALUES (@leila_id, 'RPPS12346', '456 Rue Hassan II', 'Rabat', 140.0);

-- Insérer Amina (Specialist - Cardiology)
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES ('Amina', 'Tahari', 'amina', @password_hash, '0670000001', 'amina.tahari@hospital.com', 'FEMALE', '1980-06-05', 'SPECIALIST', 'DOCTOR');
SET @amina_id = LAST_INSERT_ID();
INSERT INTO doctors (id) VALUES (@amina_id);
INSERT INTO specialists (id, numero_RPPS, fee)
VALUES (@amina_id, 'RPPS54321', 250.0);

-- Insérer Youssef (Specialist - Neurology)
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES ('Youssef', 'Benjelloun', 'youssef', @password_hash, '0670000002', 'youssef.benjelloun@hospital.com', 'MALE', '1982-04-18', 'SPECIALIST', 'DOCTOR');
SET @youssef_id = LAST_INSERT_ID();
INSERT INTO doctors (id) VALUES (@youssef_id);
INSERT INTO specialists (id, numero_RPPS, fee)
VALUES (@youssef_id, 'RPPS54322', 280.0);

-- Insérer Sara (Specialist - Dermatology)
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES ('Sara', 'Mansouri', 'sara', @password_hash, '0670000003', 'sara.mansouri@hospital.com', 'FEMALE', '1987-09-22', 'SPECIALIST', 'DOCTOR');
SET @sara_id = LAST_INSERT_ID();
INSERT INTO doctors (id) VALUES (@sara_id);
INSERT INTO specialists (id, numero_RPPS, fee)
VALUES (@sara_id, 'RPPS54323', 220.0);

-- Insérer Mohammed (Patient)
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES ('Mohammed', 'Alaoui', 'mohammed', @password_hash, '0680000001', 'mohammed.alaoui@email.com', 'MALE', '2000-01-01', 'PATIENT', 'PATIENT');
SET @mohammed_id = LAST_INSERT_ID();
INSERT INTO patients (id, dossier_number, date_of_birth, height, weight, blood_type)
VALUES (@mohammed_id, 'DOS001', '1990-07-15', 175.0, 75.0, 'O+');

-- Insérer Khadija (Patient)
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES ('Khadija', 'Benjelloun', 'khadija', @password_hash, '0680000002', 'khadija.benjelloun@email.com', 'FEMALE', '2000-01-01', 'PATIENT', 'PATIENT');
SET @khadija_id = LAST_INSERT_ID();
INSERT INTO patients (id, dossier_number, date_of_birth, height, weight, blood_type)
VALUES (@khadija_id, 'DOS002', '1992-03-20', 165.0, 60.0, 'A+');

-- Insérer Hassan (Patient)
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES ('Hassan', 'Tazi', 'hassan', @password_hash, '0680000003', 'hassan.tazi@email.com', 'MALE', '2000-01-01', 'PATIENT', 'PATIENT');
SET @hassan_id = LAST_INSERT_ID();
INSERT INTO patients (id, dossier_number, date_of_birth, height, weight, blood_type)
VALUES (@hassan_id, 'DOS003', '1985-11-08', 180.0, 82.0, 'B+');

SET FOREIGN_KEY_CHECKS = 1;

-- Afficher le résultat
SELECT
    CONCAT('✅ ', COUNT(*), ' utilisateurs créés avec succès!') as Result
FROM Person;

SELECT
    first_name as Prénom,
    last_name as Nom,
    email as Email,
    role as Rôle
FROM Person
ORDER BY role, first_name;

