-- Logging policy: third-party / frameworks = ERROR; Lex packages = ERROR.
-- Removes noisy DEBUG/INFO inherited by Spring Cloud Gateway and root in dev/prod.

DELETE FROM PROPERTIES
WHERE LABEL = 'master'
  AND `KEY` IN (
    'logging.level.root',
    'logging.level.com.lexvertex',
    'logging.level.org.springframework',
    'logging.level.org.springframework.cloud.gateway',
    'logging.level.org.hibernate',
    'logging.level.com.zaxxer.hikari',
    'logging.level.org.apache'
  )
  AND PROFILE IN ('default', 'dev', 'prod')
  AND APPLICATION = 'application';

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE) VALUES
('application', 'default', 'master', 'logging.level.root', 'ERROR'),
('application', 'default', 'master', 'logging.level.com.lexvertex', 'ERROR'),
('application', 'default', 'master', 'logging.level.org.springframework', 'ERROR'),
('application', 'default', 'master', 'logging.level.org.hibernate', 'ERROR'),
('application', 'default', 'master', 'logging.level.com.zaxxer.hikari', 'ERROR'),
('application', 'default', 'master', 'logging.level.org.apache', 'ERROR'),
('application', 'dev', 'master', 'logging.level.root', 'ERROR'),
('application', 'dev', 'master', 'logging.level.com.lexvertex', 'ERROR'),
('application', 'dev', 'master', 'logging.level.org.springframework', 'ERROR'),
('application', 'dev', 'master', 'logging.level.org.springframework.cloud.gateway', 'ERROR'),
('application', 'prod', 'master', 'logging.level.root', 'ERROR'),
('application', 'prod', 'master', 'logging.level.com.lexvertex', 'ERROR'),
('application', 'prod', 'master', 'logging.level.org.springframework', 'ERROR'),
('application', 'prod', 'master', 'logging.level.org.springframework.cloud.gateway', 'ERROR')
AS new_row
ON DUPLICATE KEY UPDATE VALUE = new_row.VALUE;
