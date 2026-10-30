-- Deterministic seed of the permission catalog and role-permission mappings.
-- Keeps a fresh database complete even before the application bootstrap runs.

INSERT INTO permission (code, description) VALUES
    ('user:read', 'Ver usuarios'),
    ('user:create', 'Crear usuarios'),
    ('user:update', 'Actualizar usuarios'),
    ('user:delete', 'Eliminar usuarios'),
    ('user:disable', 'Desactivar usuarios'),
    ('user:assign-role', 'Asignar roles'),
    ('role:read', 'Ver roles y permisos'),
    ('role:create', 'Crear roles'),
    ('role:update', 'Actualizar roles y permisos'),
    ('role:delete', 'Eliminar roles'),
    ('session:read', 'Ver sesiones de usuarios'),
    ('session:revoke', 'Revocar sesiones de usuarios'),
    ('organization:read', 'Ver configuración de la compañía'),
    ('organization:update', 'Actualizar configuración de la compañía'),
    ('catalog:read', 'Ver catálogos'),
    ('person:read', 'Ver personas'),
    ('person:create', 'Crear personas'),
    ('person:update', 'Actualizar personas'),
    ('person:delete', 'Eliminar personas'),
    ('client:read', 'Ver clientes'),
    ('client:create', 'Crear clientes'),
    ('client:update', 'Actualizar clientes'),
    ('client:delete', 'Borrar clientes'),
    ('client:read-sensitive', 'Ver datos sensibles de clientes'),
    ('client:export', 'Exportar clientes'),
    ('client:download', 'Descargar documentos de clientes'),
    ('case:read', 'Ver casos'),
    ('case:create', 'Crear casos'),
    ('case:update', 'Actualizar casos'),
    ('case:delete', 'Borrar casos'),
    ('case:export', 'Exportar casos'),
    ('document:read', 'Ver documentos'),
    ('document:upload', 'Subir documentos'),
    ('document:verify', 'Verificar documentos'),
    ('document:delete', 'Borrar documentos'),
    ('document:download', 'Descargar documentos'),
    ('report:read', 'Ver reportes'),
    ('report:export', 'Exportar reportes'),
    ('audit:read', 'Ver auditoría'),
    ('audit:export', 'Exportar auditoría')
ON DUPLICATE KEY UPDATE description = VALUES(description);

INSERT IGNORE INTO role_permission (role_id, permission_id)
SELECT r.id, p.id FROM role r CROSS JOIN permission p WHERE r.code = 'ADMIN';

INSERT IGNORE INTO role_permission (role_id, permission_id)
SELECT r.id, p.id FROM role r JOIN permission p ON p.code IN (
    'user:read', 'organization:read', 'catalog:read',
    'person:read', 'person:create', 'person:update',
    'client:read', 'client:create', 'client:update', 'client:read-sensitive',
    'client:export', 'client:download',
    'case:read', 'case:create', 'case:update', 'case:export',
    'document:read', 'document:upload', 'document:verify', 'document:download',
    'report:read', 'report:export'
) WHERE r.code = 'ABOGADO';

INSERT IGNORE INTO role_permission (role_id, permission_id)
SELECT r.id, p.id FROM role r JOIN permission p ON p.code IN (
    'organization:read', 'catalog:read',
    'person:read', 'person:create', 'person:update',
    'client:read', 'client:create', 'client:update', 'client:read-sensitive', 'client:download',
    'case:read', 'case:create', 'case:update',
    'document:read', 'document:upload', 'document:verify', 'document:download'
) WHERE r.code = 'AUXILIAR';
