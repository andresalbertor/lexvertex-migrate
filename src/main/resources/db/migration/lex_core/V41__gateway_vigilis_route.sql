-- Gateway route for Vigilís (Python MS on Eureka as VIGILIS-SERVICE).
-- Index 8 (after mx-fwd at 7). order=1000 so /api/v1/** Lexvertex routes keep precedence over /api/**.

DELETE FROM PROPERTIES
WHERE APPLICATION = 'gateway-service'
  AND PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` LIKE 'spring.cloud.gateway.server.webflux.routes[8].%';

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE) VALUES
('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[8].id', 'vigilis-service'),
('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[8].uri', 'lb://VIGILIS-SERVICE'),
('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[8].order', '1000'),
('gateway-service', 'default', 'master', 'spring.cloud.gateway.server.webflux.routes[8].predicates[0]',
 'Path=/api/**,/view/**,/static/**,/docs,/docs/**,/redoc,/redoc/**,/openapi.json');
