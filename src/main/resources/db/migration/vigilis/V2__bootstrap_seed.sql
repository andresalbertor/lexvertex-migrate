-- Bootstrap seed for schema vigilis (default app_config + schema_migrations ledger).
-- Mirrors vigilis.data.gateway DEFAULT_* so cold-start PDN has usable initial settings.
-- SMTP secrets stay empty; operators configure despacho_smtp_default after deploy.

SET NAMES utf8mb4;
SET time_zone = '+00:00';

-- ---------------------------------------------------------------------------
-- app_config: configuraciones iniciales del producto
-- ---------------------------------------------------------------------------
INSERT INTO `app_config` (`key`, `value`, `updated_at`, `updated_by`) VALUES
(
  'scheduler_config',
  CAST('{"enabled":true,"mode":"custom_days","days":["mon","tue","wed","thu","fri"],"hour":8,"minute":0,"interval_hours":4,"interval_minutes":0,"cron_expression":"0 8 * * 1-5","timezone":"America/Bogota"}' AS JSON),
  UTC_TIMESTAMP(3),
  'SYSTEM'
),
(
  'sic_chequeo_inicial',
  CAST('{"modo":"mes","dias_atras":7,"mes":10,"ano":2026}' AS JSON),
  UTC_TIMESTAMP(3),
  'SYSTEM'
),
(
  'documentos_retencion_dias',
  CAST('60' AS JSON),
  UTC_TIMESTAMP(3),
  'SYSTEM'
),
(
  'despacho_smtp_default',
  CAST('{"smtp_host":"","smtp_port":587,"smtp_user":"","smtp_password":"","smtp_security":"tls","smtp_remitente_email":"","smtp_remitente_nombre":"Vigilis by Lex Vertex"}' AS JSON),
  UTC_TIMESTAMP(3),
  'SYSTEM'
),
(
  'despacho_config',
  CAST('{"max_intentos":3,"smtp_usar_default":true,"smtp_host":"","smtp_port":587,"smtp_user":"","smtp_password":"","smtp_security":"tls","smtp_remitente_email":"","smtp_remitente_nombre":"Vigilis by Lex Vertex"}' AS JSON),
  UTC_TIMESTAMP(3),
  'SYSTEM'
),
(
  'destinatario_default',
  CAST('{"para":"","nombre":"","tratamiento":"","cc":""}' AS JSON),
  UTC_TIMESTAMP(3),
  'SYSTEM'
),
(
  'sync_status_registry',
  CAST('{}' AS JSON),
  UTC_TIMESTAMP(3),
  'SYSTEM'
),
(
  'scheduler_runtime',
  CAST('{}' AS JSON),
  UTC_TIMESTAMP(3),
  'SYSTEM'
);

-- ---------------------------------------------------------------------------
-- schema_migrations: marca 001-006 como aplicadas (DDL ya está en V1).
-- Evita que VIGILIS_DB_APPLY_MIGRATIONS=true intente ALTER sobre el baseline.
-- ---------------------------------------------------------------------------
INSERT INTO `schema_migrations` (`version`, `applied_at`) VALUES
  ('001_initial', UTC_TIMESTAMP(3)),
  ('002_unificacion_vigilancia', UTC_TIMESTAMP(3)),
  ('003_eliminacion_logica_vigilancias', UTC_TIMESTAMP(3)),
  ('004_procesos_canonicos_uuid', UTC_TIMESTAMP(3)),
  ('005_actuaciones_enlace_auto', UTC_TIMESTAMP(3)),
  ('006_audit_created_by_updated_by', UTC_TIMESTAMP(3));
