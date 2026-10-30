-- Prefer Docker DNS for Vigilís (lex-apps hostname) so routing works even before Eureka registration.

UPDATE PROPERTIES
SET `VALUE` = '${VIGILIS_SERVICE_URL:http://vigilis-web:8000}'
WHERE APPLICATION = 'gateway-service'
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` = 'spring.cloud.gateway.server.webflux.routes[8].uri';
