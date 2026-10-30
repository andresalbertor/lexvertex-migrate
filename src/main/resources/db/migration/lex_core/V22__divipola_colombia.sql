-- V22: Sincronizacion completa de DIVIPOLA (Departamentos y Municipios de Colombia)

-- 1. Desactivar todos los registros actuales de Colombia
UPDATE department_state SET is_active = FALSE WHERE country_iso2 = 'CO';
UPDATE city c 
JOIN department_state d ON c.department_state_id = d.id 
SET c.is_active = FALSE 
WHERE d.country_iso2 = 'CO';

-- 2. Insertar / Actualizar departamentos
INSERT INTO department_state (country_iso2, code, name, type, code_type, is_active) VALUES
    ('CO', '05', 'Antioquia', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '08', 'Atlántico', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '11', 'Bogotá, D.C.', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '13', 'Bolívar', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '15', 'Boyacá', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '17', 'Caldas', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '18', 'Caquetá', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '19', 'Cauca', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '20', 'Cesar', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '23', 'Córdoba', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '25', 'Cundinamarca', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '27', 'Chocó', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '41', 'Huila', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '44', 'La Guajira', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '47', 'Magdalena', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '50', 'Meta', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '52', 'Nariño', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '54', 'Norte de Santander', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '63', 'Quindío', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '66', 'Risaralda', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '68', 'Santander', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '70', 'Sucre', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '73', 'Tolima', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '76', 'Valle del Cauca', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '81', 'Arauca', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '85', 'Casanare', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '86', 'Putumayo', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '88', 'Archipiélago de San Andrés, Providencia y Santa Catalina', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '91', 'Amazonas', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '94', 'Guainía', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '95', 'Guaviare', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '97', 'Vaupés', 'DEPARTMENT', 'DIVIPOLA', TRUE),
    ('CO', '99', 'Vichada', 'DEPARTMENT', 'DIVIPOLA', TRUE)
ON DUPLICATE KEY UPDATE name = VALUES(name), is_active = TRUE;

