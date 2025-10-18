# 🏥 Système de Consultation Médicale

## 📋 Description du Projet

Application web de gestion de consultations médicales développée en Java EE, permettant la gestion complète des patients, consultations, tickets et emplois du temps dans un environnement hospitalier.

## 🎯 Fonctionnalités Principales

### 👨‍⚕️ Gestion des Utilisateurs
- **Généralistes** : Gestion des consultations, dossiers médicaux, prescriptions
- **Spécialistes** : Avis d'experts, consultations spécialisées
- **Infirmières** : Enregistrement des patients, gestion des tickets, signes vitaux
- **Patients** : Accès à leur dossier médical, consultations

### 🏥 Fonctionnalités Médicales

#### Dashboard Infirmière
- ✅ Enregistrement de nouveaux patients avec signes vitaux complets
- ✅ Création et gestion des tickets de consultation
- ✅ Recherche de patients en temps réel
- ✅ Visualisation des statistiques (patients, tickets actifs/utilisés)
- ✅ Gestion des données médicales :
  - Date de naissance
  - Taille et poids
  - Tension artérielle
  - Température
  - Pouls (fréquence cardiaque)
  - Saturation en oxygène (SpO2)
  - Groupe sanguin
  - Allergies

#### Consultations Médicales
- Création et suivi des consultations
- Examen clinique détaillé
- Diagnostic et plan de traitement
- Actes médicaux associés
- Demandes d'avis spécialisés

#### Gestion des Spécialistes
- Consultation des demandes d'avis
- Réponses aux consultations
- Suivi des dossiers patients
- Statuts : PENDING, IN_PROGRESS, COMPLETED

#### Système de Tickets
- Génération automatique de numéros de tickets
- Statuts : ACTIVE, PENDING, USED, EXPIRED, CANCELLED
- Suivi en temps réel
- Association avec les patients

### 📅 Gestion d'Emploi du Temps
- Planning des rendez-vous
- Créneaux horaires disponibles
- Gestion des disponibilités

## 🛠️ Technologies Utilisées

### Backend
- **Java 17** - Langage principal
- **Jakarta EE 10** - Framework d'entreprise
- **Hibernate 7.0.4** - ORM (Object-Relational Mapping)
- **JPA (Jakarta Persistence API) 3.2.0** - Spécification de persistance
- **Servlets & JSP** - Interface web
- **JSTL 2.0** - Tag libraries

### Base de Données
- **MariaDB 3.5.5** - Système de gestion de base de données

### Frontend
- **Tailwind CSS** - Framework CSS moderne
- **JavaScript (Vanilla)** - Interactivité
- **JSP (JavaServer Pages)** - Génération de vues dynamiques

### Sécurité
- **BCrypt (jBCrypt 0.4)** - Hachage des mots de passe
- **AuthFilter** - Filtre d'authentification

### Build & Déploiement
- **Maven 3.x** - Gestion de dépendances et build
- **Apache Tomcat 11** - Serveur d'applications

## 📁 Structure du Projet

