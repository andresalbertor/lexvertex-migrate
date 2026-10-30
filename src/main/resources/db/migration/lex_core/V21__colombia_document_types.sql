-- Actualizar/Insertar tipos de documento oficiales de Colombia
INSERT INTO document_type (code, country_iso2, name, applies_to, regex, min_length, max_length, is_active) VALUES
    ('RC', 'CO', 'Registro Civil de Nacimiento', 'PERSON', '^[0-9]{6,15}$', 6, 15, TRUE),
    ('TI', 'CO', 'Tarjeta de Identidad', 'PERSON', '^[0-9]{6,12}$', 6, 12, TRUE),
    ('CC', 'CO', 'Cédula de Ciudadanía', 'PERSON', '^[0-9]{6,10}$', 6, 10, TRUE),
    ('NIT', 'CO', 'Número de Identificación Tributaria', 'ORGANIZATION', '^[0-9]{9,15}$', 9, 15, TRUE),
    ('CE', 'CO', 'Cédula de Extranjería', 'PERSON', '^[A-Za-z0-9]{5,15}$', 5, 15, TRUE),
    ('PA', 'CO', 'Pasaporte', 'BOTH', '^[A-Za-z0-9]{5,20}$', 5, 20, TRUE),
    ('CD', 'CO', 'Carné Diplomático', 'PERSON', '^[A-Za-z0-9]{5,20}$', 5, 20, TRUE),
    ('NUIP', 'CO', 'Número Único de Identificación Personal', 'PERSON', '^[0-9]{10,15}$', 10, 15, TRUE),
    ('NIP', 'CO', 'Número de Identificación Personal', 'PERSON', '^[0-9]{10,15}$', 10, 15, TRUE),
    ('PEP', 'CO', 'Permiso Especial de Permanencia', 'PERSON', '^[A-Za-z0-9]{5,20}$', 5, 20, TRUE),
    ('PPT', 'CO', 'Permiso por Protección Temporal', 'PERSON', '^[A-Za-z0-9]{5,20}$', 5, 20, TRUE)
ON DUPLICATE KEY UPDATE name = VALUES(name), is_active = VALUES(is_active);

-- Desactivar cualquier otro tipo de documento para Colombia que no esté en la lista oficial
UPDATE document_type 
SET is_active = FALSE 
WHERE country_iso2 = 'CO' AND code NOT IN ('RC', 'TI', 'CC', 'NIT', 'CE', 'PA', 'CD', 'NUIP', 'NIP', 'PEP', 'PPT');
