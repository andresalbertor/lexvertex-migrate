-- PDN: hidrata despacho_smtp_default con el docker-mailserver interno.
-- V2 dejó host/user/password vacíos a propósito (secretos); este script fija
-- lo no secreto. smtp_password permanece vacío en Flyway — se inyecta en PDN
-- con one-shot (MAIL_NOREPLY_PASSWORD), nunca en git.

UPDATE `app_config`
SET
  `value` = JSON_SET(
    COALESCE(`value`, CAST('{}' AS JSON)),
    '$.smtp_host', 'mailserver',
    '$.smtp_port', 587,
    '$.smtp_user', 'no-reply@lexvertex.cloud',
    '$.smtp_security', 'tls',
    '$.smtp_remitente_email', 'no-reply@lexvertex.cloud',
    '$.smtp_remitente_nombre', 'Vigilis by Lex Vertex'
  ),
  `updated_at` = UTC_TIMESTAMP(3),
  `updated_by` = 'SYSTEM'
WHERE `key` = 'despacho_smtp_default';

-- Asegura que el despacho use el default oculto (campos propios vacíos).
UPDATE `app_config`
SET
  `value` = JSON_SET(
    COALESCE(`value`, CAST('{}' AS JSON)),
    '$.smtp_usar_default', CAST('true' AS JSON),
    '$.smtp_host', '',
    '$.smtp_port', 587,
    '$.smtp_user', '',
    '$.smtp_password', '',
    '$.smtp_security', 'tls',
    '$.smtp_remitente_email', '',
    '$.smtp_remitente_nombre', 'Vigilis by Lex Vertex'
  ),
  `updated_at` = UTC_TIMESTAMP(3),
  `updated_by` = 'SYSTEM'
WHERE `key` = 'despacho_config';
