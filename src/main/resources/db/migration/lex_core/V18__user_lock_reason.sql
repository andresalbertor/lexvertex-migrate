ALTER TABLE app_user
    ADD COLUMN lock_reason VARCHAR(200) NULL AFTER locked_until;
