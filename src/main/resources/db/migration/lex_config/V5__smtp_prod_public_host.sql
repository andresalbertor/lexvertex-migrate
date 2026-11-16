-- PDN: el certificado de docker-mailserver es CN=mail.lexvertex.cloud.
-- V4 apuntó spring.mail.host y ssl.trust a mailserver; el handshake rechaza ese nombre.

UPDATE PROPERTIES
SET VALUE = 'mail.lexvertex.cloud'
WHERE LABEL = 'master'
  AND PROFILE = 'prod'
  AND `KEY` = 'spring.mail.host'
  AND APPLICATION IN ('identity-service', 'account-service', 'notification-service', 'application');

UPDATE PROPERTIES
SET VALUE = 'mail.lexvertex.cloud'
WHERE LABEL = 'master'
  AND PROFILE = 'prod'
  AND `KEY` = 'spring.mail.properties.mail.smtp.ssl.trust'
  AND APPLICATION IN ('identity-service', 'account-service', 'notification-service', 'application');
