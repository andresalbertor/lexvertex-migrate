-- Prod DMS (587) needs SMTP auth + STARTTLS; local Mailpit keeps defaults false.
-- MAIL_USER (not MAIL_USERNAME) is the env Spring resolves for spring.mail.username.

UPDATE PROPERTIES
SET `VALUE` = '${MAIL_SMTP_AUTH:false}'
WHERE PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` = 'spring.mail.properties.mail.smtp.auth'
  AND APPLICATION IN ('identity-service', 'notification-service');

UPDATE PROPERTIES
SET `VALUE` = '${MAIL_SMTP_STARTTLS:false}'
WHERE PROFILE = 'default'
  AND LABEL = 'master'
  AND `KEY` = 'spring.mail.properties.mail.smtp.starttls.enable'
  AND APPLICATION IN ('identity-service', 'notification-service');

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE)
SELECT apps.APPLICATION, 'default', 'master', 'spring.mail.properties.mail.smtp.ssl.trust', '${MAIL_SMTP_SSL_TRUST:}'
FROM (
    SELECT 'identity-service' AS APPLICATION
    UNION ALL
    SELECT 'notification-service'
) apps
WHERE NOT EXISTS (
    SELECT 1
    FROM PROPERTIES p
    WHERE p.APPLICATION = apps.APPLICATION
      AND p.PROFILE = 'default'
      AND p.LABEL = 'master'
      AND p.`KEY` = 'spring.mail.properties.mail.smtp.ssl.trust'
);
