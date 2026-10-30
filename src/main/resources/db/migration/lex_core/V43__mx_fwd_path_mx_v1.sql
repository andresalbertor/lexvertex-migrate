-- Move mx-fwd off /api/v1/** so Vigilís Path=/api/** cannot swallow it.

UPDATE PROPERTIES
SET `VALUE` = 'Path=/mx/v1/**'
WHERE APPLICATION = 'gateway-service'
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` = 'spring.cloud.gateway.server.webflux.routes[7].predicates[0]';
