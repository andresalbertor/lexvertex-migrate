-- Mail + OpenAPI props (lexvertex.*) for config-server JDBC.
DELETE FROM PROPERTIES
WHERE APPLICATION = 'identity-service'
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` IN (
    'app.email.from',
    'app.frontend.base-url',
    'lexvertex.mail.from',
    'lexvertex.mail.frontend-base-url',
    'lexvertex.openapi.enabled',
    'lexvertex.openapi.title',
    'lexvertex.openapi.description',
    'lexvertex.openapi.version',
    'lexvertex.openapi.contact-name',
    'lexvertex.openapi.security-scheme-name',
    'lexvertex.openapi.bearer-format',
    'lexvertex.openapi.bearer-description'
  );

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, `VALUE`) VALUES
    ('identity-service', 'default', 'master', 'lexvertex.mail.from', '${MAIL_FROM:no-reply@lexvertex.local}'),
    ('identity-service', 'default', 'master', 'lexvertex.mail.frontend-base-url', '${FRONTEND_BASE_URL:http://localhost:8089}'),
    ('identity-service', 'default', 'master', 'lexvertex.openapi.enabled', 'true'),
    ('identity-service', 'default', 'master', 'lexvertex.openapi.title', 'Lex Vertex Identity API'),
    ('identity-service', 'default', 'master', 'lexvertex.openapi.description', 'Autenticación, MFA, usuarios, roles y sesiones de Lex Vertex.'),
    ('identity-service', 'default', 'master', 'lexvertex.openapi.version', 'v1'),
    ('identity-service', 'default', 'master', 'lexvertex.openapi.contact-name', 'Lex Vertex'),
    ('identity-service', 'default', 'master', 'lexvertex.openapi.security-scheme-name', 'bearerAuth'),
    ('identity-service', 'default', 'master', 'lexvertex.openapi.bearer-format', 'JWT'),
    ('identity-service', 'default', 'master', 'lexvertex.openapi.bearer-description', 'Token de acceso emitido por /api/v1/auth/mfa/verify');

DELETE FROM PROPERTIES
WHERE APPLICATION IN ('catalog-service', 'client-service')
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` LIKE 'lexvertex.openapi.%';

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, `VALUE`) VALUES
    ('catalog-service', 'default', 'master', 'lexvertex.openapi.enabled', 'true'),
    ('catalog-service', 'default', 'master', 'lexvertex.openapi.title', 'Lex Vertex Catalog API'),
    ('catalog-service', 'default', 'master', 'lexvertex.openapi.description', 'Catálogos geográficos y de referencia.'),
    ('catalog-service', 'default', 'master', 'lexvertex.openapi.version', 'v1'),
    ('catalog-service', 'default', 'master', 'lexvertex.openapi.contact-name', 'Lex Vertex'),
    ('client-service', 'default', 'master', 'lexvertex.openapi.enabled', 'true'),
    ('client-service', 'default', 'master', 'lexvertex.openapi.title', 'Lex Vertex Client API'),
    ('client-service', 'default', 'master', 'lexvertex.openapi.description', 'CRM de clientes y party.'),
    ('client-service', 'default', 'master', 'lexvertex.openapi.version', 'v1'),
    ('client-service', 'default', 'master', 'lexvertex.openapi.contact-name', 'Lex Vertex');
