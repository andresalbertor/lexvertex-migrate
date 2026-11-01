-- Discovery: clientes internos usan serviceId Eureka, no URL física.
-- Reemplaza app.*.base-url por app.*.service-id y limpia CLIENT_SERVICE_URL.

DELETE FROM PROPERTIES
WHERE `KEY` IN ('app.client-service.base-url', 'app.identity-service.base-url');

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE)
VALUES ('identity-service', 'default', 'master', 'app.client-service.service-id', '${CLIENT_SERVICE_ID:client-service}')
ON DUPLICATE KEY UPDATE VALUE = VALUES(VALUE);

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE)
VALUES ('identity-service', 'dev', 'master', 'app.client-service.service-id', 'client-service')
ON DUPLICATE KEY UPDATE VALUE = VALUES(VALUE);

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE)
VALUES ('identity-service', 'prod', 'master', 'app.client-service.service-id', 'client-service')
ON DUPLICATE KEY UPDATE VALUE = VALUES(VALUE);

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE)
VALUES ('client-service', 'default', 'master', 'app.identity-service.service-id', '${IDENTITY_SERVICE_ID:identity-service}')
ON DUPLICATE KEY UPDATE VALUE = VALUES(VALUE);

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE)
VALUES ('client-service', 'dev', 'master', 'app.identity-service.service-id', 'identity-service')
ON DUPLICATE KEY UPDATE VALUE = VALUES(VALUE);

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE)
VALUES ('client-service', 'prod', 'master', 'app.identity-service.service-id', 'identity-service')
ON DUPLICATE KEY UPDATE VALUE = VALUES(VALUE);
