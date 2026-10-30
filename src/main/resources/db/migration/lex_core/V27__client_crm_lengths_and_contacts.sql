-- V27: Alinea party SINGLE_TABLE con el contrato CRM de cliente natural y jurídico.
-- No recrea person, organization ni client. El máximo de dos teléfonos se valida en client-service.

ALTER TABLE party
    MODIFY legal_name VARCHAR(250) NULL,
    MODIFY commercial_name VARCHAR(250) NULL,
    MODIFY notes TEXT NULL,
    MODIFY check_digit VARCHAR(2) NULL;

ALTER TABLE party DROP CHECK chk_party_type_fields;

UPDATE party
SET legal_name = TRIM(CONCAT_WS(' ',
        NULLIF(TRIM(first_name), ''),
        NULLIF(TRIM(second_name), ''),
        NULLIF(TRIM(first_last_name), ''),
        NULLIF(TRIM(second_last_name), '')))
WHERE party_type = 'PERSON'
  AND (legal_name IS NULL OR TRIM(legal_name) = '');

ALTER TABLE party
    ADD CONSTRAINT chk_party_type_fields CHECK (
        (party_type = 'PERSON'
            AND first_name IS NOT NULL
            AND first_last_name IS NOT NULL
            AND legal_name IS NOT NULL
            AND commercial_name IS NULL)
        OR
        (party_type = 'ORGANIZATION'
            AND legal_name IS NOT NULL
            AND commercial_name IS NOT NULL
            AND first_name IS NULL
            AND first_last_name IS NULL)
    );

ALTER TABLE party_email
    MODIFY email VARCHAR(250) NOT NULL,
    MODIFY normalized_email VARCHAR(250) NOT NULL;

ALTER TABLE party_phone
    MODIFY e164 VARCHAR(15) NOT NULL;

UPDATE party_email e
    INNER JOIN (
        SELECT party_id, MIN(id) AS keep_id
        FROM party_email
        WHERE is_primary = TRUE
        GROUP BY party_id
        HAVING COUNT(*) > 1
    ) d ON d.party_id = e.party_id AND e.id <> d.keep_id
SET e.is_primary = FALSE
WHERE e.is_primary = TRUE;

UPDATE party_phone p
    INNER JOIN (
        SELECT party_id, MIN(id) AS keep_id
        FROM party_phone
        WHERE is_primary = TRUE
        GROUP BY party_id
        HAVING COUNT(*) > 1
    ) d ON d.party_id = p.party_id AND p.id <> d.keep_id
SET p.is_primary = FALSE
WHERE p.is_primary = TRUE;

UPDATE party_address a
    INNER JOIN (
        SELECT party_id, MIN(id) AS keep_id
        FROM party_address
        WHERE is_primary = TRUE
        GROUP BY party_id
        HAVING COUNT(*) > 1
    ) d ON d.party_id = a.party_id AND a.id <> d.keep_id
SET a.is_primary = FALSE
WHERE a.is_primary = TRUE;

UPDATE organization_legal_representative r
    INNER JOIN (
        SELECT organization_party_id, MIN(id) AS keep_id
        FROM organization_legal_representative
        WHERE is_primary = TRUE
        GROUP BY organization_party_id
        HAVING COUNT(*) > 1
    ) d ON d.organization_party_id = r.organization_party_id AND r.id <> d.keep_id
SET r.is_primary = FALSE
WHERE r.is_primary = TRUE;

ALTER TABLE party_email
    ADD COLUMN primary_party_key BIGINT UNSIGNED
        GENERATED ALWAYS AS (IF(is_primary, party_id, NULL)) STORED,
    ADD UNIQUE KEY uk_party_email_one_primary (primary_party_key);

ALTER TABLE party_phone
    ADD COLUMN primary_party_key BIGINT UNSIGNED
        GENERATED ALWAYS AS (IF(is_primary, party_id, NULL)) STORED,
    ADD UNIQUE KEY uk_party_phone_one_primary (primary_party_key);

ALTER TABLE party_address
    ADD COLUMN primary_party_key BIGINT UNSIGNED
        GENERATED ALWAYS AS (IF(is_primary, party_id, NULL)) STORED,
    ADD UNIQUE KEY uk_party_address_one_primary (primary_party_key);

ALTER TABLE organization_legal_representative
    ADD COLUMN primary_org_key BIGINT UNSIGNED
        GENERATED ALWAYS AS (IF(is_primary, organization_party_id, NULL)) STORED,
    ADD UNIQUE KEY uk_org_legal_rep_one_primary (primary_org_key);

CREATE TABLE IF NOT EXISTS party_contact (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    organization_party_id BIGINT UNSIGNED NOT NULL,
    document_type_code VARCHAR(20) NOT NULL,
    document_number VARCHAR(20) NOT NULL,
    full_name VARCHAR(250) NOT NULL,
    email VARCHAR(250) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT TRUE,
    primary_org_key BIGINT UNSIGNED
        GENERATED ALWAYS AS (IF(is_primary, organization_party_id, NULL)) STORED,
    PRIMARY KEY (id),
    UNIQUE KEY uk_org_contact_document (organization_party_id, document_type_code, document_number),
    UNIQUE KEY uk_org_contact_one_primary (primary_org_key),
    CONSTRAINT fk_party_contact_party FOREIGN KEY (organization_party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_party_contact_document_type FOREIGN KEY (document_type_code) REFERENCES document_type (code) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
