-- Permisos de Vigilis (vigilancia judicial) y asignación a roles Lex Vertex.
-- Consumidos por gateway-service → cabecera X-User-Permissions hacia vigilis.lexvertex.cloud.

INSERT INTO permission (code, description) VALUES
    ('vigilancia:read', 'Ver dashboard, procesos y novedades de Vigilis'),
    ('vigilancia:config', 'Administrar configuración, SMTP y scheduler de Vigilis'),
    ('vigilancia:sync', 'Disparar sincronización de vigilancia en Vigilis'),
    ('vigilancia:dispatch', 'Reintentar despacho de novedades en Vigilis')
ON DUPLICATE KEY UPDATE description = VALUES(description);

-- ADMN: acceso completo
INSERT IGNORE INTO role_permission (role_id, permission_id)
SELECT r.id, p.id
FROM role r
CROSS JOIN permission p
WHERE r.code = 'ADMN'
  AND p.code IN ('vigilancia:read', 'vigilancia:config', 'vigilancia:sync', 'vigilancia:dispatch');

-- ABOG: lectura + despacho de novedades
INSERT IGNORE INTO role_permission (role_id, permission_id)
SELECT r.id, p.id
FROM role r
JOIN permission p ON p.code IN ('vigilancia:read', 'vigilancia:dispatch')
WHERE r.code = 'ABOG';

-- AUXI: solo lectura
INSERT IGNORE INTO role_permission (role_id, permission_id)
SELECT r.id, p.id
FROM role r
JOIN permission p ON p.code = 'vigilancia:read'
WHERE r.code = 'AUXI';
