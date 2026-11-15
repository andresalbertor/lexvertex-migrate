-- El modelo vigente guarda la novedad SIC en actuaciones y notificaciones_email.

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS vigilancia_sic_hallazgos;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO schema_migrations (version, applied_at)
SELECT '007_retirar_hallazgos_sic_legacy', UTC_TIMESTAMP(3)
WHERE NOT EXISTS (
    SELECT 1 FROM schema_migrations WHERE version = '007_retirar_hallazgos_sic_legacy'
);
