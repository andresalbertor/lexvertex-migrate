-- Move user avatars to a dedicated table to avoid loading blobs in user lists.

CREATE TABLE IF NOT EXISTS user_avatar (
    user_id BIGINT UNSIGNED NOT NULL,
    content_type VARCHAR(80) NOT NULL,
    data MEDIUMBLOB NOT NULL,
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (user_id),
    CONSTRAINT fk_user_avatar_user FOREIGN KEY (user_id) REFERENCES app_user (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE app_user
    DROP COLUMN avatar_content_type,
    DROP COLUMN avatar_data,
    DROP COLUMN avatar_updated_at;
