-- Ruta gateway hacia mx-fwd (reenvíos de correo). Sin permiso nuevo: solo rol ADMN en UI/API.

DELETE FROM PROPERTIES
WHERE APPLICATION = 'gateway-service'
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` IN (
    'spring.cloud.gateway.server.webflux.routes[7].id',
    'spring.cloud.gateway.server.webflux.routes[7].uri',
    'spring.cloud.gateway.server.webflux.routes[7].predicates[0]'
  );

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, `VALUE`) VALUES
    ('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[7].id', 'mx-fwd'),
    ('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[7].uri', 'http://mx-fwd:8099'),
    ('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[7].predicates[0]', 'Path=/api/v1/mx/**');
