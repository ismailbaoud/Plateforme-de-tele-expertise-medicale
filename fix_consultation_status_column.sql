-- Fix consultation_status column size
-- The column needs to be larger to accommodate 'WAITING_SPECIALIST' (18 characters)

USE hospital;

-- Check current column definition
DESCRIBE consultations;

-- Alter the column to VARCHAR(50) to accommodate all enum values
ALTER TABLE consultations
MODIFY COLUMN consultation_status VARCHAR(50) NOT NULL;

-- Verify the change
DESCRIBE consultations;

-- Show current data
SELECT id, consultation_status FROM consultations;

