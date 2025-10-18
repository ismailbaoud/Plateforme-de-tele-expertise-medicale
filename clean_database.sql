-- Script pour nettoyer la base de données hospital
-- Exécutez ce script avant de redémarrer l'application

USE hospital;

-- Désactiver les vérifications de clés étrangères temporairement
SET FOREIGN_KEY_CHECKS = 0;

-- Supprimer toutes les tables dans l'ordre inverse des dépendances
DROP TABLE IF EXISTS consultation_requests;
DROP TABLE IF EXISTS consultations;
DROP TABLE IF EXISTS medical_acts;
DROP TABLE IF EXISTS ScheduleSlot;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS medical_files;
DROP TABLE IF EXISTS requests;
DROP TABLE IF EXISTS Specialist;
DROP TABLE IF EXISTS Generalist;
DROP TABLE IF EXISTS Nurse;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Person;

-- Réactiver les vérifications de clés étrangères
SET FOREIGN_KEY_CHECKS = 1;

