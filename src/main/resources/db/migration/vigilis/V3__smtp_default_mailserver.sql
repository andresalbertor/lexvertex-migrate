-- PDN: hidrata despacho_smtp_default (SMTP del producto, oculto en UI).
-- Auth: contact@ (buzón operativo). From: no-reply@ (remitente visible).
-- Host público mail.lexvertex.cloud (cert STARTTLS del docker-mailserver).
-- smtp_password permanece vacío en Flyway — one-shot PDN con MAIL_CONTACT_PASSWORD.

UPDATE `app_config`
SET
  `value` = JSON_SET(
    COALESCE(`value`, CAST('{}' AS JSON)),
    '$.smtp_host', 'mail.lexvertex.cloud',
    '$.smtp_port', 587,
    '$.smtp_user', 'contact@lexvertex.cloud',
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
