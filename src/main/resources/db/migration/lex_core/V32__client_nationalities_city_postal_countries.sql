-- V32: nacionalidades 1:N, código postal en ciudad, países ISO ampliado y catalog:read idempotente.

-- 1) Permiso catalog:read para roles estandarizados (idempotente).
INSERT IGNORE INTO role_permission (role_id, permission_id)
SELECT r.id, p.id
FROM role r
CROSS JOIN permission p
WHERE r.code IN ('ADMN', 'ABOG', 'AUXI')
  AND p.code = 'catalog:read';

-- 2) Nacionalidades múltiples por party.
CREATE TABLE IF NOT EXISTS party_nationality (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    party_id BIGINT UNSIGNED NOT NULL,
    country_iso2 CHAR(2) NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    sort_order INT NOT NULL DEFAULT 0,
    version INT NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_party_nationality (party_id, country_iso2),
    KEY idx_party_nationality_party (party_id),
    CONSTRAINT fk_party_nationality_party FOREIGN KEY (party_id) REFERENCES party (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_party_nationality_country FOREIGN KEY (country_iso2) REFERENCES country (iso2) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO party_nationality (party_id, country_iso2, is_primary, sort_order, version, created_at, updated_at)
SELECT p.id, p.nationality_country_iso2, TRUE, 0, 0, CURRENT_TIMESTAMP(6), CURRENT_TIMESTAMP(6)
FROM party p
WHERE p.nationality_country_iso2 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM party_nationality pn
      WHERE pn.party_id = p.id AND pn.country_iso2 = p.nationality_country_iso2
  );

-- 3) Código postal en ciudad + semilla postal de capitales / municipios principales CO.
ALTER TABLE city
    ADD COLUMN postal_code VARCHAR(12) NULL AFTER name;

UPDATE city c
    INNER JOIN department_state d ON d.id = c.department_state_id
SET c.postal_code = CASE c.code
    WHEN '11001' THEN '110111'
    WHEN '05001' THEN '050001'
    WHEN '76001' THEN '760001'
    WHEN '08001' THEN '080001'
    WHEN '13001' THEN '130001'
    WHEN '68001' THEN '680001'
    WHEN '54001' THEN '540001'
    WHEN '66001' THEN '660001'
    WHEN '17001' THEN '170001'
    WHEN '52001' THEN '520001'
    WHEN '15001' THEN '150001'
    WHEN '73001' THEN '730001'
    WHEN '19001' THEN '190001'
    WHEN '20001' THEN '200001'
    WHEN '23001' THEN '230001'
    WHEN '41001' THEN '410001'
    WHEN '47001' THEN '470001'
    WHEN '50001' THEN '500001'
    WHEN '63001' THEN '630001'
    WHEN '70001' THEN '700001'
    WHEN '18001' THEN '180001'
    WHEN '86001' THEN '860001'
    ELSE c.postal_code
END
WHERE d.country_iso2 = 'CO'
  AND c.code IN (
      '11001','05001','76001','08001','13001','68001','54001','66001','17001','52001',
      '15001','73001','19001','20001','23001','41001','47001','50001','63001','70001',
      '18001','86001'
  );