```
consultation-medicale/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/medicale/consultation/consultationmedicale/
│   │   │       ├── config/          # Configuration
│   │   │       ├── controller/      # Servlets (Contrôleurs MVC)
│   │   │       │   ├── BaseServlet.java
│   │   │       │   ├── LoginServlet.java
│   │   │       │   ├── ConsultationServlet.java
│   │   │       │   ├── NurseDashboardServlet.java
│   │   │       │   ├── SpecialistConsultationServlet.java
│   │   │       │   ├── TicketServlet.java
│   │   │       │   └── ...
│   │   │       ├── enums/           # Énumérations
│   │   │       │   ├── Role.java
│   │   │       │   ├── Gender.java
│   │   │       │   ├── ConsultationStatus.java
│   │   │       │   ├── TicketStatus.java
│   │   │       │   └── ...
│   │   │       ├── filter/          # Filtres de sécurité
│   │   │       │   └── AuthFilter.java
│   │   │       ├── models/          # Entités JPA
│   │   │       │   ├── person/
│   │   │       │   │   ├── Person.java
│   │   │       │   │   ├── Patient.java
│   │   │       │   │   ├── Generalist.java
│   │   │       │   │   ├── Specialist.java
│   │   │       │   │   └── Nurse.java
│   │   │       │   ├── consultation/
│   │   │       │   │   ├── Consultation.java
│   │   │       │   │   ├── Request.java
│   │   │       │   │   └── MedicaleAct.java
│   │   │       │   ├── MedicaleFile.java
│   │   │       │   ├── Ticket.java
│   │   │       │   └── ScheduleSlot.java
│   │   │       ├── repositories/    # Couche d'accès aux données
│   │   │       │   ├── BaseRepository.java
│   │   │       │   ├── PatientRepository.java
│   │   │       │   ├── ConsultationRepository.java
│   │   │       │   └── ...
│   │   │       ├── service/         # Logique métier
│   │   │       │   ├── PatientService.java
│   │   │       │   ├── ConsultationService.java
│   │   │       │   ├── TicketService.java
│   │   │       │   └── ...
│   │   │       ├── seeder/          # Données de test
│   │   │       │   └── DataSeeder.java
│   │   │       └── utils/           # Utilitaires
│   │   │           └── PasswordUtils.java
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml  # Configuration JPA
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── views/           # Pages JSP
│   │       │   │   ├── login.jsp
│   │       │   │   ├── nurseDashboard.jsp
│   │       │   │   ├── consultation.jsp
│   │       │   │   ├── specialistConsultations.jsp
│   │       │   │   ├── medicalFile.jsp
│   │       │   │   └── ...
│   │       │   └── web.xml          # Configuration web
│   │       ├── dashboard.jsp
│   │       ├── header.jsp
│   │       ├── footer.jsp
│   │       └── login.jsp
│   └── test/                        # Tests unitaires
├── pom.xml                          # Configuration Maven
└── README.md
```

## 🗄️ Modèle de Données

### Entités Principales

#### Person (Hiérarchie d'héritage)
- **Patient** : dateOfBirth, height, weight, bloodType, allergies
- **Generalist** : spécialisation en médecine générale
- **Specialist** : speciality (CARDIOLOGY, NEUROLOGY, etc.)
- **Nurse** : gestion des patients et tickets

#### Consultation
- Raison, symptômes, examen clinique
- Diagnostic, plan de traitement
- Statuts : PENDING, CONFIRMED, IN_PROGRESS, COMPLETED, CANCELLED
- Actes médicaux associés
- Demandes d'avis spécialisés

#### Ticket
- Numéro unique généré automatiquement
- Statuts : ACTIVE, PENDING, USED, EXPIRED, CANCELLED
- Association avec un patient
- Dates de création, utilisation et expiration

#### MedicaleFile
- Dossier médical complet
- Historique des consultations
- Signes vitaux

## 🚀 Installation et Déploiement

### Prérequis
- **JDK 17** ou supérieur
- **Maven 3.6** ou supérieur
- **MariaDB/MySQL** 10.x ou supérieur
- **Apache Tomcat 11** ou serveur d'applications compatible

### Configuration de la Base de Données

1. Créer la base de données :
```sql
CREATE DATABASE consultation_medicale CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. Configurer les paramètres dans `persistence.xml` :
```xml
<property name="jakarta.persistence.jdbc.url" value="jdbc:mariadb://localhost:3306/consultation_medicale"/>
<property name="jakarta.persistence.jdbc.user" value="your_username"/>
<property name="jakarta.persistence.jdbc.password" value="your_password"/>
```

### Build du Projet

```bash
# Nettoyer et compiler
mvn clean compile

# Générer le fichier WAR
mvn package

# Générer le WAR sans tests
mvn package -DskipTests
```

Le fichier WAR sera généré dans : `target/consultation-medicale-1.0-SNAPSHOT.war`

### Déploiement

#### Option 1 : Déploiement sur Tomcat
```bash
# Copier le WAR dans le répertoire webapps de Tomcat
cp target/consultation-medicale-1.0-SNAPSHOT.war /opt/tomcat/webapps/

