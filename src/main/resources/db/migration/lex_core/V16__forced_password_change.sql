ALTER TABLE app_user
    ADD COLUMN must_change_password BOOLEAN NOT NULL DEFAULT FALSE AFTER password_changed_at;

UPDATE app_user
SET must_change_password = TRUE
WHERE status = 'PENDING' OR password_hash IS NULL;
