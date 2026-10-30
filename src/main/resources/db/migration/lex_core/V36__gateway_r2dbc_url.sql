-- Gateway uses R2DBC; do not bind spring.r2dbc.url to JDBC DB_URL.
DELETE FROM PROPERTIES
WHERE APPLICATION = 'gateway-service'
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` IN ('spring.r2dbc.url', 'spring.r2dbc.username', 'spring.r2dbc.password');

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, `VALUE`) VALUES
('gateway-service', 'default', 'master', 'spring.r2dbc.url', '${R2DBC_URL:r2dbc:mysql://localhost:3306/lex_core?allowPublicKeyRetrieval=true&serverTimezone=UTC}'),
('gateway-service', 'default', 'master', 'spring.r2dbc.username', '${DB_USER}'),
('gateway-service', 'default', 'master', 'spring.r2dbc.password', '${DB_PASSWORD}');
