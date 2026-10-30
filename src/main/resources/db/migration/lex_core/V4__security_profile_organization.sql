-- F12 security, profile and organization.
-- Adds self-service profile fields, security questions and company settings.

ALTER TABLE app_user
    ADD COLUMN phone VARCHAR(30) NULL AFTER display_name,
    ADD COLUMN locale VARCHAR(10) NOT NULL DEFAULT 'es' AFTER phone,
    ADD COLUMN avatar_content_type VARCHAR(80) NULL AFTER locale,
    ADD COLUMN avatar_data MEDIUMBLOB NULL AFTER avatar_content_type,
    ADD COLUMN avatar_updated_at DATETIME(6) NULL AFTER avatar_data;

ALTER TABLE role
    ADD COLUMN description VARCHAR(200) NULL AFTER name;

CREATE TABLE IF NOT EXISTS user_security_question (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    question_code VARCHAR(60) NOT NULL,
    question_text VARCHAR(200) NOT NULL,
    answer_hash VARCHAR(255) NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_user_security_question (user_id, question_code),
    CONSTRAINT fk_user_security_question_user FOREIGN KEY (user_id) REFERENCES app_user (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS app_organization (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    public_id CHAR(36) NOT NULL,
    legal_name VARCHAR(200) NOT NULL,
    trade_name VARCHAR(200) NULL,
    legal_person BOOLEAN NOT NULL DEFAULT TRUE,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(60) NOT NULL,
    check_digit VARCHAR(10) NULL,
    address_line1 VARCHAR(200) NULL,
    address_line2 VARCHAR(200) NULL,
    city VARCHAR(120) NULL,
    department VARCHAR(120) NULL,
    country VARCHAR(80) NOT NULL DEFAULT 'Colombia',
    email VARCHAR(254) NULL,
    phone VARCHAR(30) NULL,
    website VARCHAR(254) NULL,
    instagram VARCHAR(120) NULL,
    linkedin VARCHAR(120) NULL,
    facebook VARCHAR(120) NULL,
    legal_representative_name VARCHAR(200) NULL,
    legal_representative_document VARCHAR(60) NULL,
    print_header VARCHAR(500) NULL,
    print_footer VARCHAR(500) NULL,
    logo_content_type VARCHAR(80) NULL,
    logo_data MEDIUMBLOB NULL,
    logo_updated_at DATETIME(6) NULL,
    locale VARCHAR(10) NOT NULL DEFAULT 'es',
    timezone VARCHAR(60) NOT NULL DEFAULT 'America/Bogota',
    version INT NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_app_organization_public_id (public_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO app_organization (
    public_id, legal_name, legal_person, document_type, document_number,
    country, email, locale, timezone
)
SELECT UUID(), 'Lex Vertex', TRUE, 'NIT', '000000000-0',
       'Colombia', 'contacto@lexvertex.local', 'es', 'America/Bogota'
WHERE NOT EXISTS (SELECT 1 FROM app_organization);
