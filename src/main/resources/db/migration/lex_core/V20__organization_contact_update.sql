ALTER TABLE app_organization 
ADD COLUMN postal_code VARCHAR(20) NULL AFTER country,
ADD COLUMN social_links JSON NULL AFTER facebook;