# Redémarrer Tomcat
sudo systemctl restart tomcat
```

#### Option 2 : Déploiement manuel
1. Copier le fichier WAR dans `webapps/` de Tomcat
2. Tomcat déploiera automatiquement l'application
3. Accéder à : `http://localhost:8080/consultation-medicale-1.0-SNAPSHOT/`

### Nettoyage du Cache (si nécessaire)
```bash
# Nettoyer le cache de Tomcat
sudo rm -rf /opt/tomcat/work/*
sudo rm -rf /opt/tomcat/temp/*
```

## 👥 Comptes Utilisateurs par Défaut

Les comptes suivants sont créés automatiquement au premier démarrage (via DataSeeder) :

### Infirmière
- **Username** : nurse1
- **Password** : password123

### Généraliste
- **Username** : generalist1
- **Password** : password123

### Spécialiste
- **Username** : specialist1
- **Password** : password123

### Patient
- **Username** : patient1
- **Password** : password123

## 🔒 Sécurité

- Mots de passe hashés avec **BCrypt**
- Filtre d'authentification sur toutes les pages protégées
- Sessions utilisateur sécurisées
- Protection contre les injections SQL via JPA/Hibernate
- Validation des données côté serveur

## 🎨 Interface Utilisateur

- Design moderne avec **Tailwind CSS**
- Interface responsive (mobile-friendly)
- Thème clair/sombre
- Animations et transitions fluides
- Recherche en temps réel avec autocomplete
- Notifications et messages d'erreur clairs

## 🧪 Tests

```bash
# Exécuter tous les tests
mvn test

# Tests avec rapport de couverture
mvn test jacoco:report
```

## 📊 Fonctionnalités Récemment Ajoutées

✅ **Dashboard Infirmière**
- Formulaire d'ajout de patient avec signes vitaux complets
- Recherche de patients en temps réel
- Gestion des tickets avec génération automatique de numéros
- Statistiques en temps réel

✅ **Corrections et Améliorations**
- Ajout du statut `PENDING` à `TicketStatus`
- Ajout du statut `IN_PROGRESS` à `ConsultationStatus`
- Méthode `getStatus()` ajoutée à `Consultation`
- Correction du formatage des dates `LocalDateTime` dans les JSP
- Gestion correcte des champs obligatoires du modèle `Patient`
- Correction du JavaScript pour éviter les conflits avec JSP/EL

## 📝 API Endpoints

### Authentification
- `GET /login` - Page de connexion
- `POST /login` - Authentification
- `GET /login?action=logout` - Déconnexion

### Infirmière
- `GET /nurse/dashboard` - Dashboard infirmière
- `POST /nurse/dashboard?action=addPatient` - Ajouter un patient
- `POST /nurse/dashboard?action=addTicket` - Créer un ticket
- `GET /nurse/dashboard?action=searchPatient` - Rechercher un patient

### Consultations
- `GET /consultation` - Liste des consultations
- `POST /consultation?action=create` - Créer une consultation
- `POST /consultation?action=update` - Mettre à jour une consultation

### Spécialistes
- `GET /specialist/consultations` - Demandes d'avis
- `POST /specialist/respond` - Répondre à une demande

## 🐛 Résolution de Problèmes

### Erreur de connexion à la base de données
Vérifier les paramètres dans `persistence.xml` et s'assurer que MariaDB est démarré.

### Erreur 500 lors du chargement des JSP
Nettoyer le cache de Tomcat :
```bash
sudo rm -rf /opt/tomcat/work/*
```

### Erreur "ClassNotFoundException"
Recompiler et redéployer l'application :
```bash
mvn clean package
```

## 📞 Support

Pour toute question ou problème, veuillez créer une issue sur le repository du projet.

## 📄 Licence

Ce projet est développé dans un cadre éducatif.

## 👨‍💻 Auteur

Développé avec ❤️ pour la gestion médicale moderne

---

**Version** : 1.0-SNAPSHOT  
**Date de dernière mise à jour** : 18 Octobre 2025  
**JDK Minimum** : 17  
**Serveur d'applications** : Tomcat 11+

