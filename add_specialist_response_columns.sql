-- Migration pour ajouter les champs de réponse du spécialiste
-- Date: 2025-10-18

-- Vérifier si les colonnes existent déjà avant de les ajouter
SET @dbname = DATABASE();
SET @tablename = 'consultations';

-- Ajouter expert_opinion si elle n'existe pas
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = @dbname
AND TABLE_NAME = @tablename
AND COLUMN_NAME = 'expert_opinion';

SET @query = IF(@col_exists = 0,
    'ALTER TABLE consultations ADD COLUMN expert_opinion TEXT',
    'SELECT "Column expert_opinion already exists" as message');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Ajouter recommendations si elle n'existe pas
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = @dbname
AND TABLE_NAME = @tablename
AND COLUMN_NAME = 'recommendations';

SET @query = IF(@col_exists = 0,
    'ALTER TABLE consultations ADD COLUMN recommendations TEXT',
    'SELECT "Column recommendations already exists" as message');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Ajouter updated_at si elle n'existe pas
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = @dbname
AND TABLE_NAME = @tablename
AND COLUMN_NAME = 'updated_at';

SET @query = IF(@col_exists = 0,
    'ALTER TABLE consultations ADD COLUMN updated_at DATETIME',
    'SELECT "Column updated_at already exists" as message');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Afficher la structure de la table pour vérification
DESCRIBE consultations;

