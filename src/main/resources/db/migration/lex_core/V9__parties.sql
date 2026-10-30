-- F4 party/person/organization/client schema.
-- Single-column primary keys; document uniqueness is a global unique constraint, not a PK.

CREATE TABLE IF NOT EXISTS party (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    public_id CHAR(36) NOT NULL,
    party_type VARCHAR(20) NOT NULL,
    document_type_code VARCHAR(20) NOT NULL,
    document_number VARCHAR(60) NOT NULL,
    version INT NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    deleted_at DATETIME(6) NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_party_public_id (public_id),
    UNIQUE KEY uk_party_document (document_type_code, document_number),
    KEY idx_party_type (party_type),
    CONSTRAINT fk_party_document_type FOREIGN KEY (document_type_code) REFERENCES document_type (code) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS person (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    party_id BIGINT UNSIGNED NOT NULL,
    first_name VARCHAR(80) NOT NULL,
    second_name VARCHAR(80) NULL,
    first_last_name VARCHAR(80) NOT NULL,
    second_last_name VARCHAR(80) NULL,
    birth_date DATE NULL,
    nationality_country_iso2 CHAR(2) NULL,
    disability_category_code CHAR(2) NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_person_party (party_id),
    CONSTRAINT fk_person_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_person_nationality FOREIGN KEY (nationality_country_iso2) REFERENCES country (iso2) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_person_disability FOREIGN KEY (disability_category_code) REFERENCES disability_category (code) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS organization (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    party_id BIGINT UNSIGNED NOT NULL,
    legal_name VARCHAR(200) NOT NULL,
    commercial_name VARCHAR(200) NULL,
    incorporation_date DATE NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_organization_party (party_id),
    CONSTRAINT fk_organization_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS party_address (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    party_id BIGINT UNSIGNED NOT NULL,
    label VARCHAR(60) NULL,
    line1 VARCHAR(200) NOT NULL,
    line2 VARCHAR(200) NULL,
    country_iso2 CHAR(2) NOT NULL,
    department_state_id BIGINT UNSIGNED NOT NULL,
    city_id BIGINT UNSIGNED NOT NULL,
    postal_code VARCHAR(12) NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    version INT NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_party_address_party (party_id),
    CONSTRAINT fk_party_address_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_party_address_country FOREIGN KEY (country_iso2) REFERENCES country (iso2) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_party_address_department FOREIGN KEY (department_state_id) REFERENCES department_state (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_party_address_city FOREIGN KEY (city_id) REFERENCES city (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS party_email (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    party_id BIGINT UNSIGNED NOT NULL,
    email VARCHAR(254) NOT NULL,
    normalized_email VARCHAR(254) NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    verified_at DATETIME(6) NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_party_email (party_id, normalized_email),
    CONSTRAINT fk_party_email_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS party_phone (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    party_id BIGINT UNSIGNED NOT NULL,
    e164 VARCHAR(16) NOT NULL,
    country_calling_code VARCHAR(6) NULL,
    national_number VARCHAR(20) NULL,
    type VARCHAR(20) NOT NULL DEFAULT 'MOBILE',
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    whatsapp BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id),
    UNIQUE KEY uk_party_phone (party_id, e164),
    CONSTRAINT fk_party_phone_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS party_social (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    party_id BIGINT UNSIGNED NOT NULL,
    platform VARCHAR(30) NOT NULL,
    handle VARCHAR(120) NOT NULL,
    url VARCHAR(300) NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_party_social (party_id, platform, handle),
    CONSTRAINT fk_party_social_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS client (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    public_id CHAR(36) NOT NULL,
    party_id BIGINT UNSIGNED NOT NULL,
    client_code VARCHAR(20) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
    assigned_lawyer_user_id BIGINT UNSIGNED NULL,
    source VARCHAR(40) NULL,
    notes VARCHAR(2000) NULL,
    contracting_eligible BOOLEAN NOT NULL DEFAULT FALSE,
    version INT NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    deleted_at DATETIME(6) NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_client_public_id (public_id),
    UNIQUE KEY uk_client_party (party_id),
    UNIQUE KEY uk_client_code (client_code),
    CONSTRAINT fk_client_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS organization_legal_representative (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    organization_party_id BIGINT UNSIGNED NOT NULL,
    person_party_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(120) NULL,
    faculties VARCHAR(500) NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    appointed_at DATE NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_org_legal_rep (organization_party_id, person_party_id),
    CONSTRAINT fk_org_legal_rep_org FOREIGN KEY (organization_party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_org_legal_rep_person FOREIGN KEY (person_party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS consent (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    party_id BIGINT UNSIGNED NOT NULL,
    purpose VARCHAR(40) NOT NULL,
    policy_version VARCHAR(20) NOT NULL,
    granted_at DATETIME(6) NULL,
    revoked_at DATETIME(6) NULL,
    evidence JSON NULL,
    ip VARCHAR(45) NULL,
    user_agent VARCHAR(255) NULL,
    PRIMARY KEY (id),
    KEY idx_consent_party (party_id),
    CONSTRAINT fk_consent_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
