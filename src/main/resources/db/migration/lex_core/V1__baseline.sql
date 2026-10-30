-- Lex Vertex core baseline.
-- Business tables are added by phase migrations (F2, F3, F4, F5, F6).

CREATE TABLE IF NOT EXISTS schema_metadata (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    meta_key VARCHAR(100) NOT NULL,
    meta_value VARCHAR(500) NOT NULL,
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_schema_metadata_key (meta_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO schema_metadata (meta_key, meta_value)
VALUES ('product', 'Lex Vertex'),
       ('schema', 'lex_core'),
       ('integrity_policy', 'FK_RESTRICT_NO_CASCADE_SOFT_DELETE')
ON DUPLICATE KEY UPDATE meta_value = VALUES(meta_value);
