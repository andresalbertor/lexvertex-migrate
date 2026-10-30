-- Eureka hostname: localhost by default (host bootRun). Docker sets EUREKA_INSTANCE_HOSTNAME=<service>.
UPDATE PROPERTIES
SET `VALUE` = '${EUREKA_INSTANCE_HOSTNAME:localhost}'
WHERE PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` = 'eureka.instance.hostname'
  AND APPLICATION IN (
    'identity-service',
    'client-service',
    'catalog-service',
    'gateway-service'
  );

UPDATE PROPERTIES
SET `VALUE` = '${IDENTITY_JWKS_URI:http://localhost:8081/.well-known/jwks.json}'
WHERE APPLICATION = 'gateway-service'
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` = 'spring.security.oauth2.resourceserver.jwt.jwk-set-uri';
