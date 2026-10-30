-- V26: Unifica persona natural, jurídica y cliente en party (SINGLE_TABLE).
-- Copia datos desde person/organization/client, crea party_role y elimina tablas hijas.

ALTER TABLE party
    ADD COLUMN first_name VARCHAR(60) NULL AFTER document_number,
    ADD COLUMN second_name VARCHAR(60) NULL AFTER first_name,
    ADD COLUMN first_last_name VARCHAR(60) NULL AFTER second_name,
    ADD COLUMN second_last_name VARCHAR(60) NULL AFTER first_last_name,
    ADD COLUMN birth_date DATE NULL AFTER second_last_name,
    ADD COLUMN nationality_country_iso2 CHAR(2) NULL AFTER birth_date,
    ADD COLUMN disability_category_code CHAR(2) NULL AFTER nationality_country_iso2,
    ADD COLUMN legal_name VARCHAR(200) NULL AFTER disability_category_code,
    ADD COLUMN commercial_name VARCHAR(200) NULL AFTER legal_name,
    ADD COLUMN incorporation_date DATE NULL AFTER commercial_name,
    ADD COLUMN check_digit CHAR(1) NULL AFTER incorporation_date,
    ADD COLUMN client_code VARCHAR(20) NULL AFTER check_digit,
    ADD COLUMN client_status VARCHAR(30) NULL AFTER client_code,
    ADD COLUMN assigned_lawyer_user_id BIGINT UNSIGNED NULL AFTER client_status,
    ADD COLUMN source VARCHAR(40) NULL AFTER assigned_lawyer_user_id,
    ADD COLUMN notes VARCHAR(2000) NULL AFTER source,
    ADD COLUMN contracting_eligible BOOLEAN NOT NULL DEFAULT FALSE AFTER notes,
    ADD COLUMN created_by BIGINT UNSIGNED NULL AFTER deleted_at,
    ADD COLUMN updated_by BIGINT UNSIGNED NULL AFTER created_by,
    ADD COLUMN deleted_by BIGINT UNSIGNED NULL AFTER updated_by;

UPDATE party SET party_type = 'ORGANIZATION' WHERE party_type IN ('LEGAL', 'ORGANIZATION');

UPDATE party p
    INNER JOIN person pe ON pe.party_id = p.id
SET p.first_name = pe.first_name,
    p.second_name = pe.second_name,
    p.first_last_name = pe.first_last_name,
    p.second_last_name = pe.second_last_name,
    p.birth_date = pe.birth_date,
    p.nationality_country_iso2 = pe.nationality_country_iso2,
    p.disability_category_code = pe.disability_category_code,
    p.party_type = 'PERSON';

UPDATE party p
    INNER JOIN organization o ON o.party_id = p.id
SET p.legal_name = o.legal_name,
    p.commercial_name = COALESCE(NULLIF(TRIM(o.commercial_name), ''), o.legal_name),
    p.incorporation_date = o.incorporation_date,
    p.party_type = 'ORGANIZATION';

UPDATE party p
    INNER JOIN client c ON c.party_id = p.id
SET p.public_id = c.public_id,
    p.client_code = c.client_code,
    p.client_status = c.status,
    p.assigned_lawyer_user_id = c.assigned_lawyer_user_id,
    p.source = c.source,
    p.notes = c.notes,
    p.contracting_eligible = c.contracting_eligible,
    p.deleted_at = COALESCE(p.deleted_at, c.deleted_at);

UPDATE party
SET first_name = COALESCE(NULLIF(TRIM(first_name), ''), 'SIN NOMBRE'),
    first_last_name = COALESCE(NULLIF(TRIM(first_last_name), ''), 'SIN APELLIDO'),
    legal_name = NULL,
    commercial_name = NULL,
    incorporation_date = NULL
WHERE party_type = 'PERSON';

UPDATE party
SET legal_name = COALESCE(NULLIF(TRIM(legal_name), ''), CONCAT('ORG ', document_number)),
    commercial_name = COALESCE(NULLIF(TRIM(commercial_name), ''), COALESCE(NULLIF(TRIM(legal_name), ''), CONCAT('ORG ', document_number))),
    first_name = NULL,
    second_name = NULL,
    first_last_name = NULL,
    second_last_name = NULL,
    birth_date = NULL,
    disability_category_code = NULL
WHERE party_type = 'ORGANIZATION';

CREATE TABLE IF NOT EXISTS party_role (
    party_id BIGINT UNSIGNED NOT NULL,
    role VARCHAR(30) NOT NULL,
    PRIMARY KEY (party_id, role),
    CONSTRAINT fk_party_role_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT IGNORE INTO party_role (party_id, role)
SELECT party_id, 'CLIENT' FROM client;

INSERT IGNORE INTO party_role (party_id, role)
SELECT person_party_id, 'LEGAL_REP'
FROM organization_legal_representative
WHERE active = TRUE;

ALTER TABLE party
    ADD CONSTRAINT fk_party_nationality FOREIGN KEY (nationality_country_iso2) REFERENCES country (iso2) ON DELETE RESTRICT ON UPDATE RESTRICT,
    ADD CONSTRAINT fk_party_disability FOREIGN KEY (disability_category_code) REFERENCES disability_category (code) ON DELETE RESTRICT ON UPDATE RESTRICT,
    ADD UNIQUE KEY uk_party_client_code (client_code),
    ADD KEY idx_party_client_status (client_status);

ALTER TABLE party
    ADD CONSTRAINT chk_party_type_fields CHECK (
        (party_type = 'PERSON'
            AND first_name IS NOT NULL
            AND first_last_name IS NOT NULL
            AND legal_name IS NULL
            AND commercial_name IS NULL)
        OR
        (party_type = 'ORGANIZATION'
            AND legal_name IS NOT NULL
            AND commercial_name IS NOT NULL
            AND first_name IS NULL
            AND first_last_name IS NULL)
    );

ALTER TABLE app_user DROP FOREIGN KEY fk_app_user_person;
ALTER TABLE app_user DROP INDEX uk_app_user_person_id;
ALTER TABLE app_user DROP INDEX idx_app_user_person_id;
ALTER TABLE app_user CHANGE COLUMN person_id party_id BIGINT UNSIGNED NULL;
ALTER TABLE app_user
    ADD UNIQUE KEY uk_app_user_party_id (party_id),
    ADD KEY idx_app_user_party_id (party_id),
    ADD CONSTRAINT fk_app_user_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE person DROP FOREIGN KEY fk_person_party;
ALTER TABLE person DROP FOREIGN KEY fk_person_nationality;
ALTER TABLE person DROP FOREIGN KEY fk_person_disability;
DROP TABLE person;

ALTER TABLE organization DROP FOREIGN KEY fk_organization_party;
DROP TABLE organization;

ALTER TABLE client DROP FOREIGN KEY fk_client_party;
DROP TABLE client;
