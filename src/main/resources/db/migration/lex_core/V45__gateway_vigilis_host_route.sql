-- Vigilís entra por https://vigilis.lexvertex.cloud (Host), no por /vigilis/** en api.

DELETE FROM PROPERTIES
WHERE APPLICATION = 'gateway-service'
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` LIKE 'spring.cloud.gateway.server.webflux.routes[8].%';

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE) VALUES
('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[8].id', 'vigilis'),
('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[8].uri',
 '${VIGILIS_SERVICE_URL:http://vigilis-web:8000}'),
('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[8].order', '-1'),
('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[8].predicates[0]',
 'Host=vigilis.lexvertex.cloud');
