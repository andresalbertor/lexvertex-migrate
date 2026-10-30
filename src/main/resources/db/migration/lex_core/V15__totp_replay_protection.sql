ALTER TABLE mfa_factor
    ADD COLUMN last_used_counter BIGINT NULL AFTER last_used_at;
