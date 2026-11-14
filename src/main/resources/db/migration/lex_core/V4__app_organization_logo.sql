-- Move organization logo BLOB out of app_organization into dedicated 1:1 table
-- (same pattern as user_avatar). Required by OrganizationLogo entity.

CREATE TABLE IF NOT EXISTS app_organization_logo (
    organization_id BIGINT UNSIGNED NOT NULL,
    content_type VARCHAR(80) NULL,
    data MEDIUMBLOB NOT NULL,
    version INT NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    PRIMARY KEY (organization_id),
    CONSTRAINT fk_app_organization_logo_org
        FOREIGN KEY (organization_id) REFERENCES app_organization (id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Migrate legacy inline logo columns when present and non-empty.
SET @has_logo_data := (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'app_organization'
      AND COLUMN_NAME = 'logo_data'
);

SET @sql := IF(
    @has_logo_data > 0,
    'INSERT INTO app_organization_logo (organization_id, content_type, data, version, created_at, updated_at, created_by, updated_by)
     SELECT o.id, o.logo_content_type, o.logo_data, COALESCE(o.version, 0),
            COALESCE(o.created_at, CURRENT_TIMESTAMP(6)),
            COALESCE(o.logo_updated_at, o.updated_at, CURRENT_TIMESTAMP(6)),
            o.created_by, o.updated_by
     FROM app_organization o
     WHERE o.logo_data IS NOT NULL
       AND NOT EXISTS (
           SELECT 1 FROM app_organization_logo l WHERE l.organization_id = o.id
       )',
    'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql := IF(
    @has_logo_data > 0,
    'ALTER TABLE app_organization
        DROP COLUMN logo_content_type,
        DROP COLUMN logo_data,
        DROP COLUMN logo_updated_at',
    'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
