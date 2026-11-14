-- Default administrator for cold start (local / PDN).
-- Login: admin@example.test / StrongPass123!
-- Identity DataInitializer reconciles password from ADMIN_EMAIL/ADMIN_PASSWORD (Vault)
-- when ADMIN_EMAIL matches this login_email; keep them aligned in env.

SET @OLD_SQL_MODE=@@SQL_MODE;
SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- Person placeholder (USR / SD), stable document for idempotency.
INSERT INTO person (
    id, public_id, type, document_type, person_type, document_number,
    is_active, first_name, first_last_name, legal_name,
    email_primary, phone_primary, version, created_by, updated_by
) VALUES (
    1,
    '11111111-1111-1111-1111-111111111111',
    'USR',
    'SD',
    'NATURAL',
    'BOOTSTRAP-ADMIN',
    1,
    'Administrador',
    'ADMINISTRADOR',
    'Administrador ADMINISTRADOR',
    'admin@example.test',
    '0000000000',
    0,
    0,
    0
) AS new_row
ON DUPLICATE KEY UPDATE
    email_primary = new_row.email_primary,
    first_name = new_row.first_name,
    is_active = 1;

INSERT INTO person_user (
    id, login_email, password_hash, status,
    mfa_required, mfa_enabled, failed_attempts, must_change_password, locale
) VALUES (
    1,
    'admin@example.test',
    '$argon2id$v=19$m=16384,t=2,p=1$NovhT7FSB7NxG3+vvvWV0A$N0a1sjAar0L3HIT4OerWhCbTLaXTtZRaGChnTinT05Y',
    'ACT',
    0,
    0,
    0,
    0,
    'es-CO'
) AS new_pu
ON DUPLICATE KEY UPDATE
    login_email = new_pu.login_email,
    password_hash = new_pu.password_hash,
    status = 'ACT',
    mfa_required = 0,
    mfa_enabled = 0;

-- App login user (id=1). Password hash = Argon2id(StrongPass123!) via Spring defaultsForSpringSecurity_v5_8.
INSERT INTO app_user (
    id, public_id, person_id, position_code, display_name, first_name,
    is_active, locale, login_email, password_hash, status,
    email_verified_at, mfa_required, mfa_enabled, failed_attempts,
    must_change_password, password_changed_at, version, created_by, updated_by
) VALUES (
    1,
    '22222222-2222-2222-2222-222222222222',
    1,
    'ADMINISTRADOR',
    'Administrador',
    'Administrador',
    1,
    'es',
    'admin@example.test',
    '$argon2id$v=19$m=16384,t=2,p=1$NovhT7FSB7NxG3+vvvWV0A$N0a1sjAar0L3HIT4OerWhCbTLaXTtZRaGChnTinT05Y',
    'ACT',
    CURRENT_TIMESTAMP(6),
    0,
    0,
    0,
    0,
    CURRENT_TIMESTAMP(6),
    0,
    0,
    0
) AS new_admin
ON DUPLICATE KEY UPDATE
    person_id = new_admin.person_id,
    position_code = new_admin.position_code,
    display_name = new_admin.display_name,
    login_email = new_admin.login_email,
    password_hash = new_admin.password_hash,
    status = 'ACT',
    is_active = 1,
    mfa_required = 0,
    mfa_enabled = 0,
    must_change_password = 0,
    email_verified_at = COALESCE(app_user.email_verified_at, CURRENT_TIMESTAMP(6));

INSERT INTO user_role (user_id, role_id, assigned_by)
SELECT 1, r.id, 0
FROM role r
WHERE r.code = 'ADMN'
  AND NOT EXISTS (
      SELECT 1 FROM user_role ur WHERE ur.user_id = 1 AND ur.role_id = r.id
  );

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET SQL_MODE=@OLD_SQL_MODE;
