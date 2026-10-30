-- F3 catalog schema: countries, DIVIPOLA, document types, positions and disability categories.
-- Primary keys are single column. Natural keys are used for preset catalogs.

CREATE TABLE IF NOT EXISTS country (
    iso2 CHAR(2) NOT NULL,
    iso3 CHAR(3) NOT NULL,
    numeric_code CHAR(3) NULL,
    name_es VARCHAR(120) NOT NULL,
    name_en VARCHAR(120) NOT NULL,
    phone_code VARCHAR(10) NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (iso2),
    UNIQUE KEY uk_country_iso3 (iso3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS department_state (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    country_iso2 CHAR(2) NOT NULL,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(120) NOT NULL,
    type VARCHAR(20) NOT NULL DEFAULT 'DEPARTMENT',
    code_type VARCHAR(20) NOT NULL DEFAULT 'DIVIPOLA',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (id),
    UNIQUE KEY uk_department_state (country_iso2, code_type, code),
    KEY idx_department_state_country (country_iso2),
    CONSTRAINT fk_department_state_country FOREIGN KEY (country_iso2) REFERENCES country (iso2) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS city (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    department_state_id BIGINT UNSIGNED NOT NULL,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(150) NOT NULL,
    code_type VARCHAR(20) NOT NULL DEFAULT 'DIVIPOLA',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (id),
    UNIQUE KEY uk_city (department_state_id, code),
    KEY idx_city_department_name (department_state_id, name),
    CONSTRAINT fk_city_department FOREIGN KEY (department_state_id) REFERENCES department_state (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS document_type (
    code VARCHAR(20) NOT NULL,
    country_iso2 CHAR(2) NOT NULL,
    name VARCHAR(120) NOT NULL,
    applies_to VARCHAR(20) NOT NULL DEFAULT 'PERSON',
    regex VARCHAR(200) NULL,
    min_length INT NULL,
    max_length INT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (code),
    KEY idx_document_type_country (country_iso2),
    CONSTRAINT fk_document_type_country FOREIGN KEY (country_iso2) REFERENCES country (iso2) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS position (
    code VARCHAR(40) NOT NULL,
    name VARCHAR(120) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS disability_category (
    code CHAR(2) NOT NULL,
    name VARCHAR(120) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO country (iso2, iso3, numeric_code, name_es, name_en, phone_code) VALUES
    ('CO', 'COL', '170', 'Colombia', 'Colombia', '+57'),
    ('US', 'USA', '840', 'Estados Unidos', 'United States', '+1')
ON DUPLICATE KEY UPDATE name_es = VALUES(name_es), name_en = VALUES(name_en), phone_code = VALUES(phone_code);

INSERT INTO document_type (code, country_iso2, name, applies_to, regex, min_length, max_length) VALUES
    ('CC', 'CO', 'Cédula de ciudadanía', 'PERSON', '^[0-9]{6,10}$', 6, 10),
    ('CE', 'CO', 'Cédula de extranjería', 'PERSON', '^[A-Za-z0-9]{5,15}$', 5, 15),
    ('PA', 'CO', 'Pasaporte', 'BOTH', '^[A-Za-z0-9]{5,20}$', 5, 20),
    ('TI', 'CO', 'Tarjeta de identidad', 'PERSON', '^[0-9]{6,12}$', 6, 12),
    ('RC', 'CO', 'Registro civil', 'PERSON', '^[0-9]{6,15}$', 6, 15),
    ('NIT', 'CO', 'NIT', 'ORGANIZATION', '^[0-9]{9,15}$', 9, 15),
    ('SD', 'CO', 'Sin documento (migración)', 'BOTH', '^LEGACY-[0-9]+$', 7, 60)
ON DUPLICATE KEY UPDATE name = VALUES(name), applies_to = VALUES(applies_to), regex = VALUES(regex),
    min_length = VALUES(min_length), max_length = VALUES(max_length);

INSERT INTO position (code, name, sort_order) VALUES
    ('SOCIO', 'Socio', 10),
    ('ABOGADO_SENIOR', 'Abogado Senior', 20),
    ('ABOGADO_JUNIOR', 'Abogado Junior', 30),
    ('AUXILIAR', 'Auxiliar', 40),
    ('SECRETARIA', 'Secretaria', 50),
    ('RECEPCIONISTA', 'Recepcionista', 60),
    ('ADMINISTRADOR', 'Administrador', 70),
    ('CONTADOR', 'Contador', 80)
ON DUPLICATE KEY UPDATE name = VALUES(name), sort_order = VALUES(sort_order);

INSERT INTO disability_category (code, name, sort_order) VALUES
    ('01', 'Física', 1),
    ('02', 'Visual', 2),
    ('03', 'Auditiva', 3),
    ('04', 'Intelectual', 4),
    ('05', 'Psicosocial', 5),
    ('06', 'Sordoceguera', 6),
    ('07', 'Múltiple', 7),
    ('08', 'Sin discapacidad', 8)
ON DUPLICATE KEY UPDATE name = VALUES(name), sort_order = VALUES(sort_order);

INSERT INTO department_state (country_iso2, code, name, type, code_type) VALUES
    ('CO', '05', 'Antioquia', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '08', 'Atlántico', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '11', 'Bogotá D.C.', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '13', 'Bolívar', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '15', 'Boyacá', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '17', 'Caldas', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '18', 'Caquetá', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '19', 'Cauca', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '20', 'Cesar', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '23', 'Córdoba', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '25', 'Cundinamarca', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '27', 'Chocó', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '41', 'Huila', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '44', 'La Guajira', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '47', 'Magdalena', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '50', 'Meta', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '52', 'Nariño', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '54', 'Norte de Santander', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '63', 'Quindío', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '66', 'Risaralda', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '68', 'Santander', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '70', 'Sucre', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '73', 'Tolima', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '76', 'Valle del Cauca', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '81', 'Arauca', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '85', 'Casanare', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '86', 'Putumayo', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '88', 'San Andrés y Providencia', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '91', 'Amazonas', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '94', 'Guainía', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '95', 'Guaviare', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '97', 'Vaupés', 'DEPARTMENT', 'DIVIPOLA'),
    ('CO', '99', 'Vichada', 'DEPARTMENT', 'DIVIPOLA')
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO city (department_state_id, code, name)
SELECT d.id, v.code, v.name
FROM department_state d
JOIN (
    SELECT '05' AS dept, '05001' AS code, 'Medellín' AS name UNION ALL
    SELECT '05', '05088', 'Bello' UNION ALL
    SELECT '05', '05129', 'Caldas' UNION ALL
    SELECT '05', '05266', 'Envigado' UNION ALL
    SELECT '05', '05360', 'Itagüí' UNION ALL
    SELECT '05', '05615', 'Rionegro' UNION ALL
    SELECT '08', '08001', 'Barranquilla' UNION ALL
    SELECT '08', '08758', 'Soledad' UNION ALL
    SELECT '11', '11001', 'Bogotá D.C.' UNION ALL
    SELECT '13', '13001', 'Cartagena' UNION ALL
    SELECT '15', '15001', 'Tunja' UNION ALL
    SELECT '17', '17001', 'Manizales' UNION ALL
    SELECT '17', '17380', 'Villamaría' UNION ALL
    SELECT '18', '18001', 'Florencia' UNION ALL
    SELECT '19', '19001', 'Popayán' UNION ALL
    SELECT '20', '20001', 'Valledupar' UNION ALL
    SELECT '20', '20011', 'Aguachica' UNION ALL
    SELECT '23', '23001', 'Montería' UNION ALL
    SELECT '23', '23417', 'Cereté' UNION ALL
    SELECT '25', '25175', 'Chía' UNION ALL
    SELECT '25', '25286', 'Funza' UNION ALL
    SELECT '25', '25473', 'Mosquera' UNION ALL
    SELECT '25', '25754', 'Soacha' UNION ALL
    SELECT '25', '25899', 'Zipaquirá' UNION ALL
    SELECT '27', '27001', 'Quibdó' UNION ALL
    SELECT '41', '41001', 'Neiva' UNION ALL
    SELECT '44', '44001', 'Riohacha' UNION ALL
    SELECT '47', '47001', 'Santa Marta' UNION ALL
    SELECT '50', '50001', 'Villavicencio' UNION ALL
    SELECT '52', '52001', 'Pasto' UNION ALL
    SELECT '54', '54001', 'Cúcuta' UNION ALL
    SELECT '63', '63001', 'Armenia' UNION ALL
    SELECT '63', '63130', 'Calarcá' UNION ALL
    SELECT '66', '66001', 'Pereira' UNION ALL
    SELECT '66', '66170', 'Dosquebradas' UNION ALL
    SELECT '66', '66682', 'Santa Rosa de Cabal' UNION ALL
    SELECT '68', '68001', 'Bucaramanga' UNION ALL
    SELECT '68', '68081', 'Barrancabermeja' UNION ALL
    SELECT '68', '68307', 'Girón' UNION ALL
    SELECT '68', '68547', 'Piedecuesta' UNION ALL
    SELECT '70', '70001', 'Sincelejo' UNION ALL
    SELECT '73', '73001', 'Ibagué' UNION ALL
    SELECT '73', '73268', 'Espinal' UNION ALL
    SELECT '76', '76001', 'Cali' UNION ALL
    SELECT '76', '76147', 'Palmira' UNION ALL
    SELECT '76', '76520', 'Tuluá' UNION ALL
    SELECT '76', '76834', 'Buenaventura' UNION ALL
    SELECT '81', '81001', 'Arauca' UNION ALL
    SELECT '85', '85001', 'Yopal' UNION ALL
    SELECT '86', '86001', 'Mocoa' UNION ALL
    SELECT '88', '88001', 'San Andrés' UNION ALL
    SELECT '91', '91001', 'Leticia' UNION ALL
    SELECT '94', '94001', 'Inírida' UNION ALL
    SELECT '95', '95001', 'San José del Guaviare' UNION ALL
    SELECT '97', '97001', 'Mitú' UNION ALL
    SELECT '99', '99001', 'Puerto Carreño'
) v ON v.dept = d.code
WHERE d.country_iso2 = 'CO'
ON DUPLICATE KEY UPDATE name = VALUES(name);
