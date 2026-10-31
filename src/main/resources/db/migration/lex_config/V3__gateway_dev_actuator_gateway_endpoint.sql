-- Expone /actuator/gateway/** solo en gateway-service PROFILE=dev (debug local).
-- Schema: lex_config.PROPERTIES. No modifica application/default.

DELETE FROM PROPERTIES
WHERE APPLICATION = 'gateway-service'
  AND PROFILE = 'dev'
  AND LABEL = 'master'
  AND `KEY` = 'management.endpoints.web.exposure.include';

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE) VALUES
('gateway-service', 'dev', 'master', 'management.endpoints.web.exposure.include', 'health,info,gateway');
