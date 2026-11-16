-- Default de Vigilis: el mismo correo de infra (mail.lexvertex.cloud).
-- Auth y From son no-reply@ (SPOOF_PROTECTION). smtp_password no se escribe aquí.

UPDATE `app_config`
SET
  `value` = JSON_SET(
    COALESCE(`value`, CAST('{}' AS JSON)),
    '$.smtp_host', 'mail.lexvertex.cloud',
    '$.smtp_port', 587,
    '$.smtp_user', 'no-reply@lexvertex.cloud',
    '$.smtp_security', 'tls',
    '$.smtp_remitente_email', 'no-reply@lexvertex.cloud',
    '$.smtp_remitente_nombre', 'Vigilis by Lex Vertex'
  ),
  `updated_at` = UTC_TIMESTAMP(3),
  `updated_by` = 'SYSTEM'
WHERE `key` = 'despacho_smtp_default';
