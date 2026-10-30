-- All inter-service / Eureka hosts must be env placeholders (no bare Docker DNS literals).
-- Docker/VPS sets EUREKA_INSTANCE_HOSTNAME, EUREKA_URL, IDENTITY_JWKS_URI, CLIENT_SERVICE_URL.

UPDATE PROPERTIES
SET `VALUE` = '${EUREKA_INSTANCE_HOSTNAME:localhost}'
WHERE PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` = 'eureka.instance.hostname';

UPDATE PROPERTIES
SET `VALUE` = '${EUREKA_URL:http://localhost:8761/eureka/}'
WHERE PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` = 'eureka.client.service-url.defaultZone';

UPDATE PROPERTIES
SET `VALUE` = '${IDENTITY_JWKS_URI:http://localhost:8081/.well-known/jwks.json}'
WHERE PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` IN (
    'spring.security.oauth2.resourceserver.jwt.jwk-set-uri',
    'app.jwt.jwks-uri'
  );

UPDATE PROPERTIES
SET `VALUE` = '${CLIENT_SERVICE_URL:http://localhost:8082}'
WHERE APPLICATION = 'identity-service'
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` = 'app.client-service.base-url';
