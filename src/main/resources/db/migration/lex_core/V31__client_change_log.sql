-- V31: bitácora de cambios de la ficha de cliente (diff de campos).

CREATE TABLE IF NOT EXISTS client_change_log (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    entity_public_id CHAR(36) NOT NULL,
    actor_user_id BIGINT UNSIGNED NULL,
    actor_username VARCHAR(254) NULL,
    ip VARCHAR(45) NULL,
    user_agent VARCHAR(250) NULL,
    message VARCHAR(250) NOT NULL,
    changes_json JSON NOT NULL,
    version INT NOT NULL DEFAULT 0,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    PRIMARY KEY (id),
    KEY idx_client_change_log_entity (entity_public_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
