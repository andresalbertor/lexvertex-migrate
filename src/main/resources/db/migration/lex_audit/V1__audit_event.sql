-- Baseline DDL for schema lex_audit (MS audit via Rabbit).

CREATE TABLE IF NOT EXISTS audit_event (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    event_type VARCHAR(60) NOT NULL,
    actor_user_id BIGINT UNSIGNED NULL,
    subject_email VARCHAR(254) NULL,
    outcome VARCHAR(20) NOT NULL,
    ip VARCHAR(45) NULL,
    details VARCHAR(500) NULL,
    version INT NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    created_by BIGINT UNSIGNED NOT NULL DEFAULT 0,
    updated_by BIGINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    KEY idx_audit_event_type_created (event_type, created_at),
    KEY idx_audit_event_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
