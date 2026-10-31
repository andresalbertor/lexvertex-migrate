-- V1 (lex_config): tabla JDBC para Spring Cloud Config Server.
-- Column KEY requires MySQL backticks in queries.
-- Runtime: config-server user lex_config_app (SELECT only).

CREATE TABLE IF NOT EXISTS PROPERTIES (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    APPLICATION VARCHAR(100) NOT NULL,
    PROFILE VARCHAR(100) NOT NULL,
    LABEL VARCHAR(100) NOT NULL,
    `KEY` VARCHAR(200) NOT NULL,
    `VALUE` TEXT NULL,
    PRIMARY KEY (ID),
    UNIQUE KEY uk_properties (APPLICATION, PROFILE, LABEL, `KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
