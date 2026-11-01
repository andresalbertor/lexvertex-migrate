-- V52: Permisos granulares por pantalla de menú y migración compatible de roles
-- Permite gobernar independientemente cada pantalla de Parametrización, Organización y Configuración de Email (HU-ROL-01).

-- 1. Inserción idempotente de los 31 nuevos permisos granulares
INSERT INTO permission (code, description) VALUES
    ('document-type:read', 'Ver tipos de documento'),
    ('document-type:create', 'Crear tipos de documento'),
    ('document-type:update', 'Actualizar tipos de documento'),
    ('document-type:delete', 'Eliminar tipos de documento'),
    ('location:read', 'Ver países, departamentos y ciudades'),
    ('location:create', 'Crear ubicaciones geográficas'),
    ('location:update', 'Actualizar ubicaciones geográficas'),
    ('location:delete', 'Eliminar ubicaciones geográficas'),
    ('chamber:read', 'Ver cámaras de comercio'),
    ('chamber:create', 'Crear cámaras de comercio'),
    ('chamber:update', 'Actualizar cámaras de comercio'),
    ('chamber:delete', 'Eliminar cámaras de comercio'),
    ('disability-category:read', 'Ver categorías de discapacidad'),
    ('disability-category:create', 'Crear categorías de discapacidad'),
    ('disability-category:update', 'Actualizar categorías de discapacidad'),
    ('disability-category:delete', 'Eliminar categorías de discapacidad'),
    ('position:read', 'Ver cargos organizacionales'),
    ('position:create', 'Crear cargos organizacionales'),
    ('position:update', 'Actualizar cargos organizacionales'),
    ('position:delete', 'Eliminar cargos organizacionales'),
    ('specialty:read', 'Ver especialidades jurídicas'),
    ('specialty:create', 'Crear especialidades jurídicas'),
    ('specialty:update', 'Actualizar especialidades jurídicas'),
    ('specialty:delete', 'Eliminar especialidades jurídicas'),
    ('process-type:read', 'Ver tipos de proceso'),
    ('process-type:create', 'Crear tipos de proceso'),
    ('process-type:update', 'Actualizar tipos de proceso'),
    ('process-type:delete', 'Eliminar tipos de proceso'),
    ('channel:read', 'Ver configuración de canales de correo'),
    ('channel:create', 'Crear cuentas y alias de correo institucional'),
    ('channel:delete', 'Eliminar cuentas y alias de correo institucional')
ON DUPLICATE KEY UPDATE description = VALUES(description);

-- 2. Asignación completa de los 31 permisos al rol administrador (ADMN)
INSERT IGNORE INTO role_permission (role_id, permission_id)
SELECT r.id, p.id
FROM role r
CROSS JOIN permission p
WHERE r.code = 'ADMN'
  AND p.code IN (
    'document-type:read', 'document-type:create', 'document-type:update', 'document-type:delete',
    'location:read', 'location:create', 'location:update', 'location:delete',
    'chamber:read', 'chamber:create', 'chamber:update', 'chamber:delete',
    'disability-category:read', 'disability-category:create', 'disability-category:update', 'disability-category:delete',
    'position:read', 'position:create', 'position:update', 'position:delete',
    'specialty:read', 'specialty:create', 'specialty:update', 'specialty:delete',
    'process-type:read', 'process-type:create', 'process-type:update', 'process-type:delete',
    'channel:read', 'channel:create', 'channel:delete'
  );

-- 3. Asignación compatible de lectura (:read) a roles no-administradores que poseen catalog:read
-- Conserva catalog:read intacto durante el despliegue rolling sin asignar permisos mutables ni channel:*
INSERT IGNORE INTO role_permission (role_id, permission_id)
SELECT DISTINCT rp.role_id, p_new.id
FROM role_permission rp
JOIN permission p_old ON rp.permission_id = p_old.id AND p_old.code = 'catalog:read'
JOIN role r ON rp.role_id = r.id AND r.code <> 'ADMN'
CROSS JOIN permission p_new
WHERE p_new.code IN (
    'document-type:read',
    'location:read',
    'chamber:read',
    'disability-category:read',
    'position:read',
    'specialty:read',
    'process-type:read'
);
