-- Replace composite primary keys on join tables with a single auto-increment column.

ALTER TABLE role_permission
    DROP PRIMARY KEY,
    ADD COLUMN id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST,
    ADD UNIQUE KEY uk_role_permission (role_id, permission_id);

ALTER TABLE user_role
    DROP PRIMARY KEY,
    ADD COLUMN id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST,
    ADD UNIQUE KEY uk_user_role (user_id, role_id);
