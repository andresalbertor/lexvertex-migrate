-- V25: Limpieza de roles antiguos redundantes
DELETE FROM role_permission WHERE role_id IN (SELECT id FROM role WHERE code IN ('ADMIN', 'ABOGADO', 'AUXILIAR'));
DELETE FROM role WHERE code IN ('ADMIN', 'ABOGADO', 'AUXILIAR');
