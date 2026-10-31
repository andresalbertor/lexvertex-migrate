-- SSO password-change URL for gateway-service (dev/prod).
-- Used by SecurityConfig.forcedPasswordChangeFilter via app.sso.password-change-url.

DELETE FROM PROPERTIES
WHERE APPLICATION = 'gateway-service'
  AND LABEL = 'master'
  AND `KEY` = 'app.sso.password-change-url'
  AND PROFILE IN ('dev', 'prod');

INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE) VALUES
('gateway-service', 'dev', 'master', 'app.sso.password-change-url', 'http://localhost:8089/profile/security'),
('gateway-service', 'prod', 'master', 'app.sso.password-change-url', 'https://www.lexvertex.cloud/profile/security');