-- 3. Insertar / Actualizar municipios
INSERT INTO city (department_state_id, code, name, code_type, is_active)
SELECT d.id, v.code, v.name, 'DIVIPOLA', TRUE
FROM department_state d
JOIN (
    SELECT '05' AS dept, '05001' AS code, 'Medellín' AS name UNION ALL
    SELECT '05' AS dept, '05002' AS code, 'Abejorral' AS name UNION ALL
    SELECT '05' AS dept, '05004' AS code, 'Abriaquí' AS name UNION ALL
    SELECT '05' AS dept, '05021' AS code, 'Alejandría' AS name UNION ALL
    SELECT '05' AS dept, '05030' AS code, 'Amagá' AS name UNION ALL
    SELECT '05' AS dept, '05031' AS code, 'Amalfi' AS name UNION ALL
    SELECT '05' AS dept, '05034' AS code, 'Andes' AS name UNION ALL
    SELECT '05' AS dept, '05036' AS code, 'Angelópolis' AS name UNION ALL
    SELECT '05' AS dept, '05038' AS code, 'Angostura' AS name UNION ALL
    SELECT '05' AS dept, '05040' AS code, 'Anorí' AS name UNION ALL
    SELECT '05' AS dept, '05042' AS code, 'Santa Fé de Antioquia' AS name UNION ALL
    SELECT '05' AS dept, '05044' AS code, 'Anzá' AS name UNION ALL
    SELECT '05' AS dept, '05045' AS code, 'Apartadó' AS name UNION ALL
    SELECT '05' AS dept, '05051' AS code, 'Arboletes' AS name UNION ALL
    SELECT '05' AS dept, '05055' AS code, 'Argelia' AS name UNION ALL
    SELECT '05' AS dept, '05059' AS code, 'Armenia' AS name UNION ALL
    SELECT '05' AS dept, '05079' AS code, 'Barbosa' AS name UNION ALL
    SELECT '05' AS dept, '05086' AS code, 'Belmira' AS name UNION ALL
    SELECT '05' AS dept, '05088' AS code, 'Bello' AS name UNION ALL
    SELECT '05' AS dept, '05091' AS code, 'Betania' AS name UNION ALL
    SELECT '05' AS dept, '05093' AS code, 'Betulia' AS name UNION ALL
    SELECT '05' AS dept, '05101' AS code, 'Ciudad Bolívar' AS name UNION ALL
    SELECT '05' AS dept, '05107' AS code, 'Briceño' AS name UNION ALL
    SELECT '05' AS dept, '05113' AS code, 'Buriticá' AS name UNION ALL
    SELECT '05' AS dept, '05120' AS code, 'Cáceres' AS name UNION ALL
    SELECT '05' AS dept, '05125' AS code, 'Caicedo' AS name UNION ALL
    SELECT '05' AS dept, '05129' AS code, 'Caldas' AS name UNION ALL
    SELECT '05' AS dept, '05134' AS code, 'Campamento' AS name UNION ALL
    SELECT '05' AS dept, '05138' AS code, 'Cañasgordas' AS name UNION ALL
    SELECT '05' AS dept, '05142' AS code, 'Caracolí' AS name UNION ALL
    SELECT '05' AS dept, '05145' AS code, 'Caramanta' AS name UNION ALL
    SELECT '05' AS dept, '05147' AS code, 'Carepa' AS name UNION ALL
    SELECT '05' AS dept, '05148' AS code, 'El Carmen de Viboral' AS name UNION ALL
    SELECT '05' AS dept, '05150' AS code, 'Carolina' AS name UNION ALL
    SELECT '05' AS dept, '05154' AS code, 'Caucasia' AS name UNION ALL
    SELECT '05' AS dept, '05172' AS code, 'Chigorodó' AS name UNION ALL
    SELECT '05' AS dept, '05190' AS code, 'Cisneros' AS name UNION ALL
    SELECT '05' AS dept, '05197' AS code, 'Cocorná' AS name UNION ALL
    SELECT '05' AS dept, '05206' AS code, 'Concepción' AS name UNION ALL
    SELECT '05' AS dept, '05209' AS code, 'Concordia' AS name UNION ALL
    SELECT '05' AS dept, '05212' AS code, 'Copacabana' AS name UNION ALL
    SELECT '05' AS dept, '05234' AS code, 'Dabeiba' AS name UNION ALL
    SELECT '05' AS dept, '05237' AS code, 'Donmatías' AS name UNION ALL
    SELECT '05' AS dept, '05240' AS code, 'Ebéjico' AS name UNION ALL
    SELECT '05' AS dept, '05250' AS code, 'El Bagre' AS name UNION ALL
    SELECT '05' AS dept, '05264' AS code, 'Entrerríos' AS name UNION ALL
    SELECT '05' AS dept, '05266' AS code, 'Envigado' AS name UNION ALL
    SELECT '05' AS dept, '05282' AS code, 'Fredonia' AS name UNION ALL
    SELECT '05' AS dept, '05284' AS code, 'Frontino' AS name UNION ALL
    SELECT '05' AS dept, '05306' AS code, 'Giraldo' AS name UNION ALL
    SELECT '05' AS dept, '05308' AS code, 'Girardota' AS name UNION ALL
    SELECT '05' AS dept, '05310' AS code, 'Gómez Plata' AS name UNION ALL
    SELECT '05' AS dept, '05313' AS code, 'Granada' AS name UNION ALL
    SELECT '05' AS dept, '05315' AS code, 'Guadalupe' AS name UNION ALL
    SELECT '05' AS dept, '05318' AS code, 'Guarne' AS name UNION ALL
    SELECT '05' AS dept, '05321' AS code, 'Guatapé' AS name UNION ALL
    SELECT '05' AS dept, '05347' AS code, 'Heliconia' AS name UNION ALL
    SELECT '05' AS dept, '05353' AS code, 'Hispania' AS name UNION ALL
    SELECT '05' AS dept, '05360' AS code, 'Itagüí' AS name UNION ALL
    SELECT '05' AS dept, '05361' AS code, 'Ituango' AS name UNION ALL
    SELECT '05' AS dept, '05364' AS code, 'Jardín' AS name UNION ALL
    SELECT '05' AS dept, '05368' AS code, 'Jericó' AS name UNION ALL
    SELECT '05' AS dept, '05376' AS code, 'La Ceja' AS name UNION ALL
    SELECT '05' AS dept, '05380' AS code, 'La Estrella' AS name UNION ALL
    SELECT '05' AS dept, '05390' AS code, 'La Pintada' AS name UNION ALL
    SELECT '05' AS dept, '05400' AS code, 'La Unión' AS name UNION ALL
    SELECT '05' AS dept, '05411' AS code, 'Liborina' AS name UNION ALL
    SELECT '05' AS dept, '05425' AS code, 'Maceo' AS name UNION ALL
    SELECT '05' AS dept, '05440' AS code, 'Marinilla' AS name UNION ALL
    SELECT '05' AS dept, '05467' AS code, 'Montebello' AS name UNION ALL
    SELECT '05' AS dept, '05475' AS code, 'Murindó' AS name UNION ALL
    SELECT '05' AS dept, '05480' AS code, 'Mutatá' AS name UNION ALL
    SELECT '05' AS dept, '05483' AS code, 'Nariño' AS name UNION ALL
    SELECT '05' AS dept, '05490' AS code, 'Necoclí' AS name UNION ALL
    SELECT '05' AS dept, '05495' AS code, 'Nechí' AS name UNION ALL
    SELECT '05' AS dept, '05501' AS code, 'Olaya' AS name UNION ALL
    SELECT '05' AS dept, '05541' AS code, 'Peñol' AS name UNION ALL
    SELECT '05' AS dept, '05543' AS code, 'Peque' AS name UNION ALL
    SELECT '05' AS dept, '05576' AS code, 'Pueblorrico' AS name UNION ALL
    SELECT '05' AS dept, '05579' AS code, 'Puerto Berrío' AS name UNION ALL
    SELECT '05' AS dept, '05585' AS code, 'Puerto Nare' AS name UNION ALL
    SELECT '05' AS dept, '05591' AS code, 'Puerto Triunfo' AS name UNION ALL
    SELECT '05' AS dept, '05604' AS code, 'Remedios' AS name UNION ALL
    SELECT '05' AS dept, '05607' AS code, 'Retiro' AS name UNION ALL
    SELECT '05' AS dept, '05615' AS code, 'Rionegro' AS name UNION ALL
    SELECT '05' AS dept, '05628' AS code, 'Sabanalarga' AS name UNION ALL
    SELECT '05' AS dept, '05631' AS code, 'Sabaneta' AS name UNION ALL
    SELECT '05' AS dept, '05642' AS code, 'Salgar' AS name UNION ALL
    SELECT '05' AS dept, '05647' AS code, 'San Andrés de Cuerquía' AS name UNION ALL
    SELECT '05' AS dept, '05649' AS code, 'San Carlos' AS name UNION ALL
    SELECT '05' AS dept, '05652' AS code, 'San Francisco' AS name UNION ALL
    SELECT '05' AS dept, '05656' AS code, 'San Jerónimo' AS name UNION ALL
    SELECT '05' AS dept, '05658' AS code, 'San José de la Montaña' AS name UNION ALL
    SELECT '05' AS dept, '05659' AS code, 'San Juan de Urabá' AS name UNION ALL
    SELECT '05' AS dept, '05660' AS code, 'San Luis' AS name UNION ALL
    SELECT '05' AS dept, '05664' AS code, 'San Pedro de los Milagros' AS name UNION ALL
    SELECT '05' AS dept, '05665' AS code, 'San Pedro de Urabá' AS name UNION ALL
    SELECT '05' AS dept, '05667' AS code, 'San Rafael' AS name UNION ALL
    SELECT '05' AS dept, '05670' AS code, 'San Roque' AS name UNION ALL
    SELECT '05' AS dept, '05674' AS code, 'San Vicente Ferrer' AS name UNION ALL
    SELECT '05' AS dept, '05679' AS code, 'Santa Bárbara' AS name UNION ALL
    SELECT '05' AS dept, '05686' AS code, 'Santa Rosa de Osos' AS name UNION ALL
    SELECT '05' AS dept, '05690' AS code, 'Santo Domingo' AS name UNION ALL
    SELECT '05' AS dept, '05697' AS code, 'El Santuario' AS name UNION ALL
    SELECT '05' AS dept, '05736' AS code, 'Segovia' AS name UNION ALL
    SELECT '05' AS dept, '05756' AS code, 'Sonsón' AS name UNION ALL
    SELECT '05' AS dept, '05761' AS code, 'Sopetrán' AS name UNION ALL
    SELECT '05' AS dept, '05789' AS code, 'Támesis' AS name UNION ALL
    SELECT '05' AS dept, '05790' AS code, 'Tarazá' AS name UNION ALL
    SELECT '05' AS dept, '05792' AS code, 'Tarso' AS name UNION ALL
    SELECT '05' AS dept, '05809' AS code, 'Titiribí' AS name UNION ALL
    SELECT '05' AS dept, '05819' AS code, 'Toledo' AS name UNION ALL
    SELECT '05' AS dept, '05837' AS code, 'Turbo' AS name UNION ALL
    SELECT '05' AS dept, '05842' AS code, 'Uramita' AS name UNION ALL
    SELECT '05' AS dept, '05847' AS code, 'Urrao' AS name UNION ALL
    SELECT '05' AS dept, '05854' AS code, 'Valdivia' AS name UNION ALL
    SELECT '05' AS dept, '05856' AS code, 'Valparaíso' AS name UNION ALL
    SELECT '05' AS dept, '05858' AS code, 'Vegachí' AS name UNION ALL
    SELECT '05' AS dept, '05861' AS code, 'Venecia' AS name UNION ALL
    SELECT '05' AS dept, '05873' AS code, 'Vigía del Fuerte' AS name UNION ALL
    SELECT '05' AS dept, '05885' AS code, 'Yalí' AS name UNION ALL
    SELECT '05' AS dept, '05887' AS code, 'Yarumal' AS name UNION ALL
    SELECT '05' AS dept, '05890' AS code, 'Yolombó' AS name UNION ALL
    SELECT '05' AS dept, '05893' AS code, 'Yondó' AS name UNION ALL
    SELECT '05' AS dept, '05895' AS code, 'Zaragoza' AS name UNION ALL
    SELECT '08' AS dept, '08001' AS code, 'Barranquilla' AS name UNION ALL
    SELECT '08' AS dept, '08078' AS code, 'Baranoa' AS name UNION ALL
    SELECT '08' AS dept, '08137' AS code, 'Campo de la Cruz' AS name UNION ALL
    SELECT '08' AS dept, '08141' AS code, 'Candelaria' AS name UNION ALL
    SELECT '08' AS dept, '08296' AS code, 'Galapa' AS name UNION ALL
    SELECT '08' AS dept, '08372' AS code, 'Juan de Acosta' AS name UNION ALL
    SELECT '08' AS dept, '08421' AS code, 'Luruaco' AS name UNION ALL
    SELECT '08' AS dept, '08433' AS code, 'Malambo' AS name UNION ALL
    SELECT '08' AS dept, '08436' AS code, 'Manatí' AS name UNION ALL
    SELECT '08' AS dept, '08520' AS code, 'Palmar de Varela' AS name UNION ALL
    SELECT '08' AS dept, '08549' AS code, 'Piojó' AS name UNION ALL
    SELECT '08' AS dept, '08558' AS code, 'Polonuevo' AS name UNION ALL
    SELECT '08' AS dept, '08560' AS code, 'Ponedera' AS name UNION ALL
    SELECT '08' AS dept, '08573' AS code, 'Puerto Colombia' AS name UNION ALL
    SELECT '08' AS dept, '08606' AS code, 'Repelón' AS name UNION ALL
    SELECT '08' AS dept, '08634' AS code, 'Sabanagrande' AS name UNION ALL
    SELECT '08' AS dept, '08638' AS code, 'Sabanalarga' AS name UNION ALL
    SELECT '08' AS dept, '08675' AS code, 'Santa Lucía' AS name UNION ALL
    SELECT '08' AS dept, '08685' AS code, 'Santo Tomás' AS name UNION ALL
    SELECT '08' AS dept, '08758' AS code, 'Soledad' AS name UNION ALL
    SELECT '08' AS dept, '08770' AS code, 'Suan' AS name UNION ALL
    SELECT '08' AS dept, '08832' AS code, 'Tubará' AS name UNION ALL
    SELECT '08' AS dept, '08849' AS code, 'Usiacurí' AS name UNION ALL
    SELECT '11' AS dept, '11001' AS code, 'Bogotá, D.C.' AS name UNION ALL
    SELECT '13' AS dept, '13001' AS code, 'Cartagena de Indias' AS name UNION ALL
    SELECT '13' AS dept, '13006' AS code, 'Achí' AS name UNION ALL
    SELECT '13' AS dept, '13030' AS code, 'Altos del Rosario' AS name UNION ALL
    SELECT '13' AS dept, '13042' AS code, 'Arenal' AS name UNION ALL
    SELECT '13' AS dept, '13052' AS code, 'Arjona' AS name UNION ALL
    SELECT '13' AS dept, '13062' AS code, 'Arroyohondo' AS name UNION ALL
    SELECT '13' AS dept, '13074' AS code, 'Barranco de Loba' AS name UNION ALL
    SELECT '13' AS dept, '13140' AS code, 'Calamar' AS name UNION ALL
    SELECT '13' AS dept, '13160' AS code, 'Cantagallo' AS name UNION ALL
    SELECT '13' AS dept, '13188' AS code, 'Cicuco' AS name UNION ALL
    SELECT '13' AS dept, '13212' AS code, 'Córdoba' AS name UNION ALL
    SELECT '13' AS dept, '13222' AS code, 'Clemencia' AS name UNION ALL
    SELECT '13' AS dept, '13244' AS code, 'El Carmen de Bolívar' AS name UNION ALL
    SELECT '13' AS dept, '13248' AS code, 'El Guamo' AS name UNION ALL
    SELECT '13' AS dept, '13268' AS code, 'El Peñón' AS name UNION ALL
    SELECT '13' AS dept, '13300' AS code, 'Hatillo de Loba' AS name UNION ALL
    SELECT '13' AS dept, '13430' AS code, 'Magangué' AS name UNION ALL
    SELECT '13' AS dept, '13433' AS code, 'Mahates' AS name UNION ALL
    SELECT '13' AS dept, '13440' AS code, 'Margarita' AS name UNION ALL
    SELECT '13' AS dept, '13442' AS code, 'María la Baja' AS name UNION ALL
    SELECT '13' AS dept, '13458' AS code, 'Montecristo' AS name UNION ALL
    SELECT '13' AS dept, '13468' AS code, 'Santa Cruz de Mompox' AS name UNION ALL
    SELECT '13' AS dept, '13473' AS code, 'Morales' AS name UNION ALL
    SELECT '13' AS dept, '13490' AS code, 'Norosí' AS name UNION ALL
    SELECT '13' AS dept, '13549' AS code, 'Pinillos' AS name UNION ALL
    SELECT '13' AS dept, '13580' AS code, 'Regidor' AS name UNION ALL
    SELECT '13' AS dept, '13600' AS code, 'Río Viejo' AS name UNION ALL
    SELECT '13' AS dept, '13620' AS code, 'San Cristóbal' AS name UNION ALL
    SELECT '13' AS dept, '13647' AS code, 'San Estanislao' AS name UNION ALL
    SELECT '13' AS dept, '13650' AS code, 'San Fernando' AS name UNION ALL
    SELECT '13' AS dept, '13654' AS code, 'San Jacinto' AS name UNION ALL
    SELECT '13' AS dept, '13655' AS code, 'San Jacinto del Cauca' AS name UNION ALL
    SELECT '13' AS dept, '13657' AS code, 'San Juan Nepomuceno' AS name UNION ALL
    SELECT '13' AS dept, '13667' AS code, 'San Martín de Loba' AS name UNION ALL
    SELECT '13' AS dept, '13670' AS code, 'San Pablo' AS name UNION ALL
    SELECT '13' AS dept, '13673' AS code, 'Santa Catalina' AS name UNION ALL
    SELECT '13' AS dept, '13683' AS code, 'Santa Rosa' AS name UNION ALL
    SELECT '13' AS dept, '13688' AS code, 'Santa Rosa del Sur' AS name UNION ALL
    SELECT '13' AS dept, '13744' AS code, 'Simití' AS name UNION ALL
    SELECT '13' AS dept, '13760' AS code, 'Soplaviento' AS name UNION ALL
    SELECT '13' AS dept, '13780' AS code, 'Talaigua Nuevo' AS name UNION ALL
    SELECT '13' AS dept, '13810' AS code, 'Tiquisio' AS name UNION ALL
    SELECT '13' AS dept, '13836' AS code, 'Turbaco' AS name UNION ALL
    SELECT '13' AS dept, '13838' AS code, 'Turbaná' AS name UNION ALL
    SELECT '13' AS dept, '13873' AS code, 'Villanueva' AS name UNION ALL
    SELECT '13' AS dept, '13894' AS code, 'Zambrano' AS name UNION ALL
    SELECT '15' AS dept, '15001' AS code, 'Tunja' AS name UNION ALL
    SELECT '15' AS dept, '15022' AS code, 'Almeida' AS name UNION ALL
    SELECT '15' AS dept, '15047' AS code, 'Aquitania' AS name UNION ALL
    SELECT '15' AS dept, '15051' AS code, 'Arcabuco' AS name UNION ALL
    SELECT '15' AS dept, '15087' AS code, 'Belén' AS name UNION ALL
    SELECT '15' AS dept, '15090' AS code, 'Berbeo' AS name UNION ALL
    SELECT '15' AS dept, '15092' AS code, 'Betéitiva' AS name UNION ALL
    SELECT '15' AS dept, '15097' AS code, 'Boavita' AS name UNION ALL
    SELECT '15' AS dept, '15104' AS code, 'Boyacá' AS name UNION ALL
    SELECT '15' AS dept, '15106' AS code, 'Briceño' AS name UNION ALL
    SELECT '15' AS dept, '15109' AS code, 'Buenavista' AS name UNION ALL
    SELECT '15' AS dept, '15114' AS code, 'Busbanzá' AS name UNION ALL
    SELECT '15' AS dept, '15131' AS code, 'Caldas' AS name UNION ALL
    SELECT '15' AS dept, '15135' AS code, 'Campohermoso' AS name UNION ALL
    SELECT '15' AS dept, '15162' AS code, 'Cerinza' AS name UNION ALL
    SELECT '15' AS dept, '15172' AS code, 'Chinavita' AS name UNION ALL
    SELECT '15' AS dept, '15176' AS code, 'Chiquinquirá' AS name UNION ALL
    SELECT '15' AS dept, '15180' AS code, 'Chiscas' AS name UNION ALL
    SELECT '15' AS dept, '15183' AS code, 'Chita' AS name UNION ALL
    SELECT '15' AS dept, '15185' AS code, 'Chitaraque' AS name UNION ALL
    SELECT '15' AS dept, '15187' AS code, 'Chivatá' AS name UNION ALL
    SELECT '15' AS dept, '15189' AS code, 'Ciénega' AS name UNION ALL
    SELECT '15' AS dept, '15204' AS code, 'Cómbita' AS name UNION ALL
    SELECT '15' AS dept, '15212' AS code, 'Coper' AS name UNION ALL
    SELECT '15' AS dept, '15215' AS code, 'Corrales' AS name UNION ALL
    SELECT '15' AS dept, '15218' AS code, 'Covarachía' AS name UNION ALL
    SELECT '15' AS dept, '15223' AS code, 'Cubará' AS name UNION ALL
    SELECT '15' AS dept, '15224' AS code, 'Cucaita' AS name UNION ALL
    SELECT '15' AS dept, '15226' AS code, 'Cuítiva' AS name UNION ALL
    SELECT '15' AS dept, '15232' AS code, 'Chíquiza' AS name UNION ALL
    SELECT '15' AS dept, '15236' AS code, 'Chivor' AS name UNION ALL
    SELECT '15' AS dept, '15238' AS code, 'Duitama' AS name UNION ALL
    SELECT '15' AS dept, '15244' AS code, 'El Cocuy' AS name UNION ALL
    SELECT '15' AS dept, '15248' AS code, 'El Espino' AS name UNION ALL
    SELECT '15' AS dept, '15272' AS code, 'Firavitoba' AS name UNION ALL
    SELECT '15' AS dept, '15276' AS code, 'Floresta' AS name UNION ALL
    SELECT '15' AS dept, '15293' AS code, 'Gachantivá' AS name UNION ALL
    SELECT '15' AS dept, '15296' AS code, 'Gámeza' AS name UNION ALL
    SELECT '15' AS dept, '15299' AS code, 'Garagoa' AS name UNION ALL
    SELECT '15' AS dept, '15317' AS code, 'Guacamayas' AS name UNION ALL
    SELECT '15' AS dept, '15322' AS code, 'Guateque' AS name UNION ALL
    SELECT '15' AS dept, '15325' AS code, 'Guayatá' AS name UNION ALL
    SELECT '15' AS dept, '15332' AS code, 'Güicán de la Sierra' AS name UNION ALL
    SELECT '15' AS dept, '15362' AS code, 'Iza' AS name UNION ALL
    SELECT '15' AS dept, '15367' AS code, 'Jenesano' AS name UNION ALL
    SELECT '15' AS dept, '15368' AS code, 'Jericó' AS name UNION ALL
    SELECT '15' AS dept, '15377' AS code, 'Labranzagrande' AS name UNION ALL
    SELECT '15' AS dept, '15380' AS code, 'La Capilla' AS name UNION ALL
    SELECT '15' AS dept, '15401' AS code, 'La Victoria' AS name UNION ALL
    SELECT '15' AS dept, '15403' AS code, 'La Uvita' AS name UNION ALL
    SELECT '15' AS dept, '15407' AS code, 'Villa de Leyva' AS name UNION ALL
    SELECT '15' AS dept, '15425' AS code, 'Macanal' AS name UNION ALL
    SELECT '15' AS dept, '15442' AS code, 'Maripí' AS name UNION ALL
    SELECT '15' AS dept, '15455' AS code, 'Miraflores' AS name UNION ALL
    SELECT '15' AS dept, '15464' AS code, 'Mongua' AS name UNION ALL
    SELECT '15' AS dept, '15466' AS code, 'Monguí' AS name UNION ALL
    SELECT '15' AS dept, '15469' AS code, 'Moniquirá' AS name UNION ALL
    SELECT '15' AS dept, '15476' AS code, 'Motavita' AS name UNION ALL
    SELECT '15' AS dept, '15480' AS code, 'Muzo' AS name UNION ALL
    SELECT '15' AS dept, '15491' AS code, 'Nobsa' AS name UNION ALL
    SELECT '15' AS dept, '15494' AS code, 'Nuevo Colón' AS name UNION ALL
    SELECT '15' AS dept, '15500' AS code, 'Oicatá' AS name UNION ALL
    SELECT '15' AS dept, '15507' AS code, 'Otanche' AS name UNION ALL
    SELECT '15' AS dept, '15511' AS code, 'Pachavita' AS name UNION ALL
    SELECT '15' AS dept, '15514' AS code, 'Páez' AS name UNION ALL
    SELECT '15' AS dept, '15516' AS code, 'Paipa' AS name UNION ALL
    SELECT '15' AS dept, '15518' AS code, 'Pajarito' AS name UNION ALL
    SELECT '15' AS dept, '15522' AS code, 'Panqueba' AS name UNION ALL
    SELECT '15' AS dept, '15531' AS code, 'Pauna' AS name UNION ALL
    SELECT '15' AS dept, '15533' AS code, 'Paya' AS name UNION ALL
    SELECT '15' AS dept, '15537' AS code, 'Paz de Río' AS name UNION ALL
    SELECT '15' AS dept, '15542' AS code, 'Pesca' AS name UNION ALL
    SELECT '15' AS dept, '15550' AS code, 'Pisba' AS name UNION ALL
    SELECT '15' AS dept, '15572' AS code, 'Puerto Boyacá' AS name UNION ALL
    SELECT '15' AS dept, '15580' AS code, 'Quípama' AS name UNION ALL
    SELECT '15' AS dept, '15599' AS code, 'Ramiriquí' AS name UNION ALL
    SELECT '15' AS dept, '15600' AS code, 'Ráquira' AS name UNION ALL
    SELECT '15' AS dept, '15621' AS code, 'Rondón' AS name UNION ALL
    SELECT '15' AS dept, '15632' AS code, 'Saboyá' AS name UNION ALL
    SELECT '15' AS dept, '15638' AS code, 'Sáchica' AS name UNION ALL
    SELECT '15' AS dept, '15646' AS code, 'Samacá' AS name UNION ALL
    SELECT '15' AS dept, '15660' AS code, 'San Eduardo' AS name UNION ALL
    SELECT '15' AS dept, '15664' AS code, 'San José de Pare' AS name UNION ALL
    SELECT '15' AS dept, '15667' AS code, 'San Luis de Gaceno' AS name UNION ALL
    SELECT '15' AS dept, '15673' AS code, 'San Mateo' AS name UNION ALL
    SELECT '15' AS dept, '15676' AS code, 'San Miguel de Sema' AS name UNION ALL
    SELECT '15' AS dept, '15681' AS code, 'San Pablo de Borbur' AS name UNION ALL
    SELECT '15' AS dept, '15686' AS code, 'Santana' AS name UNION ALL
    SELECT '15' AS dept, '15690' AS code, 'Santa María' AS name UNION ALL
    SELECT '15' AS dept, '15693' AS code, 'Santa Rosa de Viterbo' AS name UNION ALL
    SELECT '15' AS dept, '15696' AS code, 'Santa Sofía' AS name UNION ALL
    SELECT '15' AS dept, '15720' AS code, 'Sativanorte' AS name UNION ALL
    SELECT '15' AS dept, '15723' AS code, 'Sativasur' AS name UNION ALL
    SELECT '15' AS dept, '15740' AS code, 'Siachoque' AS name UNION ALL
    SELECT '15' AS dept, '15753' AS code, 'Soatá' AS name UNION ALL
    SELECT '15' AS dept, '15755' AS code, 'Socotá' AS name UNION ALL
    SELECT '15' AS dept, '15757' AS code, 'Socha' AS name UNION ALL
    SELECT '15' AS dept, '15759' AS code, 'Sogamoso' AS name UNION ALL
    SELECT '15' AS dept, '15761' AS code, 'Somondoco' AS name UNION ALL
    SELECT '15' AS dept, '15762' AS code, 'Sora' AS name UNION ALL
    SELECT '15' AS dept, '15763' AS code, 'Sotaquirá' AS name UNION ALL
    SELECT '15' AS dept, '15764' AS code, 'Soracá' AS name UNION ALL
    SELECT '15' AS dept, '15774' AS code, 'Susacón' AS name UNION ALL
    SELECT '15' AS dept, '15776' AS code, 'Sutamarchán' AS name UNION ALL
    SELECT '15' AS dept, '15778' AS code, 'Sutatenza' AS name UNION ALL
    SELECT '15' AS dept, '15790' AS code, 'Tasco' AS name UNION ALL
    SELECT '15' AS dept, '15798' AS code, 'Tenza' AS name UNION ALL
    SELECT '15' AS dept, '15804' AS code, 'Tibaná' AS name UNION ALL
    SELECT '15' AS dept, '15806' AS code, 'Tibasosa' AS name UNION ALL
    SELECT '15' AS dept, '15808' AS code, 'Tinjacá' AS name UNION ALL
    SELECT '15' AS dept, '15810' AS code, 'Tipacoque' AS name UNION ALL
    SELECT '15' AS dept, '15814' AS code, 'Toca' AS name UNION ALL
    SELECT '15' AS dept, '15816' AS code, 'Togüí' AS name UNION ALL
    SELECT '15' AS dept, '15820' AS code, 'Tópaga' AS name UNION ALL
    SELECT '15' AS dept, '15822' AS code, 'Tota' AS name UNION ALL
    SELECT '15' AS dept, '15832' AS code, 'Tununguá' AS name UNION ALL
    SELECT '15' AS dept, '15835' AS code, 'Turmequé' AS name UNION ALL
    SELECT '15' AS dept, '15837' AS code, 'Tuta' AS name UNION ALL
    SELECT '15' AS dept, '15839' AS code, 'Tutazá' AS name UNION ALL
    SELECT '15' AS dept, '15842' AS code, 'Úmbita' AS name UNION ALL
    SELECT '15' AS dept, '15861' AS code, 'Ventaquemada' AS name UNION ALL
    SELECT '15' AS dept, '15879' AS code, 'Viracachá' AS name UNION ALL
    SELECT '15' AS dept, '15897' AS code, 'Zetaquira' AS name UNION ALL
    SELECT '17' AS dept, '17001' AS code, 'Manizales' AS name UNION ALL
    SELECT '17' AS dept, '17013' AS code, 'Aguadas' AS name UNION ALL
    SELECT '17' AS dept, '17042' AS code, 'Anserma' AS name UNION ALL
    SELECT '17' AS dept, '17050' AS code, 'Aranzazu' AS name UNION ALL
    SELECT '17' AS dept, '17088' AS code, 'Belalcázar' AS name UNION ALL
    SELECT '17' AS dept, '17174' AS code, 'Chinchiná' AS name UNION ALL
    SELECT '17' AS dept, '17272' AS code, 'Filadelfia' AS name UNION ALL
    SELECT '17' AS dept, '17380' AS code, 'La Dorada' AS name UNION ALL
    SELECT '17' AS dept, '17388' AS code, 'La Merced' AS name UNION ALL
    SELECT '17' AS dept, '17433' AS code, 'Manzanares' AS name UNION ALL
    SELECT '17' AS dept, '17442' AS code, 'Marmato' AS name UNION ALL
    SELECT '17' AS dept, '17444' AS code, 'Marquetalia' AS name UNION ALL
    SELECT '17' AS dept, '17446' AS code, 'Marulanda' AS name UNION ALL
    SELECT '17' AS dept, '17486' AS code, 'Neira' AS name UNION ALL
    SELECT '17' AS dept, '17495' AS code, 'Norcasia' AS name UNION ALL
    SELECT '17' AS dept, '17513' AS code, 'Pácora' AS name UNION ALL
    SELECT '17' AS dept, '17524' AS code, 'Palestina' AS name UNION ALL
    SELECT '17' AS dept, '17541' AS code, 'Pensilvania' AS name UNION ALL
    SELECT '17' AS dept, '17614' AS code, 'Riosucio' AS name UNION ALL
    SELECT '17' AS dept, '17616' AS code, 'Risaralda' AS name UNION ALL
    SELECT '17' AS dept, '17653' AS code, 'Salamina' AS name UNION ALL
    SELECT '17' AS dept, '17662' AS code, 'Samaná' AS name UNION ALL
    SELECT '17' AS dept, '17665' AS code, 'San José' AS name UNION ALL
    SELECT '17' AS dept, '17777' AS code, 'Supía' AS name UNION ALL
    SELECT '17' AS dept, '17867' AS code, 'Victoria' AS name UNION ALL
    SELECT '17' AS dept, '17873' AS code, 'Villamaría' AS name UNION ALL
    SELECT '17' AS dept, '17877' AS code, 'Viterbo' AS name UNION ALL
    SELECT '18' AS dept, '18001' AS code, 'Florencia' AS name UNION ALL
    SELECT '18' AS dept, '18029' AS code, 'Albania' AS name UNION ALL
    SELECT '18' AS dept, '18094' AS code, 'Belén de los Andaquíes' AS name UNION ALL
    SELECT '18' AS dept, '18150' AS code, 'Cartagena del Chairá' AS name UNION ALL
    SELECT '18' AS dept, '18205' AS code, 'Curillo' AS name UNION ALL
    SELECT '18' AS dept, '18247' AS code, 'El Doncello' AS name UNION ALL
    SELECT '18' AS dept, '18256' AS code, 'El Paujíl' AS name UNION ALL
    SELECT '18' AS dept, '18410' AS code, 'La Montañita' AS name UNION ALL
    SELECT '18' AS dept, '18460' AS code, 'Milán' AS name UNION ALL
    SELECT '18' AS dept, '18479' AS code, 'Morelia' AS name UNION ALL
    SELECT '18' AS dept, '18592' AS code, 'Puerto Rico' AS name UNION ALL
    SELECT '18' AS dept, '18610' AS code, 'San José del Fragua' AS name UNION ALL
    SELECT '18' AS dept, '18753' AS code, 'San Vicente del Caguán' AS name UNION ALL
    SELECT '18' AS dept, '18756' AS code, 'Solano' AS name UNION ALL
    SELECT '18' AS dept, '18785' AS code, 'Solita' AS name UNION ALL
    SELECT '18' AS dept, '18860' AS code, 'Valparaíso' AS name UNION ALL
    SELECT '19' AS dept, '19001' AS code, 'Popayán' AS name UNION ALL
    SELECT '19' AS dept, '19022' AS code, 'Almaguer' AS name UNION ALL
    SELECT '19' AS dept, '19050' AS code, 'Argelia' AS name UNION ALL
    SELECT '19' AS dept, '19075' AS code, 'Balboa' AS name UNION ALL
    SELECT '19' AS dept, '19100' AS code, 'Bolívar' AS name UNION ALL
    SELECT '19' AS dept, '19110' AS code, 'Buenos Aires' AS name UNION ALL
    SELECT '19' AS dept, '19130' AS code, 'Cajibío' AS name UNION ALL
    SELECT '19' AS dept, '19137' AS code, 'Caldono' AS name UNION ALL
    SELECT '19' AS dept, '19142' AS code, 'Caloto' AS name UNION ALL
    SELECT '19' AS dept, '19212' AS code, 'Corinto' AS name UNION ALL
    SELECT '19' AS dept, '19256' AS code, 'El Tambo' AS name UNION ALL
    SELECT '19' AS dept, '19290' AS code, 'Florencia' AS name UNION ALL
    SELECT '19' AS dept, '19300' AS code, 'Guachené' AS name UNION ALL
    SELECT '19' AS dept, '19318' AS code, 'Guapi' AS name UNION ALL
    SELECT '19' AS dept, '19355' AS code, 'Inzá' AS name UNION ALL
    SELECT '19' AS dept, '19364' AS code, 'Jambaló' AS name UNION ALL
    SELECT '19' AS dept, '19392' AS code, 'La Sierra' AS name UNION ALL
    SELECT '19' AS dept, '19397' AS code, 'La Vega' AS name UNION ALL
    SELECT '19' AS dept, '19418' AS code, 'López de Micay' AS name UNION ALL
    SELECT '19' AS dept, '19450' AS code, 'Mercaderes' AS name UNION ALL
    SELECT '19' AS dept, '19455' AS code, 'Miranda' AS name UNION ALL
    SELECT '19' AS dept, '19473' AS code, 'Morales' AS name UNION ALL
    SELECT '19' AS dept, '19513' AS code, 'Padilla' AS name UNION ALL
    SELECT '19' AS dept, '19517' AS code, 'Páez' AS name UNION ALL
    SELECT '19' AS dept, '19532' AS code, 'Patía' AS name UNION ALL
    SELECT '19' AS dept, '19533' AS code, 'Piamonte' AS name UNION ALL
    SELECT '19' AS dept, '19548' AS code, 'Piendamó - Tunía' AS name UNION ALL
    SELECT '19' AS dept, '19573' AS code, 'Puerto Tejada' AS name UNION ALL
    SELECT '19' AS dept, '19585' AS code, 'Puracé' AS name UNION ALL
    SELECT '19' AS dept, '19622' AS code, 'Rosas' AS name UNION ALL
    SELECT '19' AS dept, '19693' AS code, 'San Sebastián' AS name UNION ALL
    SELECT '19' AS dept, '19698' AS code, 'Santander de Quilichao' AS name UNION ALL
    SELECT '19' AS dept, '19701' AS code, 'Santa Rosa' AS name UNION ALL
    SELECT '19' AS dept, '19743' AS code, 'Silvia' AS name UNION ALL
    SELECT '19' AS dept, '19760' AS code, 'Sotará - Paispamba' AS name UNION ALL
    SELECT '19' AS dept, '19780' AS code, 'Suárez' AS name UNION ALL
    SELECT '19' AS dept, '19785' AS code, 'Sucre' AS name UNION ALL
    SELECT '19' AS dept, '19807' AS code, 'Timbío' AS name UNION ALL
    SELECT '19' AS dept, '19809' AS code, 'Timbiquí' AS name UNION ALL
    SELECT '19' AS dept, '19821' AS code, 'Toribío' AS name UNION ALL
    SELECT '19' AS dept, '19824' AS code, 'Totoró' AS name UNION ALL
    SELECT '19' AS dept, '19845' AS code, 'Villa Rica' AS name UNION ALL
    SELECT '20' AS dept, '20001' AS code, 'Valledupar' AS name UNION ALL
    SELECT '20' AS dept, '20011' AS code, 'Aguachica' AS name UNION ALL
    SELECT '20' AS dept, '20013' AS code, 'Agustín Codazzi' AS name UNION ALL
    SELECT '20' AS dept, '20032' AS code, 'Astrea' AS name UNION ALL
    SELECT '20' AS dept, '20045' AS code, 'Becerril' AS name UNION ALL
    SELECT '20' AS dept, '20060' AS code, 'Bosconia' AS name UNION ALL
    SELECT '20' AS dept, '20175' AS code, 'Chimichagua' AS name UNION ALL
    SELECT '20' AS dept, '20178' AS code, 'Chiriguaná' AS name UNION ALL
    SELECT '20' AS dept, '20228' AS code, 'Curumaní' AS name UNION ALL
    SELECT '20' AS dept, '20238' AS code, 'El Copey' AS name UNION ALL
    SELECT '20' AS dept, '20250' AS code, 'El Paso' AS name UNION ALL
    SELECT '20' AS dept, '20295' AS code, 'Gamarra' AS name UNION ALL
    SELECT '20' AS dept, '20310' AS code, 'González' AS name UNION ALL
    SELECT '20' AS dept, '20383' AS code, 'La Gloria' AS name UNION ALL
    SELECT '20' AS dept, '20400' AS code, 'La Jagua de Ibirico' AS name UNION ALL
    SELECT '20' AS dept, '20443' AS code, 'Manaure Balcón del Cesar' AS name UNION ALL
    SELECT '20' AS dept, '20517' AS code, 'Pailitas' AS name UNION ALL
    SELECT '20' AS dept, '20550' AS code, 'Pelaya' AS name UNION ALL
    SELECT '20' AS dept, '20570' AS code, 'Pueblo Bello' AS name UNION ALL
    SELECT '20' AS dept, '20614' AS code, 'Río de Oro' AS name UNION ALL
    SELECT '20' AS dept, '20621' AS code, 'La Paz' AS name UNION ALL
    SELECT '20' AS dept, '20710' AS code, 'San Alberto' AS name UNION ALL
    SELECT '20' AS dept, '20750' AS code, 'San Diego' AS name UNION ALL
    SELECT '20' AS dept, '20770' AS code, 'San Martín' AS name UNION ALL
    SELECT '20' AS dept, '20787' AS code, 'Tamalameque' AS name UNION ALL
    SELECT '23' AS dept, '23001' AS code, 'Montería' AS name UNION ALL
    SELECT '23' AS dept, '23068' AS code, 'Ayapel' AS name UNION ALL
    SELECT '23' AS dept, '23079' AS code, 'Buenavista' AS name UNION ALL
    SELECT '23' AS dept, '23090' AS code, 'Canalete' AS name UNION ALL
    SELECT '23' AS dept, '23162' AS code, 'Cereté' AS name UNION ALL
    SELECT '23' AS dept, '23168' AS code, 'Chimá' AS name UNION ALL
    SELECT '23' AS dept, '23182' AS code, 'Chinú' AS name UNION ALL
    SELECT '23' AS dept, '23189' AS code, 'Ciénaga de Oro' AS name UNION ALL
    SELECT '23' AS dept, '23300' AS code, 'Cotorra' AS name UNION ALL
    SELECT '23' AS dept, '23350' AS code, 'La Apartada' AS name UNION ALL
    SELECT '23' AS dept, '23417' AS code, 'Lorica' AS name UNION ALL
    SELECT '23' AS dept, '23419' AS code, 'Los Córdobas' AS name UNION ALL
    SELECT '23' AS dept, '23464' AS code, 'Momil' AS name UNION ALL
    SELECT '23' AS dept, '23466' AS code, 'Montelíbano' AS name UNION ALL
    SELECT '23' AS dept, '23500' AS code, 'Moñitos' AS name UNION ALL
    SELECT '23' AS dept, '23555' AS code, 'Planeta Rica' AS name UNION ALL
    SELECT '23' AS dept, '23570' AS code, 'Pueblo Nuevo' AS name UNION ALL
    SELECT '23' AS dept, '23574' AS code, 'Puerto Escondido' AS name UNION ALL
    SELECT '23' AS dept, '23580' AS code, 'Puerto Libertador' AS name UNION ALL
    SELECT '23' AS dept, '23586' AS code, 'Purísima de la Concepción' AS name UNION ALL
    SELECT '23' AS dept, '23660' AS code, 'Sahagún' AS name UNION ALL
    SELECT '23' AS dept, '23670' AS code, 'San Andrés de Sotavento' AS name UNION ALL
    SELECT '23' AS dept, '23672' AS code, 'San Antero' AS name UNION ALL
    SELECT '23' AS dept, '23675' AS code, 'San Bernardo del Viento' AS name UNION ALL
    SELECT '23' AS dept, '23678' AS code, 'San Carlos' AS name UNION ALL
    SELECT '23' AS dept, '23682' AS code, 'San José de Uré' AS name UNION ALL
    SELECT '23' AS dept, '23686' AS code, 'San Pelayo' AS name UNION ALL
    SELECT '23' AS dept, '23807' AS code, 'Tierralta' AS name UNION ALL
    SELECT '23' AS dept, '23815' AS code, 'Tuchín' AS name UNION ALL
    SELECT '23' AS dept, '23855' AS code, 'Valencia' AS name UNION ALL
    SELECT '25' AS dept, '25001' AS code, 'Agua de Dios' AS name UNION ALL
    SELECT '25' AS dept, '25019' AS code, 'Albán' AS name UNION ALL
    SELECT '25' AS dept, '25035' AS code, 'Anapoima' AS name UNION ALL
    SELECT '25' AS dept, '25040' AS code, 'Anolaima' AS name UNION ALL
    SELECT '25' AS dept, '25053' AS code, 'Arbeláez' AS name UNION ALL
    SELECT '25' AS dept, '25086' AS code, 'Beltrán' AS name UNION ALL
    SELECT '25' AS dept, '25095' AS code, 'Bituima' AS name UNION ALL
    SELECT '25' AS dept, '25099' AS code, 'Bojacá' AS name UNION ALL
    SELECT '25' AS dept, '25120' AS code, 'Cabrera' AS name UNION ALL
    SELECT '25' AS dept, '25123' AS code, 'Cachipay' AS name UNION ALL
    SELECT '25' AS dept, '25126' AS code, 'Cajicá' AS name UNION ALL
    SELECT '25' AS dept, '25148' AS code, 'Caparrapí' AS name UNION ALL
    SELECT '25' AS dept, '25151' AS code, 'Cáqueza' AS name UNION ALL
    SELECT '25' AS dept, '25154' AS code, 'Carmen de Carupa' AS name UNION ALL
    SELECT '25' AS dept, '25168' AS code, 'Chaguaní' AS name UNION ALL
    SELECT '25' AS dept, '25175' AS code, 'Chía' AS name UNION ALL
    SELECT '25' AS dept, '25178' AS code, 'Chipaque' AS name UNION ALL
    SELECT '25' AS dept, '25181' AS code, 'Choachí' AS name UNION ALL
    SELECT '25' AS dept, '25183' AS code, 'Chocontá' AS name UNION ALL
    SELECT '25' AS dept, '25200' AS code, 'Cogua' AS name UNION ALL
    SELECT '25' AS dept, '25214' AS code, 'Cota' AS name UNION ALL
    SELECT '25' AS dept, '25224' AS code, 'Cucunubá' AS name UNION ALL
    SELECT '25' AS dept, '25245' AS code, 'El Colegio' AS name UNION ALL
    SELECT '25' AS dept, '25258' AS code, 'El Peñón' AS name UNION ALL
    SELECT '25' AS dept, '25260' AS code, 'El Rosal' AS name UNION ALL
    SELECT '25' AS dept, '25269' AS code, 'Facatativá' AS name UNION ALL
    SELECT '25' AS dept, '25279' AS code, 'Fómeque' AS name UNION ALL
    SELECT '25' AS dept, '25281' AS code, 'Fosca' AS name UNION ALL
    SELECT '25' AS dept, '25286' AS code, 'Funza' AS name UNION ALL
    SELECT '25' AS dept, '25288' AS code, 'Fúquene' AS name UNION ALL
    SELECT '25' AS dept, '25290' AS code, 'Fusagasugá' AS name UNION ALL
    SELECT '25' AS dept, '25293' AS code, 'Gachalá' AS name UNION ALL
    SELECT '25' AS dept, '25295' AS code, 'Gachancipá' AS name UNION ALL
    SELECT '25' AS dept, '25297' AS code, 'Gachetá' AS name UNION ALL
    SELECT '25' AS dept, '25299' AS code, 'Gama' AS name UNION ALL
    SELECT '25' AS dept, '25307' AS code, 'Girardot' AS name UNION ALL
    SELECT '25' AS dept, '25312' AS code, 'Granada' AS name UNION ALL
    SELECT '25' AS dept, '25317' AS code, 'Guachetá' AS name UNION ALL
    SELECT '25' AS dept, '25320' AS code, 'Guaduas' AS name UNION ALL
    SELECT '25' AS dept, '25322' AS code, 'Guasca' AS name UNION ALL
    SELECT '25' AS dept, '25324' AS code, 'Guataquí' AS name UNION ALL
    SELECT '25' AS dept, '25326' AS code, 'Guatavita' AS name UNION ALL
    SELECT '25' AS dept, '25328' AS code, 'Guayabal de Síquima' AS name UNION ALL
    SELECT '25' AS dept, '25335' AS code, 'Guayabetal' AS name UNION ALL
    SELECT '25' AS dept, '25339' AS code, 'Gutiérrez' AS name UNION ALL
    SELECT '25' AS dept, '25368' AS code, 'Jerusalén' AS name UNION ALL
    SELECT '25' AS dept, '25372' AS code, 'Junín' AS name UNION ALL
    SELECT '25' AS dept, '25377' AS code, 'La Calera' AS name UNION ALL
    SELECT '25' AS dept, '25386' AS code, 'La Mesa' AS name UNION ALL
    SELECT '25' AS dept, '25394' AS code, 'La Palma' AS name UNION ALL
    SELECT '25' AS dept, '25398' AS code, 'La Peña' AS name UNION ALL
    SELECT '25' AS dept, '25402' AS code, 'La Vega' AS name UNION ALL
    SELECT '25' AS dept, '25407' AS code, 'Lenguazaque' AS name UNION ALL
    SELECT '25' AS dept, '25426' AS code, 'Machetá' AS name UNION ALL
    SELECT '25' AS dept, '25430' AS code, 'Madrid' AS name UNION ALL
    SELECT '25' AS dept, '25436' AS code, 'Manta' AS name UNION ALL
    SELECT '25' AS dept, '25438' AS code, 'Medina' AS name UNION ALL
    SELECT '25' AS dept, '25473' AS code, 'Mosquera' AS name UNION ALL
    SELECT '25' AS dept, '25483' AS code, 'Nariño' AS name UNION ALL
    SELECT '25' AS dept, '25486' AS code, 'Nemocón' AS name UNION ALL
    SELECT '25' AS dept, '25488' AS code, 'Nilo' AS name UNION ALL
    SELECT '25' AS dept, '25489' AS code, 'Nimaima' AS name UNION ALL
    SELECT '25' AS dept, '25491' AS code, 'Nocaima' AS name UNION ALL
    SELECT '25' AS dept, '25506' AS code, 'Venecia' AS name UNION ALL
    SELECT '25' AS dept, '25513' AS code, 'Pacho' AS name UNION ALL
    SELECT '25' AS dept, '25518' AS code, 'Paime' AS name UNION ALL
    SELECT '25' AS dept, '25524' AS code, 'Pandi' AS name UNION ALL
    SELECT '25' AS dept, '25530' AS code, 'Paratebueno' AS name UNION ALL
    SELECT '25' AS dept, '25535' AS code, 'Pasca' AS name UNION ALL
    SELECT '25' AS dept, '25572' AS code, 'Puerto Salgar' AS name UNION ALL
    SELECT '25' AS dept, '25580' AS code, 'Pulí' AS name UNION ALL
    SELECT '25' AS dept, '25592' AS code, 'Quebradanegra' AS name UNION ALL
    SELECT '25' AS dept, '25594' AS code, 'Quetame' AS name UNION ALL
    SELECT '25' AS dept, '25596' AS code, 'Quipile' AS name UNION ALL
    SELECT '25' AS dept, '25599' AS code, 'Apulo' AS name UNION ALL
    SELECT '25' AS dept, '25612' AS code, 'Ricaurte' AS name UNION ALL
    SELECT '25' AS dept, '25645' AS code, 'San Antonio del Tequendama' AS name UNION ALL
    SELECT '25' AS dept, '25649' AS code, 'San Bernardo' AS name UNION ALL
    SELECT '25' AS dept, '25653' AS code, 'San Cayetano' AS name UNION ALL
    SELECT '25' AS dept, '25658' AS code, 'San Francisco' AS name UNION ALL
    SELECT '25' AS dept, '25662' AS code, 'San Juan de Rioseco' AS name UNION ALL
    SELECT '25' AS dept, '25718' AS code, 'Sasaima' AS name UNION ALL
    SELECT '25' AS dept, '25736' AS code, 'Sesquilé' AS name UNION ALL
    SELECT '25' AS dept, '25740' AS code, 'Sibaté' AS name UNION ALL
    SELECT '25' AS dept, '25743' AS code, 'Silvania' AS name UNION ALL
    SELECT '25' AS dept, '25745' AS code, 'Simijaca' AS name UNION ALL
    SELECT '25' AS dept, '25754' AS code, 'Soacha' AS name UNION ALL
    SELECT '25' AS dept, '25758' AS code, 'Sopó' AS name UNION ALL
    SELECT '25' AS dept, '25769' AS code, 'Subachoque' AS name UNION ALL
    SELECT '25' AS dept, '25772' AS code, 'Suesca' AS name UNION ALL
    SELECT '25' AS dept, '25777' AS code, 'Supatá' AS name UNION ALL
    SELECT '25' AS dept, '25779' AS code, 'Susa' AS name UNION ALL
    SELECT '25' AS dept, '25781' AS code, 'Sutatausa' AS name UNION ALL
    SELECT '25' AS dept, '25785' AS code, 'Tabio' AS name UNION ALL
    SELECT '25' AS dept, '25793' AS code, 'Tausa' AS name UNION ALL
    SELECT '25' AS dept, '25797' AS code, 'Tena' AS name UNION ALL
    SELECT '25' AS dept, '25799' AS code, 'Tenjo' AS name UNION ALL
    SELECT '25' AS dept, '25805' AS code, 'Tibacuy' AS name UNION ALL
    SELECT '25' AS dept, '25807' AS code, 'Tibirita' AS name UNION ALL
    SELECT '25' AS dept, '25815' AS code, 'Tocaima' AS name UNION ALL
    SELECT '25' AS dept, '25817' AS code, 'Tocancipá' AS name UNION ALL
    SELECT '25' AS dept, '25823' AS code, 'Topaipí' AS name UNION ALL
    SELECT '25' AS dept, '25839' AS code, 'Ubalá' AS name UNION ALL
    SELECT '25' AS dept, '25841' AS code, 'Ubaque' AS name UNION ALL
    SELECT '25' AS dept, '25843' AS code, 'Villa de San Diego de Ubaté' AS name UNION ALL
    SELECT '25' AS dept, '25845' AS code, 'Une' AS name UNION ALL
    SELECT '25' AS dept, '25851' AS code, 'Útica' AS name UNION ALL
    SELECT '25' AS dept, '25862' AS code, 'Vergara' AS name UNION ALL
    SELECT '25' AS dept, '25867' AS code, 'Vianí' AS name UNION ALL
    SELECT '25' AS dept, '25871' AS code, 'Villagómez' AS name UNION ALL
    SELECT '25' AS dept, '25873' AS code, 'Villapinzón' AS name UNION ALL
    SELECT '25' AS dept, '25875' AS code, 'Villeta' AS name UNION ALL
    SELECT '25' AS dept, '25878' AS code, 'Viotá' AS name UNION ALL
    SELECT '25' AS dept, '25885' AS code, 'Yacopí' AS name UNION ALL
    SELECT '25' AS dept, '25898' AS code, 'Zipacón' AS name UNION ALL
    SELECT '25' AS dept, '25899' AS code, 'Zipaquirá' AS name UNION ALL
    SELECT '27' AS dept, '27001' AS code, 'Quibdó' AS name UNION ALL
    SELECT '27' AS dept, '27006' AS code, 'Acandí' AS name UNION ALL
    SELECT '27' AS dept, '27025' AS code, 'Alto Baudó' AS name UNION ALL
    SELECT '27' AS dept, '27050' AS code, 'Atrato' AS name UNION ALL
    SELECT '27' AS dept, '27073' AS code, 'Bagadó' AS name UNION ALL
    SELECT '27' AS dept, '27075' AS code, 'Bahía Solano' AS name UNION ALL
    SELECT '27' AS dept, '27077' AS code, 'Bajo Baudó' AS name UNION ALL
    SELECT '27' AS dept, '27099' AS code, 'Bojayá' AS name UNION ALL
    SELECT '27' AS dept, '27135' AS code, 'El Cantón del San Pablo' AS name UNION ALL
    SELECT '27' AS dept, '27150' AS code, 'Carmen del Darién' AS name UNION ALL
    SELECT '27' AS dept, '27160' AS code, 'Cértegui' AS name UNION ALL
    SELECT '27' AS dept, '27205' AS code, 'Condoto' AS name UNION ALL
    SELECT '27' AS dept, '27245' AS code, 'El Carmen de Atrato' AS name UNION ALL
    SELECT '27' AS dept, '27250' AS code, 'El Litoral del San Juan' AS name UNION ALL
    SELECT '27' AS dept, '27361' AS code, 'Istmina' AS name UNION ALL
    SELECT '27' AS dept, '27372' AS code, 'Juradó' AS name UNION ALL
    SELECT '27' AS dept, '27413' AS code, 'Lloró' AS name UNION ALL
    SELECT '27' AS dept, '27425' AS code, 'Medio Atrato' AS name UNION ALL
    SELECT '27' AS dept, '27430' AS code, 'Medio Baudó' AS name UNION ALL
    SELECT '27' AS dept, '27450' AS code, 'Medio San Juan' AS name UNION ALL
    SELECT '27' AS dept, '27491' AS code, 'Nóvita' AS name UNION ALL
    SELECT '27' AS dept, '27493' AS code, 'Nuevo Belén de Bajirá' AS name UNION ALL
    SELECT '27' AS dept, '27495' AS code, 'Nuquí' AS name UNION ALL
    SELECT '27' AS dept, '27580' AS code, 'Río Iró' AS name UNION ALL
    SELECT '27' AS dept, '27600' AS code, 'Río Quito' AS name UNION ALL
    SELECT '27' AS dept, '27615' AS code, 'Riosucio' AS name UNION ALL
    SELECT '27' AS dept, '27660' AS code, 'San José del Palmar' AS name UNION ALL
    SELECT '27' AS dept, '27745' AS code, 'Sipí' AS name UNION ALL
    SELECT '27' AS dept, '27787' AS code, 'Tadó' AS name UNION ALL
    SELECT '27' AS dept, '27800' AS code, 'Unguía' AS name UNION ALL
    SELECT '27' AS dept, '27810' AS code, 'Unión Panamericana' AS name UNION ALL
    SELECT '41' AS dept, '41001' AS code, 'Neiva' AS name UNION ALL
    SELECT '41' AS dept, '41006' AS code, 'Acevedo' AS name UNION ALL
    SELECT '41' AS dept, '41013' AS code, 'Agrado' AS name UNION ALL
    SELECT '41' AS dept, '41016' AS code, 'Aipe' AS name UNION ALL
    SELECT '41' AS dept, '41020' AS code, 'Algeciras' AS name UNION ALL
    SELECT '41' AS dept, '41026' AS code, 'Altamira' AS name UNION ALL
    SELECT '41' AS dept, '41078' AS code, 'Baraya' AS name UNION ALL
    SELECT '41' AS dept, '41132' AS code, 'Campoalegre' AS name UNION ALL
    SELECT '41' AS dept, '41206' AS code, 'Colombia' AS name UNION ALL
    SELECT '41' AS dept, '41244' AS code, 'Elías' AS name UNION ALL
    SELECT '41' AS dept, '41298' AS code, 'Garzón' AS name UNION ALL
    SELECT '41' AS dept, '41306' AS code, 'Gigante' AS name UNION ALL
    SELECT '41' AS dept, '41319' AS code, 'Guadalupe' AS name UNION ALL
    SELECT '41' AS dept, '41349' AS code, 'Hobo' AS name UNION ALL
    SELECT '41' AS dept, '41357' AS code, 'Íquira' AS name UNION ALL
    SELECT '41' AS dept, '41359' AS code, 'Isnos' AS name UNION ALL
    SELECT '41' AS dept, '41378' AS code, 'La Argentina' AS name UNION ALL
    SELECT '41' AS dept, '41396' AS code, 'La Plata' AS name UNION ALL
    SELECT '41' AS dept, '41483' AS code, 'Nátaga' AS name UNION ALL
    SELECT '41' AS dept, '41503' AS code, 'Oporapa' AS name UNION ALL
    SELECT '41' AS dept, '41518' AS code, 'Paicol' AS name UNION ALL
    SELECT '41' AS dept, '41524' AS code, 'Palermo' AS name UNION ALL
    SELECT '41' AS dept, '41530' AS code, 'Palestina' AS name UNION ALL
    SELECT '41' AS dept, '41548' AS code, 'Pital' AS name UNION ALL
    SELECT '41' AS dept, '41551' AS code, 'Pitalito' AS name UNION ALL
    SELECT '41' AS dept, '41615' AS code, 'Rivera' AS name UNION ALL
    SELECT '41' AS dept, '41660' AS code, 'Saladoblanco' AS name UNION ALL
    SELECT '41' AS dept, '41668' AS code, 'San Agustín' AS name UNION ALL
    SELECT '41' AS dept, '41676' AS code, 'Santa María' AS name UNION ALL
    SELECT '41' AS dept, '41770' AS code, 'Suaza' AS name UNION ALL
    SELECT '41' AS dept, '41791' AS code, 'Tarqui' AS name UNION ALL
    SELECT '41' AS dept, '41797' AS code, 'Tesalia' AS name UNION ALL
    SELECT '41' AS dept, '41799' AS code, 'Tello' AS name UNION ALL
    SELECT '41' AS dept, '41801' AS code, 'Teruel' AS name UNION ALL
    SELECT '41' AS dept, '41807' AS code, 'Timaná' AS name UNION ALL
    SELECT '41' AS dept, '41872' AS code, 'Villavieja' AS name UNION ALL
    SELECT '41' AS dept, '41885' AS code, 'Yaguará' AS name UNION ALL
    SELECT '44' AS dept, '44001' AS code, 'Riohacha' AS name UNION ALL
    SELECT '44' AS dept, '44035' AS code, 'Albania' AS name UNION ALL
    SELECT '44' AS dept, '44078' AS code, 'Barrancas' AS name UNION ALL
    SELECT '44' AS dept, '44090' AS code, 'Dibulla' AS name UNION ALL
    SELECT '44' AS dept, '44098' AS code, 'Distracción' AS name UNION ALL
    SELECT '44' AS dept, '44110' AS code, 'El Molino' AS name UNION ALL
    SELECT '44' AS dept, '44279' AS code, 'Fonseca' AS name UNION ALL
    SELECT '44' AS dept, '44378' AS code, 'Hatonuevo' AS name UNION ALL
    SELECT '44' AS dept, '44420' AS code, 'La Jagua del Pilar' AS name UNION ALL
    SELECT '44' AS dept, '44430' AS code, 'Maicao' AS name UNION ALL
    SELECT '44' AS dept, '44560' AS code, 'Manaure' AS name UNION ALL
    SELECT '44' AS dept, '44650' AS code, 'San Juan del Cesar' AS name UNION ALL
    SELECT '44' AS dept, '44847' AS code, 'Uribia' AS name UNION ALL
    SELECT '44' AS dept, '44855' AS code, 'Urumita' AS name UNION ALL
    SELECT '44' AS dept, '44874' AS code, 'Villanueva' AS name UNION ALL
    SELECT '47' AS dept, '47001' AS code, 'Santa Marta' AS name UNION ALL
    SELECT '47' AS dept, '47030' AS code, 'Algarrobo' AS name UNION ALL
    SELECT '47' AS dept, '47053' AS code, 'Aracataca' AS name UNION ALL
    SELECT '47' AS dept, '47058' AS code, 'Ariguaní' AS name UNION ALL
    SELECT '47' AS dept, '47161' AS code, 'Cerro de San Antonio' AS name UNION ALL
    SELECT '47' AS dept, '47170' AS code, 'Chivolo' AS name UNION ALL
    SELECT '47' AS dept, '47189' AS code, 'Ciénaga' AS name UNION ALL
    SELECT '47' AS dept, '47205' AS code, 'Concordia' AS name UNION ALL
    SELECT '47' AS dept, '47245' AS code, 'El Banco' AS name UNION ALL
    SELECT '47' AS dept, '47258' AS code, 'El Piñón' AS name UNION ALL
    SELECT '47' AS dept, '47268' AS code, 'El Retén' AS name UNION ALL
    SELECT '47' AS dept, '47288' AS code, 'Fundación' AS name UNION ALL
    SELECT '47' AS dept, '47318' AS code, 'Guamal' AS name UNION ALL
    SELECT '47' AS dept, '47460' AS code, 'Nueva Granada' AS name UNION ALL
    SELECT '47' AS dept, '47541' AS code, 'Pedraza' AS name UNION ALL
    SELECT '47' AS dept, '47545' AS code, 'Pijiño del Carmen' AS name UNION ALL
    SELECT '47' AS dept, '47551' AS code, 'Pivijay' AS name UNION ALL
    SELECT '47' AS dept, '47555' AS code, 'Plato' AS name UNION ALL
    SELECT '47' AS dept, '47570' AS code, 'Puebloviejo' AS name UNION ALL
    SELECT '47' AS dept, '47605' AS code, 'Remolino' AS name UNION ALL
    SELECT '47' AS dept, '47660' AS code, 'Sabanas de San Ángel' AS name UNION ALL
    SELECT '47' AS dept, '47675' AS code, 'Salamina' AS name UNION ALL
    SELECT '47' AS dept, '47692' AS code, 'San Sebastián de Buenavista' AS name UNION ALL
    SELECT '47' AS dept, '47703' AS code, 'San Zenón' AS name UNION ALL
    SELECT '47' AS dept, '47707' AS code, 'Santa Ana' AS name UNION ALL
    SELECT '47' AS dept, '47720' AS code, 'Santa Bárbara de Pinto' AS name UNION ALL
    SELECT '47' AS dept, '47745' AS code, 'Sitionuevo' AS name UNION ALL
    SELECT '47' AS dept, '47798' AS code, 'Tenerife' AS name UNION ALL
    SELECT '47' AS dept, '47960' AS code, 'Zapayán' AS name UNION ALL
    SELECT '47' AS dept, '47980' AS code, 'Zona Bananera' AS name UNION ALL
    SELECT '50' AS dept, '50001' AS code, 'Villavicencio' AS name UNION ALL
    SELECT '50' AS dept, '50006' AS code, 'Acacías' AS name UNION ALL
    SELECT '50' AS dept, '50110' AS code, 'Barranca de Upía' AS name UNION ALL
    SELECT '50' AS dept, '50124' AS code, 'Cabuyaro' AS name UNION ALL
    SELECT '50' AS dept, '50150' AS code, 'Castilla la Nueva' AS name UNION ALL
    SELECT '50' AS dept, '50223' AS code, 'Cubarral' AS name UNION ALL
    SELECT '50' AS dept, '50226' AS code, 'Cumaral' AS name UNION ALL
    SELECT '50' AS dept, '50245' AS code, 'El Calvario' AS name UNION ALL
    SELECT '50' AS dept, '50251' AS code, 'El Castillo' AS name UNION ALL
    SELECT '50' AS dept, '50270' AS code, 'El Dorado' AS name UNION ALL
    SELECT '50' AS dept, '50287' AS code, 'Fuente de Oro' AS name UNION ALL
    SELECT '50' AS dept, '50313' AS code, 'Granada' AS name UNION ALL
    SELECT '50' AS dept, '50318' AS code, 'Guamal' AS name UNION ALL
    SELECT '50' AS dept, '50325' AS code, 'Mapiripán' AS name UNION ALL
    SELECT '50' AS dept, '50330' AS code, 'Mesetas' AS name UNION ALL
    SELECT '50' AS dept, '50350' AS code, 'La Macarena' AS name UNION ALL
    SELECT '50' AS dept, '50370' AS code, 'Uribe' AS name UNION ALL
    SELECT '50' AS dept, '50400' AS code, 'Lejanías' AS name UNION ALL
    SELECT '50' AS dept, '50450' AS code, 'Puerto Concordia' AS name UNION ALL
    SELECT '50' AS dept, '50568' AS code, 'Puerto Gaitán' AS name UNION ALL
    SELECT '50' AS dept, '50573' AS code, 'Puerto López' AS name UNION ALL
    SELECT '50' AS dept, '50577' AS code, 'Puerto Lleras' AS name UNION ALL
    SELECT '50' AS dept, '50590' AS code, 'Puerto Rico' AS name UNION ALL
    SELECT '50' AS dept, '50606' AS code, 'Restrepo' AS name UNION ALL
    SELECT '50' AS dept, '50680' AS code, 'San Carlos de Guaroa' AS name UNION ALL
    SELECT '50' AS dept, '50683' AS code, 'San Juan de Arama' AS name UNION ALL
    SELECT '50' AS dept, '50686' AS code, 'San Juanito' AS name UNION ALL
    SELECT '50' AS dept, '50689' AS code, 'San Martín' AS name UNION ALL
    SELECT '50' AS dept, '50711' AS code, 'Vistahermosa' AS name UNION ALL
    SELECT '52' AS dept, '52001' AS code, 'Pasto' AS name UNION ALL
    SELECT '52' AS dept, '52019' AS code, 'Albán' AS name UNION ALL
    SELECT '52' AS dept, '52022' AS code, 'Aldana' AS name UNION ALL
    SELECT '52' AS dept, '52036' AS code, 'Ancuya' AS name UNION ALL
    SELECT '52' AS dept, '52051' AS code, 'Arboleda' AS name UNION ALL
    SELECT '52' AS dept, '52079' AS code, 'Barbacoas' AS name UNION ALL
    SELECT '52' AS dept, '52083' AS code, 'Belén' AS name UNION ALL
    SELECT '52' AS dept, '52110' AS code, 'Buesaco' AS name UNION ALL
    SELECT '52' AS dept, '52203' AS code, 'Colón' AS name UNION ALL
    SELECT '52' AS dept, '52207' AS code, 'Consacá' AS name UNION ALL
    SELECT '52' AS dept, '52210' AS code, 'Contadero' AS name UNION ALL
    SELECT '52' AS dept, '52215' AS code, 'Córdoba' AS name UNION ALL
    SELECT '52' AS dept, '52224' AS code, 'Cuaspud Carlosama' AS name UNION ALL
    SELECT '52' AS dept, '52227' AS code, 'Cumbal' AS name UNION ALL
    SELECT '52' AS dept, '52233' AS code, 'Cumbitara' AS name UNION ALL
    SELECT '52' AS dept, '52240' AS code, 'Chachagüí' AS name UNION ALL
    SELECT '52' AS dept, '52250' AS code, 'El Charco' AS name UNION ALL
    SELECT '52' AS dept, '52254' AS code, 'El Peñol' AS name UNION ALL
    SELECT '52' AS dept, '52256' AS code, 'El Rosario' AS name UNION ALL
    SELECT '52' AS dept, '52258' AS code, 'El Tablón de Gómez' AS name UNION ALL
    SELECT '52' AS dept, '52260' AS code, 'El Tambo' AS name UNION ALL
    SELECT '52' AS dept, '52287' AS code, 'Funes' AS name UNION ALL
    SELECT '52' AS dept, '52317' AS code, 'Guachucal' AS name UNION ALL
    SELECT '52' AS dept, '52320' AS code, 'Guaitarilla' AS name UNION ALL
    SELECT '52' AS dept, '52323' AS code, 'Gualmatán' AS name UNION ALL
    SELECT '52' AS dept, '52352' AS code, 'Iles' AS name UNION ALL
    SELECT '52' AS dept, '52354' AS code, 'Imués' AS name UNION ALL
    SELECT '52' AS dept, '52356' AS code, 'Ipiales' AS name UNION ALL
    SELECT '52' AS dept, '52378' AS code, 'La Cruz' AS name UNION ALL
    SELECT '52' AS dept, '52381' AS code, 'La Florida' AS name UNION ALL
    SELECT '52' AS dept, '52385' AS code, 'La Llanada' AS name UNION ALL
    SELECT '52' AS dept, '52390' AS code, 'La Tola' AS name UNION ALL
    SELECT '52' AS dept, '52399' AS code, 'La Unión' AS name UNION ALL
    SELECT '52' AS dept, '52405' AS code, 'Leiva' AS name UNION ALL
    SELECT '52' AS dept, '52411' AS code, 'Linares' AS name UNION ALL
    SELECT '52' AS dept, '52418' AS code, 'Los Andes' AS name UNION ALL
    SELECT '52' AS dept, '52427' AS code, 'Magüí' AS name UNION ALL
    SELECT '52' AS dept, '52435' AS code, 'Mallama' AS name UNION ALL
    SELECT '52' AS dept, '52473' AS code, 'Mosquera' AS name UNION ALL
    SELECT '52' AS dept, '52480' AS code, 'Nariño' AS name UNION ALL
    SELECT '52' AS dept, '52490' AS code, 'Olaya Herrera' AS name UNION ALL
    SELECT '52' AS dept, '52506' AS code, 'Ospina' AS name UNION ALL
    SELECT '52' AS dept, '52520' AS code, 'Francisco Pizarro' AS name UNION ALL
    SELECT '52' AS dept, '52540' AS code, 'Policarpa' AS name UNION ALL
    SELECT '52' AS dept, '52560' AS code, 'Potosí' AS name UNION ALL
    SELECT '52' AS dept, '52565' AS code, 'Providencia' AS name UNION ALL
    SELECT '52' AS dept, '52573' AS code, 'Puerres' AS name UNION ALL
    SELECT '52' AS dept, '52585' AS code, 'Pupiales' AS name UNION ALL
    SELECT '52' AS dept, '52612' AS code, 'Ricaurte' AS name UNION ALL
    SELECT '52' AS dept, '52621' AS code, 'Roberto Payán' AS name UNION ALL
    SELECT '52' AS dept, '52678' AS code, 'Samaniego' AS name UNION ALL
    SELECT '52' AS dept, '52683' AS code, 'Sandoná' AS name UNION ALL
    SELECT '52' AS dept, '52685' AS code, 'San Bernardo' AS name UNION ALL
    SELECT '52' AS dept, '52687' AS code, 'San Lorenzo' AS name UNION ALL
    SELECT '52' AS dept, '52693' AS code, 'San Pablo' AS name UNION ALL
    SELECT '52' AS dept, '52694' AS code, 'San Pedro de Cartago' AS name UNION ALL
    SELECT '52' AS dept, '52696' AS code, 'Santa Bárbara' AS name UNION ALL
    SELECT '52' AS dept, '52699' AS code, 'Santacruz' AS name UNION ALL
    SELECT '52' AS dept, '52720' AS code, 'Sapuyes' AS name UNION ALL
    SELECT '52' AS dept, '52786' AS code, 'Taminango' AS name UNION ALL
    SELECT '52' AS dept, '52788' AS code, 'Tangua' AS name UNION ALL
    SELECT '52' AS dept, '52835' AS code, 'San Andrés de Tumaco' AS name UNION ALL
    SELECT '52' AS dept, '52838' AS code, 'Túquerres' AS name UNION ALL
    SELECT '52' AS dept, '52885' AS code, 'Yacuanquer' AS name UNION ALL
    SELECT '54' AS dept, '54001' AS code, 'San José de Cúcuta' AS name UNION ALL
    SELECT '54' AS dept, '54003' AS code, 'Ábrego' AS name UNION ALL
    SELECT '54' AS dept, '54051' AS code, 'Arboledas' AS name UNION ALL
    SELECT '54' AS dept, '54099' AS code, 'Bochalema' AS name UNION ALL
    SELECT '54' AS dept, '54109' AS code, 'Bucarasica' AS name UNION ALL
    SELECT '54' AS dept, '54125' AS code, 'Cácota' AS name UNION ALL
    SELECT '54' AS dept, '54128' AS code, 'Cáchira' AS name UNION ALL
    SELECT '54' AS dept, '54172' AS code, 'Chinácota' AS name UNION ALL
    SELECT '54' AS dept, '54174' AS code, 'Chitagá' AS name UNION ALL
    SELECT '54' AS dept, '54206' AS code, 'Convención' AS name UNION ALL
    SELECT '54' AS dept, '54223' AS code, 'Cucutilla' AS name UNION ALL
    SELECT '54' AS dept, '54239' AS code, 'Durania' AS name UNION ALL
    SELECT '54' AS dept, '54245' AS code, 'El Carmen' AS name UNION ALL
    SELECT '54' AS dept, '54250' AS code, 'El Tarra' AS name UNION ALL
    SELECT '54' AS dept, '54261' AS code, 'El Zulia' AS name UNION ALL
    SELECT '54' AS dept, '54313' AS code, 'Gramalote' AS name UNION ALL
    SELECT '54' AS dept, '54344' AS code, 'Hacarí' AS name UNION ALL
    SELECT '54' AS dept, '54347' AS code, 'Herrán' AS name UNION ALL
    SELECT '54' AS dept, '54377' AS code, 'Labateca' AS name UNION ALL
    SELECT '54' AS dept, '54385' AS code, 'La Esperanza' AS name UNION ALL
    SELECT '54' AS dept, '54398' AS code, 'La Playa' AS name UNION ALL
    SELECT '54' AS dept, '54405' AS code, 'Los Patios' AS name UNION ALL
    SELECT '54' AS dept, '54418' AS code, 'Lourdes' AS name UNION ALL
    SELECT '54' AS dept, '54480' AS code, 'Mutiscua' AS name UNION ALL
    SELECT '54' AS dept, '54498' AS code, 'Ocaña' AS name UNION ALL
    SELECT '54' AS dept, '54518' AS code, 'Pamplona' AS name UNION ALL
    SELECT '54' AS dept, '54520' AS code, 'Pamplonita' AS name UNION ALL
    SELECT '54' AS dept, '54553' AS code, 'Puerto Santander' AS name UNION ALL
    SELECT '54' AS dept, '54599' AS code, 'Ragonvalia' AS name UNION ALL
    SELECT '54' AS dept, '54660' AS code, 'Salazar' AS name UNION ALL
    SELECT '54' AS dept, '54670' AS code, 'San Calixto' AS name UNION ALL
    SELECT '54' AS dept, '54673' AS code, 'San Cayetano' AS name UNION ALL
    SELECT '54' AS dept, '54680' AS code, 'Santiago' AS name UNION ALL
    SELECT '54' AS dept, '54720' AS code, 'Sardinata' AS name UNION ALL
    SELECT '54' AS dept, '54743' AS code, 'Silos' AS name UNION ALL
    SELECT '54' AS dept, '54800' AS code, 'Teorama' AS name UNION ALL
    SELECT '54' AS dept, '54810' AS code, 'Tibú' AS name UNION ALL
    SELECT '54' AS dept, '54820' AS code, 'Toledo' AS name UNION ALL
    SELECT '54' AS dept, '54871' AS code, 'Villa Caro' AS name UNION ALL
    SELECT '54' AS dept, '54874' AS code, 'Villa del Rosario' AS name UNION ALL
    SELECT '63' AS dept, '63001' AS code, 'Armenia' AS name UNION ALL
    SELECT '63' AS dept, '63111' AS code, 'Buenavista' AS name UNION ALL
    SELECT '63' AS dept, '63130' AS code, 'Calarcá' AS name UNION ALL
    SELECT '63' AS dept, '63190' AS code, 'Circasia' AS name UNION ALL
    SELECT '63' AS dept, '63212' AS code, 'Córdoba' AS name UNION ALL
    SELECT '63' AS dept, '63272' AS code, 'Filandia' AS name UNION ALL
    SELECT '63' AS dept, '63302' AS code, 'Génova' AS name UNION ALL
    SELECT '63' AS dept, '63401' AS code, 'La Tebaida' AS name UNION ALL
    SELECT '63' AS dept, '63470' AS code, 'Montenegro' AS name UNION ALL
    SELECT '63' AS dept, '63548' AS code, 'Pijao' AS name UNION ALL
    SELECT '63' AS dept, '63594' AS code, 'Quimbaya' AS name UNION ALL
    SELECT '63' AS dept, '63690' AS code, 'Salento' AS name UNION ALL
    SELECT '66' AS dept, '66001' AS code, 'Pereira' AS name UNION ALL
    SELECT '66' AS dept, '66045' AS code, 'Apía' AS name UNION ALL
    SELECT '66' AS dept, '66075' AS code, 'Balboa' AS name UNION ALL
    SELECT '66' AS dept, '66088' AS code, 'Belén de Umbría' AS name UNION ALL
    SELECT '66' AS dept, '66170' AS code, 'Dosquebradas' AS name UNION ALL
    SELECT '66' AS dept, '66318' AS code, 'Guática' AS name UNION ALL
    SELECT '66' AS dept, '66383' AS code, 'La Celia' AS name UNION ALL
    SELECT '66' AS dept, '66400' AS code, 'La Virginia' AS name UNION ALL
    SELECT '66' AS dept, '66440' AS code, 'Marsella' AS name UNION ALL
    SELECT '66' AS dept, '66456' AS code, 'Mistrató' AS name UNION ALL
    SELECT '66' AS dept, '66572' AS code, 'Pueblo Rico' AS name UNION ALL
    SELECT '66' AS dept, '66594' AS code, 'Quinchía' AS name UNION ALL
    SELECT '66' AS dept, '66682' AS code, 'Santa Rosa de Cabal' AS name UNION ALL
    SELECT '66' AS dept, '66687' AS code, 'Santuario' AS name UNION ALL
    SELECT '68' AS dept, '68001' AS code, 'Bucaramanga' AS name UNION ALL
    SELECT '68' AS dept, '68013' AS code, 'Aguada' AS name UNION ALL
    SELECT '68' AS dept, '68020' AS code, 'Albania' AS name UNION ALL
    SELECT '68' AS dept, '68051' AS code, 'Aratoca' AS name UNION ALL
    SELECT '68' AS dept, '68077' AS code, 'Barbosa' AS name UNION ALL
    SELECT '68' AS dept, '68079' AS code, 'Barichara' AS name UNION ALL
    SELECT '68' AS dept, '68081' AS code, 'Barrancabermeja' AS name UNION ALL
    SELECT '68' AS dept, '68092' AS code, 'Betulia' AS name UNION ALL
    SELECT '68' AS dept, '68101' AS code, 'Bolívar' AS name UNION ALL
    SELECT '68' AS dept, '68121' AS code, 'Cabrera' AS name UNION ALL
    SELECT '68' AS dept, '68132' AS code, 'California' AS name UNION ALL
    SELECT '68' AS dept, '68147' AS code, 'Capitanejo' AS name UNION ALL
    SELECT '68' AS dept, '68152' AS code, 'Carcasí' AS name UNION ALL
    SELECT '68' AS dept, '68160' AS code, 'Cepitá' AS name UNION ALL
    SELECT '68' AS dept, '68162' AS code, 'Cerrito' AS name UNION ALL
    SELECT '68' AS dept, '68167' AS code, 'Charalá' AS name UNION ALL
    SELECT '68' AS dept, '68169' AS code, 'Charta' AS name UNION ALL
    SELECT '68' AS dept, '68176' AS code, 'Chima' AS name UNION ALL
    SELECT '68' AS dept, '68179' AS code, 'Chipatá' AS name UNION ALL
    SELECT '68' AS dept, '68190' AS code, 'Cimitarra' AS name UNION ALL
    SELECT '68' AS dept, '68207' AS code, 'Concepción' AS name UNION ALL
    SELECT '68' AS dept, '68209' AS code, 'Confines' AS name UNION ALL
    SELECT '68' AS dept, '68211' AS code, 'Contratación' AS name UNION ALL
    SELECT '68' AS dept, '68217' AS code, 'Coromoro' AS name UNION ALL
    SELECT '68' AS dept, '68229' AS code, 'Curití' AS name UNION ALL
    SELECT '68' AS dept, '68235' AS code, 'El Carmen de Chucurí' AS name UNION ALL
    SELECT '68' AS dept, '68245' AS code, 'El Guacamayo' AS name UNION ALL
    SELECT '68' AS dept, '68250' AS code, 'El Peñón' AS name UNION ALL
    SELECT '68' AS dept, '68255' AS code, 'El Playón' AS name UNION ALL
    SELECT '68' AS dept, '68264' AS code, 'Encino' AS name UNION ALL
    SELECT '68' AS dept, '68266' AS code, 'Enciso' AS name UNION ALL
    SELECT '68' AS dept, '68271' AS code, 'Florián' AS name UNION ALL
    SELECT '68' AS dept, '68276' AS code, 'Floridablanca' AS name UNION ALL
    SELECT '68' AS dept, '68296' AS code, 'Galán' AS name UNION ALL
    SELECT '68' AS dept, '68298' AS code, 'Gámbita' AS name UNION ALL
    SELECT '68' AS dept, '68307' AS code, 'Girón' AS name UNION ALL
    SELECT '68' AS dept, '68318' AS code, 'Guaca' AS name UNION ALL
    SELECT '68' AS dept, '68320' AS code, 'Guadalupe' AS name UNION ALL
    SELECT '68' AS dept, '68322' AS code, 'Guapotá' AS name UNION ALL
    SELECT '68' AS dept, '68324' AS code, 'Guavatá' AS name UNION ALL
    SELECT '68' AS dept, '68327' AS code, 'Güepsa' AS name UNION ALL
    SELECT '68' AS dept, '68344' AS code, 'Hato' AS name UNION ALL
    SELECT '68' AS dept, '68368' AS code, 'Jesús María' AS name UNION ALL
    SELECT '68' AS dept, '68370' AS code, 'Jordán' AS name UNION ALL
    SELECT '68' AS dept, '68377' AS code, 'La Belleza' AS name UNION ALL
    SELECT '68' AS dept, '68385' AS code, 'Landázuri' AS name UNION ALL
    SELECT '68' AS dept, '68397' AS code, 'La Paz' AS name UNION ALL
    SELECT '68' AS dept, '68406' AS code, 'Lebrija' AS name UNION ALL
    SELECT '68' AS dept, '68418' AS code, 'Los Santos' AS name UNION ALL
    SELECT '68' AS dept, '68425' AS code, 'Macaravita' AS name UNION ALL
    SELECT '68' AS dept, '68432' AS code, 'Málaga' AS name UNION ALL
    SELECT '68' AS dept, '68444' AS code, 'Matanza' AS name UNION ALL
    SELECT '68' AS dept, '68464' AS code, 'Mogotes' AS name UNION ALL
    SELECT '68' AS dept, '68468' AS code, 'Molagavita' AS name UNION ALL
    SELECT '68' AS dept, '68498' AS code, 'Ocamonte' AS name UNION ALL
    SELECT '68' AS dept, '68500' AS code, 'Oiba' AS name UNION ALL
    SELECT '68' AS dept, '68502' AS code, 'Onzaga' AS name UNION ALL
    SELECT '68' AS dept, '68522' AS code, 'Palmar' AS name UNION ALL
    SELECT '68' AS dept, '68524' AS code, 'Palmas del Socorro' AS name UNION ALL
    SELECT '68' AS dept, '68533' AS code, 'Páramo' AS name UNION ALL
    SELECT '68' AS dept, '68547' AS code, 'Piedecuesta' AS name UNION ALL
    SELECT '68' AS dept, '68549' AS code, 'Pinchote' AS name UNION ALL
    SELECT '68' AS dept, '68572' AS code, 'Puente Nacional' AS name UNION ALL
    SELECT '68' AS dept, '68573' AS code, 'Puerto Parra' AS name UNION ALL
    SELECT '68' AS dept, '68575' AS code, 'Puerto Wilches' AS name UNION ALL
    SELECT '68' AS dept, '68615' AS code, 'Rionegro' AS name UNION ALL
    SELECT '68' AS dept, '68655' AS code, 'Sabana de Torres' AS name UNION ALL
    SELECT '68' AS dept, '68669' AS code, 'San Andrés' AS name UNION ALL
    SELECT '68' AS dept, '68673' AS code, 'San Benito' AS name UNION ALL
    SELECT '68' AS dept, '68679' AS code, 'San Gil' AS name UNION ALL
    SELECT '68' AS dept, '68682' AS code, 'San Joaquín' AS name UNION ALL
    SELECT '68' AS dept, '68684' AS code, 'San José de Miranda' AS name UNION ALL
    SELECT '68' AS dept, '68686' AS code, 'San Miguel' AS name UNION ALL
    SELECT '68' AS dept, '68689' AS code, 'San Vicente de Chucurí' AS name UNION ALL
    SELECT '68' AS dept, '68705' AS code, 'Santa Bárbara' AS name UNION ALL
    SELECT '68' AS dept, '68720' AS code, 'Santa Helena del Opón' AS name UNION ALL
    SELECT '68' AS dept, '68745' AS code, 'Simacota' AS name UNION ALL
    SELECT '68' AS dept, '68755' AS code, 'Socorro' AS name UNION ALL
    SELECT '68' AS dept, '68770' AS code, 'Suaita' AS name UNION ALL
    SELECT '68' AS dept, '68773' AS code, 'Sucre' AS name UNION ALL
    SELECT '68' AS dept, '68780' AS code, 'Suratá' AS name UNION ALL
    SELECT '68' AS dept, '68820' AS code, 'Tona' AS name UNION ALL
    SELECT '68' AS dept, '68855' AS code, 'Valle de San José' AS name UNION ALL
    SELECT '68' AS dept, '68861' AS code, 'Vélez' AS name UNION ALL
    SELECT '68' AS dept, '68867' AS code, 'Vetas' AS name UNION ALL
    SELECT '68' AS dept, '68872' AS code, 'Villanueva' AS name UNION ALL
    SELECT '68' AS dept, '68895' AS code, 'Zapatoca' AS name UNION ALL
    SELECT '70' AS dept, '70001' AS code, 'Sincelejo' AS name UNION ALL
    SELECT '70' AS dept, '70110' AS code, 'Buenavista' AS name UNION ALL
    SELECT '70' AS dept, '70124' AS code, 'Caimito' AS name UNION ALL
    SELECT '70' AS dept, '70204' AS code, 'Colosó' AS name UNION ALL
    SELECT '70' AS dept, '70215' AS code, 'Corozal' AS name UNION ALL
    SELECT '70' AS dept, '70221' AS code, 'Coveñas' AS name UNION ALL
    SELECT '70' AS dept, '70230' AS code, 'Chalán' AS name UNION ALL
    SELECT '70' AS dept, '70233' AS code, 'El Roble' AS name UNION ALL
    SELECT '70' AS dept, '70235' AS code, 'Galeras' AS name UNION ALL
    SELECT '70' AS dept, '70265' AS code, 'Guaranda' AS name UNION ALL
    SELECT '70' AS dept, '70400' AS code, 'La Unión' AS name UNION ALL
    SELECT '70' AS dept, '70418' AS code, 'Los Palmitos' AS name UNION ALL
    SELECT '70' AS dept, '70429' AS code, 'Majagual' AS name UNION ALL
    SELECT '70' AS dept, '70473' AS code, 'Morroa' AS name UNION ALL
    SELECT '70' AS dept, '70508' AS code, 'Ovejas' AS name UNION ALL
    SELECT '70' AS dept, '70523' AS code, 'Palmito' AS name UNION ALL
    SELECT '70' AS dept, '70670' AS code, 'Sampués' AS name UNION ALL
    SELECT '70' AS dept, '70678' AS code, 'San Benito Abad' AS name UNION ALL
    SELECT '70' AS dept, '70702' AS code, 'San Juan de Betulia' AS name UNION ALL
    SELECT '70' AS dept, '70708' AS code, 'San Marcos' AS name UNION ALL
    SELECT '70' AS dept, '70713' AS code, 'San Onofre' AS name UNION ALL
    SELECT '70' AS dept, '70717' AS code, 'San Pedro' AS name UNION ALL
    SELECT '70' AS dept, '70742' AS code, 'San Luis de Sincé' AS name UNION ALL
    SELECT '70' AS dept, '70771' AS code, 'Sucre' AS name UNION ALL
    SELECT '70' AS dept, '70820' AS code, 'Santiago de Tolú' AS name UNION ALL
    SELECT '70' AS dept, '70823' AS code, 'San José de Toluviejo' AS name UNION ALL
    SELECT '73' AS dept, '73001' AS code, 'Ibagué' AS name UNION ALL
    SELECT '73' AS dept, '73024' AS code, 'Alpujarra' AS name UNION ALL
    SELECT '73' AS dept, '73026' AS code, 'Alvarado' AS name UNION ALL
    SELECT '73' AS dept, '73030' AS code, 'Ambalema' AS name UNION ALL
    SELECT '73' AS dept, '73043' AS code, 'Anzoátegui' AS name UNION ALL
    SELECT '73' AS dept, '73055' AS code, 'Armero' AS name UNION ALL
    SELECT '73' AS dept, '73067' AS code, 'Ataco' AS name UNION ALL
    SELECT '73' AS dept, '73124' AS code, 'Cajamarca' AS name UNION ALL
    SELECT '73' AS dept, '73148' AS code, 'Carmen de Apicalá' AS name UNION ALL
    SELECT '73' AS dept, '73152' AS code, 'Casabianca' AS name UNION ALL
    SELECT '73' AS dept, '73168' AS code, 'Chaparral' AS name UNION ALL
    SELECT '73' AS dept, '73200' AS code, 'Coello' AS name UNION ALL
    SELECT '73' AS dept, '73217' AS code, 'Coyaima' AS name UNION ALL
    SELECT '73' AS dept, '73226' AS code, 'Cunday' AS name UNION ALL
    SELECT '73' AS dept, '73236' AS code, 'Dolores' AS name UNION ALL
    SELECT '73' AS dept, '73268' AS code, 'Espinal' AS name UNION ALL
    SELECT '73' AS dept, '73270' AS code, 'Falan' AS name UNION ALL
    SELECT '73' AS dept, '73275' AS code, 'Flandes' AS name UNION ALL
    SELECT '73' AS dept, '73283' AS code, 'Fresno' AS name UNION ALL
    SELECT '73' AS dept, '73319' AS code, 'Guamo' AS name UNION ALL
    SELECT '73' AS dept, '73347' AS code, 'Herveo' AS name UNION ALL
    SELECT '73' AS dept, '73349' AS code, 'Honda' AS name UNION ALL
    SELECT '73' AS dept, '73352' AS code, 'Icononzo' AS name UNION ALL
    SELECT '73' AS dept, '73408' AS code, 'Lérida' AS name UNION ALL
    SELECT '73' AS dept, '73411' AS code, 'Líbano' AS name UNION ALL
    SELECT '73' AS dept, '73443' AS code, 'San Sebastián de Mariquita' AS name UNION ALL
    SELECT '73' AS dept, '73449' AS code, 'Melgar' AS name UNION ALL
    SELECT '73' AS dept, '73461' AS code, 'Murillo' AS name UNION ALL
    SELECT '73' AS dept, '73483' AS code, 'Natagaima' AS name UNION ALL
    SELECT '73' AS dept, '73504' AS code, 'Ortega' AS name UNION ALL
    SELECT '73' AS dept, '73520' AS code, 'Palocabildo' AS name UNION ALL
    SELECT '73' AS dept, '73547' AS code, 'Piedras' AS name UNION ALL
    SELECT '73' AS dept, '73555' AS code, 'Planadas' AS name UNION ALL
    SELECT '73' AS dept, '73563' AS code, 'Prado' AS name UNION ALL
    SELECT '73' AS dept, '73585' AS code, 'Purificación' AS name UNION ALL
    SELECT '73' AS dept, '73616' AS code, 'Rioblanco' AS name UNION ALL
    SELECT '73' AS dept, '73622' AS code, 'Roncesvalles' AS name UNION ALL
    SELECT '73' AS dept, '73624' AS code, 'Rovira' AS name UNION ALL
    SELECT '73' AS dept, '73671' AS code, 'Saldaña' AS name UNION ALL
    SELECT '73' AS dept, '73675' AS code, 'San Antonio' AS name UNION ALL
    SELECT '73' AS dept, '73678' AS code, 'San Luis' AS name UNION ALL
    SELECT '73' AS dept, '73686' AS code, 'Santa Isabel' AS name UNION ALL
    SELECT '73' AS dept, '73770' AS code, 'Suárez' AS name UNION ALL
    SELECT '73' AS dept, '73854' AS code, 'Valle de San Juan' AS name UNION ALL
    SELECT '73' AS dept, '73861' AS code, 'Venadillo' AS name UNION ALL
    SELECT '73' AS dept, '73870' AS code, 'Villahermosa' AS name UNION ALL
    SELECT '73' AS dept, '73873' AS code, 'Villarrica' AS name UNION ALL
    SELECT '76' AS dept, '76001' AS code, 'Santiago de Cali' AS name UNION ALL
    SELECT '76' AS dept, '76020' AS code, 'Alcalá' AS name UNION ALL
    SELECT '76' AS dept, '76036' AS code, 'Andalucía' AS name UNION ALL
    SELECT '76' AS dept, '76041' AS code, 'Ansermanuevo' AS name UNION ALL
    SELECT '76' AS dept, '76054' AS code, 'Argelia' AS name UNION ALL
    SELECT '76' AS dept, '76100' AS code, 'Bolívar' AS name UNION ALL
    SELECT '76' AS dept, '76109' AS code, 'Buenaventura' AS name UNION ALL
    SELECT '76' AS dept, '76111' AS code, 'Guadalajara de Buga' AS name UNION ALL
    SELECT '76' AS dept, '76113' AS code, 'Bugalagrande' AS name UNION ALL
    SELECT '76' AS dept, '76122' AS code, 'Caicedonia' AS name UNION ALL
    SELECT '76' AS dept, '76126' AS code, 'Calima' AS name UNION ALL
    SELECT '76' AS dept, '76130' AS code, 'Candelaria' AS name UNION ALL
    SELECT '76' AS dept, '76147' AS code, 'Cartago' AS name UNION ALL
    SELECT '76' AS dept, '76233' AS code, 'Dagua' AS name UNION ALL
    SELECT '76' AS dept, '76243' AS code, 'El Águila' AS name UNION ALL
    SELECT '76' AS dept, '76246' AS code, 'El Cairo' AS name UNION ALL
    SELECT '76' AS dept, '76248' AS code, 'El Cerrito' AS name UNION ALL
    SELECT '76' AS dept, '76250' AS code, 'El Dovio' AS name UNION ALL
    SELECT '76' AS dept, '76275' AS code, 'Florida' AS name UNION ALL
    SELECT '76' AS dept, '76306' AS code, 'Ginebra' AS name UNION ALL
    SELECT '76' AS dept, '76318' AS code, 'Guacarí' AS name UNION ALL
    SELECT '76' AS dept, '76364' AS code, 'Jamundí' AS name UNION ALL
    SELECT '76' AS dept, '76377' AS code, 'La Cumbre' AS name UNION ALL
    SELECT '76' AS dept, '76400' AS code, 'La Unión' AS name UNION ALL
    SELECT '76' AS dept, '76403' AS code, 'La Victoria' AS name UNION ALL
    SELECT '76' AS dept, '76497' AS code, 'Obando' AS name UNION ALL
    SELECT '76' AS dept, '76520' AS code, 'Palmira' AS name UNION ALL
    SELECT '76' AS dept, '76563' AS code, 'Pradera' AS name UNION ALL
    SELECT '76' AS dept, '76606' AS code, 'Restrepo' AS name UNION ALL
    SELECT '76' AS dept, '76616' AS code, 'Riofrío' AS name UNION ALL
    SELECT '76' AS dept, '76622' AS code, 'Roldanillo' AS name UNION ALL
    SELECT '76' AS dept, '76670' AS code, 'San Pedro' AS name UNION ALL
    SELECT '76' AS dept, '76736' AS code, 'Sevilla' AS name UNION ALL
    SELECT '76' AS dept, '76823' AS code, 'Toro' AS name UNION ALL
    SELECT '76' AS dept, '76828' AS code, 'Trujillo' AS name UNION ALL
    SELECT '76' AS dept, '76834' AS code, 'Tuluá' AS name UNION ALL
    SELECT '76' AS dept, '76845' AS code, 'Ulloa' AS name UNION ALL
    SELECT '76' AS dept, '76863' AS code, 'Versalles' AS name UNION ALL
    SELECT '76' AS dept, '76869' AS code, 'Vijes' AS name UNION ALL
    SELECT '76' AS dept, '76890' AS code, 'Yotoco' AS name UNION ALL
    SELECT '76' AS dept, '76892' AS code, 'Yumbo' AS name UNION ALL
    SELECT '76' AS dept, '76895' AS code, 'Zarzal' AS name UNION ALL
    SELECT '81' AS dept, '81001' AS code, 'Arauca' AS name UNION ALL
    SELECT '81' AS dept, '81065' AS code, 'Arauquita' AS name UNION ALL
    SELECT '81' AS dept, '81220' AS code, 'Cravo Norte' AS name UNION ALL
    SELECT '81' AS dept, '81300' AS code, 'Fortul' AS name UNION ALL
    SELECT '81' AS dept, '81591' AS code, 'Puerto Rondón' AS name UNION ALL
    SELECT '81' AS dept, '81736' AS code, 'Saravena' AS name UNION ALL
    SELECT '81' AS dept, '81794' AS code, 'Tame' AS name UNION ALL
    SELECT '85' AS dept, '85001' AS code, 'Yopal' AS name UNION ALL
    SELECT '85' AS dept, '85010' AS code, 'Aguazul' AS name UNION ALL
    SELECT '85' AS dept, '85015' AS code, 'Chámeza' AS name UNION ALL
    SELECT '85' AS dept, '85125' AS code, 'Hato Corozal' AS name UNION ALL
    SELECT '85' AS dept, '85136' AS code, 'La Salina' AS name UNION ALL
    SELECT '85' AS dept, '85139' AS code, 'Maní' AS name UNION ALL
    SELECT '85' AS dept, '85162' AS code, 'Monterrey' AS name UNION ALL
    SELECT '85' AS dept, '85225' AS code, 'Nunchía' AS name UNION ALL
    SELECT '85' AS dept, '85230' AS code, 'Orocué' AS name UNION ALL
    SELECT '85' AS dept, '85250' AS code, 'Paz de Ariporo' AS name UNION ALL
    SELECT '85' AS dept, '85263' AS code, 'Pore' AS name UNION ALL
    SELECT '85' AS dept, '85279' AS code, 'Recetor' AS name UNION ALL
    SELECT '85' AS dept, '85300' AS code, 'Sabanalarga' AS name UNION ALL
    SELECT '85' AS dept, '85315' AS code, 'Sácama' AS name UNION ALL
    SELECT '85' AS dept, '85325' AS code, 'San Luis de Palenque' AS name UNION ALL
    SELECT '85' AS dept, '85400' AS code, 'Támara' AS name UNION ALL
    SELECT '85' AS dept, '85410' AS code, 'Tauramena' AS name UNION ALL
    SELECT '85' AS dept, '85430' AS code, 'Trinidad' AS name UNION ALL
    SELECT '85' AS dept, '85440' AS code, 'Villanueva' AS name UNION ALL
    SELECT '86' AS dept, '86001' AS code, 'Mocoa' AS name UNION ALL
    SELECT '86' AS dept, '86219' AS code, 'Colón' AS name UNION ALL
    SELECT '86' AS dept, '86320' AS code, 'Orito' AS name UNION ALL
    SELECT '86' AS dept, '86568' AS code, 'Puerto Asís' AS name UNION ALL
    SELECT '86' AS dept, '86569' AS code, 'Puerto Caicedo' AS name UNION ALL
    SELECT '86' AS dept, '86571' AS code, 'Puerto Guzmán' AS name UNION ALL
    SELECT '86' AS dept, '86573' AS code, 'Puerto Leguízamo' AS name UNION ALL
    SELECT '86' AS dept, '86749' AS code, 'Sibundoy' AS name UNION ALL
    SELECT '86' AS dept, '86755' AS code, 'San Francisco' AS name UNION ALL
    SELECT '86' AS dept, '86757' AS code, 'San Miguel' AS name UNION ALL
    SELECT '86' AS dept, '86760' AS code, 'Santiago' AS name UNION ALL
    SELECT '86' AS dept, '86865' AS code, 'Valle del Guamuez' AS name UNION ALL
    SELECT '86' AS dept, '86885' AS code, 'Villagarzón' AS name UNION ALL
    SELECT '88' AS dept, '88001' AS code, 'San Andrés' AS name UNION ALL
    SELECT '88' AS dept, '88564' AS code, 'Providencia' AS name UNION ALL
    SELECT '91' AS dept, '91001' AS code, 'Leticia' AS name UNION ALL
    SELECT '91' AS dept, '91263' AS code, 'El Encanto' AS name UNION ALL
    SELECT '91' AS dept, '91405' AS code, 'La Chorrera' AS name UNION ALL
    SELECT '91' AS dept, '91407' AS code, 'La Pedrera' AS name UNION ALL
    SELECT '91' AS dept, '91430' AS code, 'La Victoria' AS name UNION ALL
    SELECT '91' AS dept, '91460' AS code, 'Mirití - Paraná' AS name UNION ALL
    SELECT '91' AS dept, '91530' AS code, 'Puerto Alegría' AS name UNION ALL
    SELECT '91' AS dept, '91536' AS code, 'Puerto Arica' AS name UNION ALL
    SELECT '91' AS dept, '91540' AS code, 'Puerto Nariño' AS name UNION ALL
    SELECT '91' AS dept, '91669' AS code, 'Puerto Santander' AS name UNION ALL
    SELECT '91' AS dept, '91798' AS code, 'Tarapacá' AS name UNION ALL
    SELECT '94' AS dept, '94001' AS code, 'Inírida' AS name UNION ALL
    SELECT '94' AS dept, '94343' AS code, 'Barrancominas' AS name UNION ALL
    SELECT '94' AS dept, '94883' AS code, 'San Felipe' AS name UNION ALL
    SELECT '94' AS dept, '94884' AS code, 'Puerto Colombia' AS name UNION ALL
    SELECT '94' AS dept, '94885' AS code, 'La Guadalupe' AS name UNION ALL
    SELECT '94' AS dept, '94886' AS code, 'Cacahual' AS name UNION ALL
    SELECT '94' AS dept, '94887' AS code, 'Pana Pana' AS name UNION ALL
    SELECT '94' AS dept, '94888' AS code, 'Morichal' AS name UNION ALL
    SELECT '95' AS dept, '95001' AS code, 'San José del Guaviare' AS name UNION ALL
    SELECT '95' AS dept, '95015' AS code, 'Calamar' AS name UNION ALL
    SELECT '95' AS dept, '95025' AS code, 'El Retorno' AS name UNION ALL
    SELECT '95' AS dept, '95200' AS code, 'Miraflores' AS name UNION ALL
    SELECT '97' AS dept, '97001' AS code, 'Mitú' AS name UNION ALL
    SELECT '97' AS dept, '97161' AS code, 'Carurú' AS name UNION ALL
    SELECT '97' AS dept, '97511' AS code, 'Pacoa' AS name UNION ALL
    SELECT '97' AS dept, '97666' AS code, 'Taraira' AS name UNION ALL
    SELECT '97' AS dept, '97777' AS code, 'Papunahua' AS name UNION ALL
    SELECT '97' AS dept, '97889' AS code, 'Yavaraté' AS name UNION ALL
    SELECT '99' AS dept, '99001' AS code, 'Puerto Carreño' AS name UNION ALL
    SELECT '99' AS dept, '99524' AS code, 'La Primavera' AS name UNION ALL
    SELECT '99' AS dept, '99624' AS code, 'Santa Rosalía' AS name UNION ALL
    SELECT '99' AS dept, '99773' AS code, 'Cumaribo' AS name
) v ON v.dept = d.code
WHERE d.country_iso2 = 'CO'
ON DUPLICATE KEY UPDATE name = VALUES(name), is_active = TRUE;
