-- V23: Homologacion de limites de caracteres (BUG-007)
-- Truncar los campos a los nuevos limites permitidos en BD y Frontend

ALTER TABLE app_user
  MODIFY first_name VARCHAR(60) NULL,
  MODIFY second_name VARCHAR(60) NULL,
  MODIFY first_last_name VARCHAR(60) NULL,
  MODIFY second_last_name VARCHAR(60) NULL;

ALTER TABLE app_organization
  MODIFY document_number VARCHAR(20) NOT NULL,
  MODIFY legal_representative_document VARCHAR(20) NULL;

ALTER TABLE party
  MODIFY document_number VARCHAR(20) NOT NULL;

ALTER TABLE person
  MODIFY first_name VARCHAR(60) NOT NULL,
  MODIFY second_name VARCHAR(60) NULL,
  MODIFY first_last_name VARCHAR(60) NOT NULL,
  MODIFY second_last_name VARCHAR(60) NULL;