-- 4) Catálogo de países ISO-3166 ampliado (LATAM, NA, Europa principales).
INSERT IGNORE INTO country (iso2, iso3, numeric_code, name_es, name_en, phone_code, is_active) VALUES
('MX', 'MEX', '484', 'México', 'Mexico', '+52', TRUE),
('AR', 'ARG', '032', 'Argentina', 'Argentina', '+54', TRUE),
('CL', 'CHL', '152', 'Chile', 'Chile', '+56', TRUE),
('PE', 'PER', '604', 'Perú', 'Peru', '+51', TRUE),
('EC', 'ECU', '218', 'Ecuador', 'Ecuador', '+593', TRUE),
('VE', 'VEN', '862', 'Venezuela', 'Venezuela', '+58', TRUE),
('BR', 'BRA', '076', 'Brasil', 'Brazil', '+55', TRUE),
('UY', 'URY', '858', 'Uruguay', 'Uruguay', '+598', TRUE),
('PY', 'PRY', '600', 'Paraguay', 'Paraguay', '+595', TRUE),
('BO', 'BOL', '068', 'Bolivia', 'Bolivia', '+591', TRUE),
('PA', 'PAN', '591', 'Panamá', 'Panama', '+507', TRUE),
('CR', 'CRI', '188', 'Costa Rica', 'Costa Rica', '+506', TRUE),
('GT', 'GTM', '320', 'Guatemala', 'Guatemala', '+502', TRUE),
('HN', 'HND', '340', 'Honduras', 'Honduras', '+504', TRUE),
('SV', 'SLV', '222', 'El Salvador', 'El Salvador', '+503', TRUE),
('NI', 'NIC', '558', 'Nicaragua', 'Nicaragua', '+505', TRUE),
('DO', 'DOM', '214', 'República Dominicana', 'Dominican Republic', '+1', TRUE),
('CU', 'CUB', '192', 'Cuba', 'Cuba', '+53', TRUE),
('PR', 'PRI', '630', 'Puerto Rico', 'Puerto Rico', '+1', TRUE),
('CA', 'CAN', '124', 'Canadá', 'Canada', '+1', TRUE),
('ES', 'ESP', '724', 'España', 'Spain', '+34', TRUE),
('PT', 'PRT', '620', 'Portugal', 'Portugal', '+351', TRUE),
('FR', 'FRA', '250', 'Francia', 'France', '+33', TRUE),
('DE', 'DEU', '276', 'Alemania', 'Germany', '+49', TRUE),
('IT', 'ITA', '380', 'Italia', 'Italy', '+39', TRUE),
('GB', 'GBR', '826', 'Reino Unido', 'United Kingdom', '+44', TRUE),
('IE', 'IRL', '372', 'Irlanda', 'Ireland', '+353', TRUE),
('NL', 'NLD', '528', 'Países Bajos', 'Netherlands', '+31', TRUE),
('BE', 'BEL', '056', 'Bélgica', 'Belgium', '+32', TRUE),
('CH', 'CHE', '756', 'Suiza', 'Switzerland', '+41', TRUE),
('AT', 'AUT', '040', 'Austria', 'Austria', '+43', TRUE),
('SE', 'SWE', '752', 'Suecia', 'Sweden', '+46', TRUE),
('NO', 'NOR', '578', 'Noruega', 'Norway', '+47', TRUE),
('DK', 'DNK', '208', 'Dinamarca', 'Denmark', '+45', TRUE),
('FI', 'FIN', '246', 'Finlandia', 'Finland', '+358', TRUE),
('PL', 'POL', '616', 'Polonia', 'Poland', '+48', TRUE),
('CZ', 'CZE', '203', 'Chequia', 'Czechia', '+420', TRUE),
('RO', 'ROU', '642', 'Rumania', 'Romania', '+40', TRUE),
('GR', 'GRC', '300', 'Grecia', 'Greece', '+30', TRUE),
('TR', 'TUR', '792', 'Turquía', 'Turkey', '+90', TRUE),
('AU', 'AUS', '036', 'Australia', 'Australia', '+61', TRUE),
('NZ', 'NZL', '554', 'Nueva Zelanda', 'New Zealand', '+64', TRUE),
('JP', 'JPN', '392', 'Japón', 'Japan', '+81', TRUE),
('CN', 'CHN', '156', 'China', 'China', '+86', TRUE),
('KR', 'KOR', '410', 'Corea del Sur', 'South Korea', '+82', TRUE),
('IN', 'IND', '356', 'India', 'India', '+91', TRUE),
('IL', 'ISR', '376', 'Israel', 'Israel', '+972', TRUE),
('AE', 'ARE', '784', 'Emiratos Árabes Unidos', 'United Arab Emirates', '+971', TRUE),
('ZA', 'ZAF', '710', 'Sudáfrica', 'South Africa', '+27', TRUE);
