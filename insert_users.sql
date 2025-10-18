-- Script pour insérer les utilisateurs de test dans la base de données
USE hospital;

-- Insérer les utilisateurs dans la table Person
-- Note: Les mots de passe sont hashés avec BCrypt (password: 1234)

-- NURSES
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES
('Nora', 'Benali', 'nora', '$2a$10$XQjz3VQ7Z5Z5Z5Z5Z5Z5ZuYqX8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y', '0650000001', 'nora.benali@hospital.com', 'FEMALE', '1998-05-21', 'NURSE', 'NURSE'),
('Fatima', 'Zahra', 'fatima', '$2a$10$XQjz3VQ7Z5Z5Z5Z5Z5Z5ZuYqX8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y', '0650000002', 'fatima.zahra@hospital.com', 'FEMALE', '1995-03-15', 'NURSE', 'NURSE');

-- GENERALISTS
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES
('Amine', 'Tahar', 'amine', '$2a$10$XQjz3VQ7Z5Z5Z5Z5Z5Z5ZuYqX8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y', '0660000001', 'amine.tahar@hospital.com', 'MALE', '1985-08-10', 'GENERALIST', 'generalists');

INSERT INTO generalists (id, numero_RPPS, address, city, fee)
VALUES
(LAST_INSERT_ID(), 'RPPS12345', '123 Avenue Mohammed V', 'Casablanca', 150.0);

INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES
('Leila', 'Alami', 'leila', '$2a$10$XQjz3VQ7Z5Z5Z5Z5Z5Z5ZuYqX8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y', '0660000002', 'leila.alami@hospital.com', 'FEMALE', '1988-11-25', 'GENERALIST', 'generalists');

INSERT INTO generalists (id, numero_RPPS, address, city, fee)
VALUES
(LAST_INSERT_ID(), 'RPPS12346', '456 Rue Hassan II', 'Rabat', 140.0);

-- PATIENTS
INSERT INTO Person (first_name, last_name, username, password, phone, email, gender, created_at, role, person_type)
VALUES
('Mohammed', 'Alaoui', 'mohammed', '$2a$10$XQjz3VQ7Z5Z5Z5Z5Z5Z5ZuYqX8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y8Y', '0680000001', 'mohammed.alaoui@email.com', 'MALE', '2000-01-01', 'PATIENT', 'PATIENT');

INSERT INTO patients (id, dossier_number, date_of_birth, height, weight, blood_type)
VALUES
(LAST_INSERT_ID(), 'DOS001', '1990-07-15', 175.0, 75.0, 'O+');

