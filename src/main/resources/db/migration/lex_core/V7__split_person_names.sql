-- Split person names for users.

ALTER TABLE app_user
    ADD COLUMN first_name VARCHAR(80) NULL AFTER display_name,
    ADD COLUMN second_name VARCHAR(80) NULL AFTER first_name,
    ADD COLUMN first_last_name VARCHAR(80) NULL AFTER second_name,
    ADD COLUMN second_last_name VARCHAR(80) NULL AFTER first_last_name;

UPDATE app_user
SET first_name = SUBSTRING_INDEX(TRIM(display_name), ' ', 1)
WHERE first_name IS NULL;

UPDATE app_user
SET first_last_name = SUBSTRING_INDEX(TRIM(display_name), ' ', -1)
WHERE first_last_name IS NULL AND TRIM(display_name) LIKE '% %';
