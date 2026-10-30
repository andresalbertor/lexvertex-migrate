-- Pending email change confirmation.

ALTER TABLE app_user
    ADD COLUMN pending_email VARCHAR(254) NULL AFTER login_email;
