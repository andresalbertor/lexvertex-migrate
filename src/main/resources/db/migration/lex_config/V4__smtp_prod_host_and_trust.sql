-- PDN SMTP: host + STARTTLS trust del docker-mailserver en Config Server.
-- Evita MAIL_HOST / MAIL_SMTP_* / ssl.trust solo en compose o application.yml.

-- Host literal (antes ${MAIL_HOST} exigía env en cada MS).
UPDATE PROPERTIES
SET VALUE = 'mailserver'
WHERE LABEL = 'master'
  AND PROFILE = 'prod'
  AND `KEY` = 'spring.mail.host'
  AND APPLICATION IN ('identity-service', 'account-service', 'notification-service');

-- Puerto fijo PDN (antes ${MAIL_PORT:587}).
UPDATE PROPERTIES
SET VALUE = '587'
WHERE LABEL = 'master'
  AND PROFILE = 'prod'
  AND `KEY` = 'spring.mail.port'
  AND APPLICATION IN ('identity-service', 'account-service', 'notification-service');

-- Trust del cert interno de docker-mailserver (faltaba → PKIX en account/identity).
INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE) VALUES
('identity-service', 'prod', 'master', 'spring.mail.properties.mail.smtp.ssl.trust', 'mailserver'),
('account-service', 'prod', 'master', 'spring.mail.properties.mail.smtp.ssl.trust', 'mailserver'),
('notification-service', 'prod', 'master', 'spring.mail.properties.mail.smtp.ssl.trust', 'mailserver'),
('application', 'prod', 'master', 'spring.mail.properties.mail.smtp.ssl.trust', 'mailserver')
AS new_row
ON DUPLICATE KEY UPDATE VALUE = new_row.VALUE;

-- Compartido application/prod: host/auth/starttls por si un MS nuevo no declara override.
INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE) VALUES
('application', 'prod', 'master', 'spring.mail.host', 'mailserver'),
('application', 'prod', 'master', 'spring.mail.port', '587'),
('application', 'prod', 'master', 'spring.mail.properties.mail.smtp.auth', 'true'),
('application', 'prod', 'master', 'spring.mail.properties.mail.smtp.starttls.enable', 'true')
AS new_row
ON DUPLICATE KEY UPDATE VALUE = new_row.VALUE;
