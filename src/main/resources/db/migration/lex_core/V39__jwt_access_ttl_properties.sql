-- Access / refresh TTL: fuente de verdad = PROPERTIES (config-server JDBC).
DELETE FROM PROPERTIES
WHERE APPLICATION = 'identity-service'
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` IN ('app.jwt.access-ttl', 'app.auth.refresh-ttl');

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, `VALUE`) VALUES
('identity-service', 'default', 'master', 'app.jwt.access-ttl', '${JWT_ACCESS_TTL:PT1H}'),
('identity-service', 'default', 'master', 'app.auth.refresh-ttl', '${JWT_REFRESH_TTL:P30D}');
