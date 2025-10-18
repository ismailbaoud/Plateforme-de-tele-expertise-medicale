# Instructions pour résoudre les erreurs de clés étrangères Hibernate

## Problème
Les erreurs que vous rencontrez sont causées par Hibernate qui tente de modifier des colonnes utilisées dans des contraintes de clés étrangères existantes. MariaDB n'autorise pas ces modifications sans supprimer d'abord les contraintes.

## Solution recommandée : Nettoyer et recréer la base de données

### Option 1 : Utiliser le script SQL fourni (RECOMMANDÉ)

1. **Exécuter le script de nettoyage** :
   ```bash
   mysql -u ismail -p hospital < clean_database.sql
   ```
   (Appuyez sur Entrée si le mot de passe est vide)

2. **Redémarrer votre application Tomcat**
   - Hibernate recréera automatiquement toutes les tables avec les bonnes contraintes

### Option 2 : Manuellement via MySQL/MariaDB CLI

1. **Se connecter à MySQL** :
   ```bash
   mysql -u ismail -p
   ```

2. **Exécuter les commandes suivantes** :
   ```sql
   USE hospital;
   SET FOREIGN_KEY_CHECKS = 0;
   
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
   
   SET FOREIGN_KEY_CHECKS = 1;
   exit;
   ```

3. **Redémarrer votre application Tomcat**

### Option 3 : Changer la stratégie Hibernate (Pour développement uniquement)

Si vous voulez qu'Hibernate recrée complètement le schéma à chaque démarrage :

1. **Modifier `persistence.xml`** :
   Changez la ligne :
   ```xml
   <property name="hibernate.hbm2ddl.auto" value="update"/>
   ```
   en :
   ```xml
   <property name="hibernate.hbm2ddl.auto" value="create-drop"/>
   ```

   ⚠️ **ATTENTION** : Cette option supprime et recrée toutes les tables à chaque démarrage. Utilisez uniquement en développement !

## Corrections apportées

1. ✅ **Fichier `Specialist.java`** : Corrigé le code dupliqué et mal formaté
2. ✅ **Script `clean_database.sql`** : Créé pour nettoyer la base de données
3. ✅ **Test `ConsultationServletTest.java`** : Les imports sont déjà corrects

## Après le nettoyage

Une fois la base de données nettoyée et l'application redémarrée, Hibernate créera automatiquement :
- Toutes les tables avec les bonnes structures
- Toutes les contraintes de clés étrangères correctement formées
- Les index nécessaires

## Vérification

Après avoir redémarré l'application, vérifiez que les erreurs ont disparu dans les logs Tomcat. Vous devriez voir des messages comme :
```
Hibernate: create table Person (...)
Hibernate: create table Specialist (...)
Hibernate: alter table ScheduleSlot add constraint ... foreign key (specialist_id) references Specialist (id)
```

Sans aucune erreur `CommandAcceptanceException` ou `SQLException`.

