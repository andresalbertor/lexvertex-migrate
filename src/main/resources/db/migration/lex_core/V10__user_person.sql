-- Link users to their standard person record and add the staff position catalog.
-- Existing users receive a placeholder person (document type SD) that can be edited later.

ALTER TABLE app_user
    ADD COLUMN position_code VARCHAR(40) NULL AFTER person_id;

INSERT INTO party (id, public_id, party_type, document_type_code, document_number, created_at, updated_at)
SELECT u.id, UUID(), 'PERSON', 'SD', CONCAT('LEGACY-', u.id), u.created_at, u.updated_at
FROM app_user u
WHERE u.person_id IS NULL
ON DUPLICATE KEY UPDATE document_number = VALUES(document_number);

INSERT INTO person (
    party_id, first_name, second_name, first_last_name, second_last_name,
    nationality_country_iso2, created_at, updated_at
)
SELECT
    u.id,
    COALESCE(NULLIF(u.first_name, ''), u.display_name, 'SIN NOMBRE'),
    u.second_name,
    COALESCE(NULLIF(u.first_last_name, ''), 'SIN APELLIDO'),
    u.second_last_name,
    'CO',
    u.created_at,
    u.updated_at
FROM app_user u
WHERE u.person_id IS NULL
ON DUPLICATE KEY UPDATE first_name = VALUES(first_name), first_last_name = VALUES(first_last_name);

UPDATE app_user u
JOIN person p ON p.party_id = u.id
SET u.person_id = p.party_id
WHERE u.person_id IS NULL;

ALTER TABLE app_user
    ADD UNIQUE KEY uk_app_user_person_id (person_id),
    ADD KEY idx_app_user_position (position_code),
    ADD CONSTRAINT fk_app_user_person FOREIGN KEY (person_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    ADD CONSTRAINT fk_app_user_position FOREIGN KEY (position_code) REFERENCES position (code) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE app_user DROP COLUMN pending_email;
