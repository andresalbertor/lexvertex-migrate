-- Baseline DDL for schema lex_core (squashed from historical Flyway migrations).
-- Generated for empty-schema migrate. Do not edit casually; prefer new versioned migrations.
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `app_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_organization` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `legal_name` varchar(200) NOT NULL,
  `trade_name` varchar(200) DEFAULT NULL,
  `legal_person` tinyint(1) NOT NULL DEFAULT '1',
  `document_type` varchar(30) NOT NULL,
  `document_number` varchar(20) NOT NULL,
  `check_digit` varchar(10) DEFAULT NULL,
  `address_line1` varchar(200) DEFAULT NULL,
  `address_line2` varchar(200) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `department` varchar(120) DEFAULT NULL,
  `country` varchar(80) NOT NULL DEFAULT 'Colombia',
  `postal_code` varchar(20) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `website` varchar(254) DEFAULT NULL,
  `instagram` varchar(120) DEFAULT NULL,
  `linkedin` varchar(120) DEFAULT NULL,
  `facebook` varchar(120) DEFAULT NULL,
  `social_links` json DEFAULT NULL,
  `legal_representative_name` varchar(200) DEFAULT NULL,
  `legal_representative_document_type` varchar(20) DEFAULT NULL,
  `legal_representative_document` varchar(20) DEFAULT NULL,
  `print_header` varchar(500) DEFAULT NULL,
  `print_footer` varchar(500) DEFAULT NULL,
  `locale` varchar(10) NOT NULL DEFAULT 'es',
  `timezone` varchar(60) NOT NULL DEFAULT 'America/Bogota',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_app_organization_public_id` (`public_id`),
  KEY `idx_app_organization_legal_rep_doc_type` (`legal_representative_document_type`),
  CONSTRAINT `fk_app_organization_legal_rep_doc_type` FOREIGN KEY (`legal_representative_document_type`) REFERENCES `document_type` (`code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `app_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `person_id` bigint unsigned DEFAULT NULL,
  `position_code` varchar(40) DEFAULT NULL,
  `display_name` varchar(120) NOT NULL,
  `professional_card` varchar(50) DEFAULT NULL,
  `first_name` varchar(60) DEFAULT NULL,
  `second_name` varchar(60) DEFAULT NULL,
  `first_last_name` varchar(60) DEFAULT NULL,
  `second_last_name` varchar(60) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `locale` varchar(10) NOT NULL DEFAULT 'es',
  `login_email` varchar(254) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `status` varchar(3) NOT NULL DEFAULT 'PEN',
  `email_verified_at` datetime(6) DEFAULT NULL,
  `mfa_required` tinyint(1) NOT NULL DEFAULT '1',
  `mfa_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `failed_attempts` int NOT NULL DEFAULT '0',
  `locked_until` datetime(6) DEFAULT NULL,
  `lock_reason` varchar(200) DEFAULT NULL,
  `last_login_at` datetime(6) DEFAULT NULL,
  `password_changed_at` datetime(6) DEFAULT NULL,
  `must_change_password` tinyint(1) NOT NULL DEFAULT '0',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_app_user_public_id` (`public_id`),
  UNIQUE KEY `uk_app_user_login_email` (`login_email`),
  UNIQUE KEY `uk_app_user_person_id` (`person_id`),
  KEY `idx_app_user_status` (`status`),
  KEY `idx_app_user_position` (`position_code`),
  KEY `idx_app_user_person_id` (`person_id`),
  CONSTRAINT `fk_app_user_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_app_user_position` FOREIGN KEY (`position_code`) REFERENCES `position` (`code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `auth_identity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_identity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `provider` varchar(30) NOT NULL,
  `provider_subject` varchar(255) NOT NULL,
  `provider_email` varchar(254) DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `linked_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_auth_identity_provider_subject` (`provider`,`provider_subject`),
  UNIQUE KEY `uk_auth_identity_user_provider` (`user_id`,`provider`),
  CONSTRAINT `fk_auth_identity_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `auth_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_module` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `display_order` int NOT NULL DEFAULT '0',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_auth_module_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `auth_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `module_id` bigint unsigned NOT NULL,
  `subgroup_id` bigint unsigned DEFAULT NULL,
  `code` varchar(80) NOT NULL,
  `name` varchar(150) NOT NULL,
  `display_order` int NOT NULL DEFAULT '0',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_auth_resource_code` (`code`),
  KEY `fk_auth_resource_module` (`module_id`),
  KEY `fk_auth_resource_subgroup` (`subgroup_id`),
  CONSTRAINT `fk_auth_resource_module` FOREIGN KEY (`module_id`) REFERENCES `auth_module` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_auth_resource_subgroup` FOREIGN KEY (`subgroup_id`) REFERENCES `auth_subgroup` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `auth_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_session` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `family_id` char(36) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `issued_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `expires_at` datetime(6) NOT NULL,
  `revoked_at` datetime(6) DEFAULT NULL,
  `revoked_reason` varchar(100) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `last_used_at` datetime(6) DEFAULT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_auth_session_public_id` (`public_id`),
  UNIQUE KEY `uk_auth_session_token_hash` (`token_hash`),
  KEY `idx_auth_session_user` (`user_id`),
  KEY `idx_auth_session_family` (`family_id`),
  CONSTRAINT `fk_auth_session_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `auth_subgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_subgroup` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `module_id` bigint unsigned NOT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `code` varchar(80) NOT NULL,
  `name` varchar(150) NOT NULL,
  `display_order` int NOT NULL DEFAULT '0',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_auth_subgroup_code` (`code`),
  KEY `fk_auth_subgroup_module` (`module_id`),
  KEY `fk_auth_subgroup_parent` (`parent_id`),
  CONSTRAINT `fk_auth_subgroup_module` FOREIGN KEY (`module_id`) REFERENCES `auth_module` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_auth_subgroup_parent` FOREIGN KEY (`parent_id`) REFERENCES `auth_subgroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `department_state_id` bigint unsigned NOT NULL,
  `code` varchar(10) NOT NULL,
  `name` varchar(150) NOT NULL,
  `postal_code` varchar(12) DEFAULT NULL,
  `code_type` varchar(20) NOT NULL DEFAULT 'DIVIPOLA',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_city` (`department_state_id`,`code`),
  KEY `idx_city_department_name` (`department_state_id`,`name`),
  CONSTRAINT `fk_city_department` FOREIGN KEY (`department_state_id`) REFERENCES `department_state` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `client_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_change_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `entity_public_id` char(36) NOT NULL,
  `actor_user_id` bigint unsigned DEFAULT NULL,
  `actor_username` varchar(254) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(250) DEFAULT NULL,
  `message` varchar(250) NOT NULL,
  `changes_json` json NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_client_change_log_entity` (`entity_public_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `client_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_message` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `person_id` bigint unsigned NOT NULL,
  `channel` varchar(20) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `body` mediumtext NOT NULL,
  `sender_name` varchar(200) NOT NULL,
  `sender_email` varchar(250) NOT NULL,
  `recipient_email` varchar(250) NOT NULL,
  `sent_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_client_message_public_id` (`public_id`),
  KEY `idx_client_message_person_sent` (`person_id`,`sent_at`),
  CONSTRAINT `fk_client_message_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `client_message_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_message_file` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `message_id` bigint unsigned NOT NULL,
  `file_object_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_client_message_file_object` (`file_object_id`),
  KEY `idx_client_message_file_message` (`message_id`),
  CONSTRAINT `fk_client_message_file_message` FOREIGN KEY (`message_id`) REFERENCES `client_message` (`id`),
  CONSTRAINT `fk_client_message_file_object` FOREIGN KEY (`file_object_id`) REFERENCES `file_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `client_outbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_outbox` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `event_id` char(36) NOT NULL,
  `event_type` varchar(80) NOT NULL,
  `aggregate_id` varchar(64) NOT NULL,
  `payload` json NOT NULL,
  `occurred_at` datetime(6) NOT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `retry_count` int NOT NULL DEFAULT '0',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_client_outbox_event_id` (`event_id`),
  KEY `idx_client_outbox_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `competence_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competence_rule` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `specialty_id` bigint unsigned DEFAULT NULL,
  `process_type_id` bigint unsigned DEFAULT NULL,
  `amount_from_smlmv` decimal(12,2) DEFAULT NULL,
  `amount_to_smlmv` decimal(12,2) DEFAULT NULL,
  `include_from` tinyint(1) NOT NULL DEFAULT '0',
  `include_to` tinyint(1) NOT NULL DEFAULT '1',
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `condition_text` varchar(250) DEFAULT NULL,
  `organ_id` bigint unsigned DEFAULT NULL,
  `fallback_organ_id` bigint unsigned DEFAULT NULL,
  `result_mode` varchar(20) NOT NULL DEFAULT 'ASSIGN',
  `priority` int NOT NULL DEFAULT '100',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_competence_rule_specialty` (`specialty_id`,`is_active`,`priority`),
  KEY `idx_competence_rule_process` (`process_type_id`,`is_active`,`priority`),
  KEY `fk_competence_rule_organ` (`organ_id`),
  KEY `fk_competence_rule_fallback` (`fallback_organ_id`),
  CONSTRAINT `fk_competence_rule_fallback` FOREIGN KEY (`fallback_organ_id`) REFERENCES `judicial_organ` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_competence_rule_organ` FOREIGN KEY (`organ_id`) REFERENCES `judicial_organ` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_competence_rule_process` FOREIGN KEY (`process_type_id`) REFERENCES `process_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_competence_rule_specialty` FOREIGN KEY (`specialty_id`) REFERENCES `specialty` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `consent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consent` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint unsigned NOT NULL,
  `purpose` varchar(40) NOT NULL,
  `policy_version` varchar(20) NOT NULL,
  `granted_at` datetime(6) DEFAULT NULL,
  `revoked_at` datetime(6) DEFAULT NULL,
  `evidence` json DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_consent_person` (`person_id`),
  CONSTRAINT `fk_consent_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `consent_acceptance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consent_acceptance` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint unsigned NOT NULL,
  `document_version_id` bigint unsigned NOT NULL,
  `channel` varchar(30) NOT NULL,
  `accepted_at` datetime(6) NOT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `evidence` json DEFAULT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_consent_person_version` (`person_id`,`document_version_id`),
  KEY `idx_consent_acceptance_person` (`person_id`),
  KEY `idx_consent_acceptance_version` (`document_version_id`),
  CONSTRAINT `fk_consent_acceptance_version` FOREIGN KEY (`document_version_id`) REFERENCES `legal_document_version` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `consent_invite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consent_invite` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint unsigned NOT NULL,
  `organization_id` bigint unsigned NOT NULL,
  `token_hash` char(64) NOT NULL,
  `email_to` varchar(250) NOT NULL,
  `status` varchar(20) NOT NULL,
  `sent_at` datetime(6) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_consent_invite_token_hash` (`token_hash`),
  KEY `idx_consent_invite_person` (`person_id`),
  KEY `idx_consent_invite_status_expires` (`status`,`expires_at`),
  KEY `fk_consent_invite_org` (`organization_id`),
  CONSTRAINT `fk_consent_invite_org` FOREIGN KEY (`organization_id`) REFERENCES `app_organization` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `consent_invite_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consent_invite_item` (
  `invite_id` bigint unsigned NOT NULL,
  `document_version_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`invite_id`,`document_version_id`),
  KEY `fk_consent_invite_item_version` (`document_version_id`),
  CONSTRAINT `fk_consent_invite_item_invite` FOREIGN KEY (`invite_id`) REFERENCES `consent_invite` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_consent_invite_item_version` FOREIGN KEY (`document_version_id`) REFERENCES `legal_document_version` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `iso2` char(2) NOT NULL,
  `iso3` char(3) NOT NULL,
  `numeric_code` char(3) DEFAULT NULL,
  `name_es` varchar(120) NOT NULL,
  `name_en` varchar(120) NOT NULL,
  `phone_code` varchar(10) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`iso2`),
  UNIQUE KEY `uk_country_iso3` (`iso3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `department_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_state` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `country_iso2` char(2) NOT NULL,
  `code` varchar(10) NOT NULL,
  `name` varchar(120) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'DEPARTMENT',
  `code_type` varchar(20) NOT NULL DEFAULT 'DIVIPOLA',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_department_state` (`country_iso2`,`code_type`,`code`),
  KEY `idx_department_state_country` (`country_iso2`),
  CONSTRAINT `fk_department_state_country` FOREIGN KEY (`country_iso2`) REFERENCES `country` (`iso2`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `disability_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disability_category` (
  `code` char(2) NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `document_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_type` (
  `code` varchar(20) NOT NULL,
  `country_iso2` char(2) NOT NULL,
  `name` varchar(120) NOT NULL,
  `applies_to` varchar(20) NOT NULL DEFAULT 'PERSON',
  `regex` varchar(200) DEFAULT NULL,
  `min_length` int DEFAULT NULL,
  `max_length` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `idx_document_type_country` (`country_iso2`),
  CONSTRAINT `fk_document_type_country` FOREIGN KEY (`country_iso2`) REFERENCES `country` (`iso2`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `economic_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `economic_parameter` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `param_year` smallint NOT NULL,
  `value_cop` decimal(18,2) NOT NULL,
  `valid_from` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_economic_parameter_year` (`param_year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `file_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file_object` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `bucket` varchar(60) NOT NULL,
  `object_key` varchar(250) NOT NULL,
  `original_name` varchar(250) NOT NULL,
  `content_type` varchar(80) NOT NULL,
  `size_bytes` bigint NOT NULL,
  `sha256` char(64) NOT NULL,
  `status` varchar(20) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_file_object_public_id` (`public_id`),
  UNIQUE KEY `uk_file_object_key` (`object_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `identity_outbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `identity_outbox` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `event_id` char(36) NOT NULL,
  `event_type` varchar(80) NOT NULL,
  `event_version` int NOT NULL DEFAULT '1',
  `aggregate_id` varchar(64) NOT NULL,
  `payload` json NOT NULL,
  `occurred_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `published_at` datetime(6) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'PENDING',
  `retry_count` int NOT NULL DEFAULT '0',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_identity_outbox_event_id` (`event_id`),
  KEY `idx_identity_outbox_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `judicial_organ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `judicial_organ` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `name` varchar(120) NOT NULL,
  `organ_group` varchar(40) NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_judicial_organ_name` (`name`),
  KEY `idx_judicial_organ_group` (`organ_group`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `legal_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_document` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `mandatory` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_legal_document_org` (`organization_id`),
  KEY `idx_legal_document_org_active` (`organization_id`,`active`),
  CONSTRAINT `fk_legal_document_org` FOREIGN KEY (`organization_id`) REFERENCES `app_organization` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `legal_document_audience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_document_audience` (
  `document_id` bigint unsigned NOT NULL,
  `person_type` varchar(3) NOT NULL,
  PRIMARY KEY (`document_id`,`person_type`),
  CONSTRAINT `fk_legal_doc_audience_doc` FOREIGN KEY (`document_id`) REFERENCES `legal_document` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `legal_document_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_document_version` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `document_id` bigint unsigned NOT NULL,
  `version_label` varchar(40) NOT NULL,
  `content_type` varchar(20) NOT NULL,
  `body` longtext,
  `file_key` varchar(500) DEFAULT NULL,
  `content_sha256` char(64) NOT NULL,
  `published_at` datetime(6) NOT NULL,
  `is_current` tinyint(1) NOT NULL DEFAULT '0',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_legal_doc_version_label` (`document_id`,`version_label`),
  KEY `idx_legal_doc_version_current` (`document_id`,`is_current`),
  CONSTRAINT `fk_legal_doc_version_doc` FOREIGN KEY (`document_id`) REFERENCES `legal_document` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `matter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matter` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `title` varchar(250) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'ACTIVE',
  `process_type_id` bigint unsigned DEFAULT NULL,
  `offering_code` varchar(64) DEFAULT NULL,
  `amount` decimal(18,2) DEFAULT NULL,
  `amount_smlmv` decimal(12,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `city_code` varchar(20) DEFAULT NULL,
  `judicial_organ_id` bigint unsigned DEFAULT NULL,
  `specialty_label` varchar(40) DEFAULT NULL,
  `office_number` varchar(20) DEFAULT NULL,
  `competence_rule_id` bigint unsigned DEFAULT NULL,
  `court_office_code` varchar(12) DEFAULT NULL,
  `responsible_user_public_id` char(36) NOT NULL,
  `board_template_id` bigint unsigned DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_matter_public_id` (`public_id`),
  KEY `idx_matter_responsible` (`responsible_user_public_id`),
  KEY `fk_matter_board_template` (`board_template_id`),
  KEY `idx_matter_process_type` (`process_type_id`),
  KEY `idx_matter_status` (`status`),
  KEY `fk_matter_judicial_organ` (`judicial_organ_id`),
  KEY `fk_matter_competence_rule` (`competence_rule_id`),
  CONSTRAINT `fk_matter_board_template` FOREIGN KEY (`board_template_id`) REFERENCES `work_board_template` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_matter_competence_rule` FOREIGN KEY (`competence_rule_id`) REFERENCES `competence_rule` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_matter_judicial_organ` FOREIGN KEY (`judicial_organ_id`) REFERENCES `judicial_organ` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_matter_process_type` FOREIGN KEY (`process_type_id`) REFERENCES `process_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `matter_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matter_client` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `matter_id` bigint unsigned NOT NULL,
  `client_public_id` char(36) NOT NULL,
  `client_display_name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_matter_client` (`matter_id`,`client_public_id`),
  KEY `idx_matter_client_public` (`client_public_id`),
  CONSTRAINT `fk_matter_client_matter` FOREIGN KEY (`matter_id`) REFERENCES `matter` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `matter_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matter_document` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `matter_id` bigint unsigned NOT NULL,
  `work_item_id` bigint unsigned DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `content_type` varchar(120) DEFAULT NULL,
  `size_bytes` bigint unsigned DEFAULT NULL,
  `storage_key` varchar(500) NOT NULL,
  `uploaded_by_public_id` char(36) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_matter_document_matter` (`matter_id`),
  KEY `idx_matter_document_task` (`work_item_id`),
  CONSTRAINT `fk_matter_document_matter` FOREIGN KEY (`matter_id`) REFERENCES `matter` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_matter_document_task` FOREIGN KEY (`work_item_id`) REFERENCES `work_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `matter_phase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matter_phase` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `matter_id` bigint unsigned NOT NULL,
  `sort_order` int NOT NULL,
  `name` varchar(160) NOT NULL,
  `status` varchar(20) NOT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `source_template_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_matter_phase_public_id` (`public_id`),
  KEY `idx_matter_phase_matter` (`matter_id`,`sort_order`),
  KEY `fk_matter_phase_template` (`source_template_id`),
  CONSTRAINT `fk_matter_phase_matter` FOREIGN KEY (`matter_id`) REFERENCES `matter` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_matter_phase_template` FOREIGN KEY (`source_template_id`) REFERENCES `work_phase_template` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `matter_process_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matter_process_type` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `matter_id` bigint unsigned NOT NULL,
  `process_type_id` bigint unsigned NOT NULL,
  `is_principal` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_matter_process_type` (`matter_id`,`process_type_id`),
  KEY `idx_matter_process_type_matter` (`matter_id`,`sort_order`),
  KEY `idx_matter_process_type_principal` (`matter_id`,`is_principal`),
  KEY `fk_matter_process_type_process` (`process_type_id`),
  CONSTRAINT `fk_matter_process_type_matter` FOREIGN KEY (`matter_id`) REFERENCES `matter` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_matter_process_type_process` FOREIGN KEY (`process_type_id`) REFERENCES `process_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mfa_factor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mfa_factor` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'TOTP',
  `secret_cipher` varbinary(512) NOT NULL,
  `confirmed_at` datetime(6) DEFAULT NULL,
  `last_used_at` datetime(6) DEFAULT NULL,
  `last_used_counter` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `version` int NOT NULL DEFAULT '0',
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_mfa_factor_user_type` (`user_id`,`type`),
  CONSTRAINT `fk_mfa_factor_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mfa_recovery_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mfa_recovery_code` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `code_hash` varchar(255) NOT NULL,
  `used_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `version` int NOT NULL DEFAULT '0',
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mfa_recovery_user` (`user_id`),
  CONSTRAINT `fk_mfa_recovery_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `organization_board_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_board_column` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `organization_id` bigint unsigned NOT NULL,
  `sort_order` int NOT NULL,
  `name` varchar(80) NOT NULL,
  `is_initial` tinyint(1) NOT NULL DEFAULT '0',
  `is_closing` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_org_board_column` (`organization_id`,`name`),
  KEY `idx_org_board_column_order` (`organization_id`,`sort_order`),
  CONSTRAINT `fk_org_board_column_org` FOREIGN KEY (`organization_id`) REFERENCES `app_organization` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `organization_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_contact` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint unsigned NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `document_type` varchar(30) NOT NULL,
  `document_number` varchar(60) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int NOT NULL DEFAULT '0',
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_organization_contact_organization` (`organization_id`),
  CONSTRAINT `fk_organization_contact_organization` FOREIGN KEY (`organization_id`) REFERENCES `app_organization` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `organization_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_email_template` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `organization_id` bigint unsigned NOT NULL,
  `code` varchar(64) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `is_custom_html` tinyint(1) NOT NULL DEFAULT '0',
  `s3_key` varchar(500) DEFAULT NULL,
  `config_json` json DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_org_email_template_public_id` (`public_id`),
  UNIQUE KEY `uk_org_email_template_code` (`organization_id`,`code`),
  KEY `idx_org_email_template_org` (`organization_id`),
  CONSTRAINT `fk_org_email_template_org` FOREIGN KEY (`organization_id`) REFERENCES `app_organization` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `organization_legal_representative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_legal_representative` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `organization_person_id` bigint unsigned NOT NULL,
  `person_id` bigint unsigned NOT NULL,
  `title` varchar(120) DEFAULT NULL,
  `faculties` varchar(500) DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `appointed_at` date DEFAULT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `primary_org_key` bigint unsigned GENERATED ALWAYS AS (if(`is_primary`,`organization_person_id`,NULL)) STORED,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_org_legal_rep` (`organization_person_id`,`person_id`),
  UNIQUE KEY `uk_org_legal_rep_one_primary` (`primary_org_key`),
  KEY `fk_org_legal_rep_person` (`person_id`),
  CONSTRAINT `fk_org_legal_rep_org` FOREIGN KEY (`organization_person_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_org_legal_rep_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `organization_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_setting` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `organization_id` bigint unsigned NOT NULL,
  `category` varchar(40) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `value_type` varchar(20) NOT NULL,
  `setting_value` json NOT NULL,
  `default_value` json NOT NULL,
  `is_editable` tinyint(1) NOT NULL DEFAULT '1',
  `is_system` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_org_setting_public_id` (`public_id`),
  UNIQUE KEY `uk_org_setting_key` (`organization_id`,`setting_key`),
  KEY `idx_org_setting_category` (`organization_id`,`category`),
  CONSTRAINT `fk_org_setting_org` FOREIGN KEY (`organization_id`) REFERENCES `app_organization` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(80) NOT NULL,
  `description` varchar(200) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `resource_id` bigint unsigned DEFAULT NULL,
  `action` varchar(40) DEFAULT NULL,
  `action_type` varchar(20) NOT NULL DEFAULT 'CRUD',
  `label` varchar(100) DEFAULT NULL,
  `tooltip` varchar(255) DEFAULT NULL,
  `display_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_permission_code` (`code`),
  KEY `idx_permission_resource_action` (`resource_id`,`action`),
  CONSTRAINT `fk_permission_resource` FOREIGN KEY (`resource_id`) REFERENCES `auth_resource` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `type` varchar(3) NOT NULL,
  `document_type` varchar(30) NOT NULL,
  `person_type` varchar(20) NOT NULL,
  `document_number` varchar(25) NOT NULL,
  `check_digit` varchar(2) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `first_name` varchar(80) DEFAULT NULL,
  `second_name` varchar(80) DEFAULT NULL,
  `first_last_name` varchar(80) DEFAULT NULL,
  `second_last_name` varchar(80) DEFAULT NULL,
  `legal_name` varchar(250) DEFAULT NULL,
  `commercial_name` varchar(250) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `disability_category_code` varchar(30) DEFAULT NULL,
  `email_primary` varchar(250) NOT NULL,
  `email_secondary` varchar(250) DEFAULT NULL,
  `phone_primary` varchar(15) NOT NULL,
  `phone_secondary` varchar(15) DEFAULT NULL,
  `address_line1` varchar(200) DEFAULT NULL,
  `address_line2` varchar(200) DEFAULT NULL,
  `address_city_id` bigint unsigned DEFAULT NULL,
  `address_postal_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_person_public_id` (`public_id`),
  UNIQUE KEY `uk_person_type_document` (`type`,`document_type`,`document_number`),
  KEY `idx_person_active` (`is_active`),
  KEY `idx_person_document` (`document_type`,`document_number`),
  KEY `fk_person_address_city` (`address_city_id`),
  CONSTRAINT `fk_person_address_city` FOREIGN KEY (`address_city_id`) REFERENCES `city` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `person_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_client` (
  `id` bigint unsigned NOT NULL,
  `status` varchar(3) NOT NULL,
  `assigned_lawyer_user_id` bigint unsigned DEFAULT NULL,
  `source` varchar(40) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_person_client_person` FOREIGN KEY (`id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `person_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_contact` (
  `id` bigint unsigned NOT NULL,
  `organization_person_id` bigint unsigned NOT NULL,
  `is_primary_contact` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(120) DEFAULT NULL,
  `status` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_person_contact_org` (`organization_person_id`),
  CONSTRAINT `fk_person_contact_org` FOREIGN KEY (`organization_person_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_person_contact_person` FOREIGN KEY (`id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `person_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_file` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint unsigned NOT NULL,
  `file_object_id` bigint unsigned NOT NULL,
  `purpose` varchar(30) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_person_file_object` (`file_object_id`),
  KEY `idx_person_file_person` (`person_id`,`purpose`),
  CONSTRAINT `fk_person_file_object` FOREIGN KEY (`file_object_id`) REFERENCES `file_object` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_person_file_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `person_nationality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_nationality` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `person_id` bigint unsigned NOT NULL,
  `country` char(2) NOT NULL,
  `primary_nationality` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_person_nationality` (`person_id`,`country`),
  KEY `fk_person_nationality_country` (`country`),
  CONSTRAINT `fk_person_nationality_country` FOREIGN KEY (`country`) REFERENCES `country` (`iso2`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_person_nationality_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `person_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_organization` (
  `id` bigint unsigned NOT NULL,
  `status` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_person_organization_person` FOREIGN KEY (`id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `person_social`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_social` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint unsigned NOT NULL,
  `platform` varchar(30) NOT NULL,
  `handle` varchar(120) NOT NULL,
  `url` varchar(300) DEFAULT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_person_social` (`person_id`,`platform`,`handle`),
  CONSTRAINT `fk_person_social_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `person_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_user` (
  `id` bigint unsigned NOT NULL,
  `login_email` varchar(250) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `status` varchar(3) NOT NULL,
  `email_verified_at` datetime(6) DEFAULT NULL,
  `mfa_required` tinyint(1) NOT NULL DEFAULT '1',
  `mfa_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `failed_attempts` int NOT NULL DEFAULT '0',
  `locked_until` datetime(6) DEFAULT NULL,
  `lock_reason` varchar(200) DEFAULT NULL,
  `last_login_at` datetime(6) DEFAULT NULL,
  `password_changed_at` datetime(6) DEFAULT NULL,
  `must_change_password` tinyint(1) NOT NULL DEFAULT '0',
  `locale` varchar(10) NOT NULL DEFAULT 'es-CO',
  `professional_card` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_person_user_login_email` (`login_email`),
  CONSTRAINT `fk_person_user_person` FOREIGN KEY (`id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `position` (
  `code` varchar(40) NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `process_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `process_requirement` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `process_type_id` bigint unsigned DEFAULT NULL,
  `requirement_text` varchar(300) NOT NULL,
  `when_applies` varchar(250) NOT NULL,
  `if_missing` varchar(10) NOT NULL DEFAULT 'BLOCK',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_process_requirement_type` (`process_type_id`,`is_active`),
  CONSTRAINT `fk_process_requirement_type` FOREIGN KEY (`process_type_id`) REFERENCES `process_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `process_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `process_term` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `process_type_id` bigint unsigned NOT NULL,
  `term_kind` varchar(30) NOT NULL,
  `duration_value` int DEFAULT NULL,
  `duration_unit` varchar(10) DEFAULT NULL,
  `computation_mode` varchar(20) DEFAULT NULL,
  `value_state` varchar(20) NOT NULL DEFAULT 'FIXED',
  `starts_when` varchar(250) NOT NULL,
  `purpose_text` varchar(250) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_process_term_type` (`process_type_id`,`is_active`),
  CONSTRAINT `fk_process_term_type` FOREIGN KEY (`process_type_id`) REFERENCES `process_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `process_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `process_type` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `deleted_at` datetime(6) DEFAULT NULL,
  `deleted_by` bigint unsigned DEFAULT NULL,
  `specialty_id` bigint unsigned NOT NULL,
  `code` varchar(4) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `amount_mode` varchar(20) NOT NULL DEFAULT 'NO_AMOUNT',
  `via_kind` varchar(20) NOT NULL DEFAULT 'PROCESO_JUDICIAL',
  `regime` varchar(30) NOT NULL DEFAULT 'SINGLE',
  `procedure_summary` varchar(500) DEFAULT NULL,
  `task_list_template_id` bigint unsigned DEFAULT NULL,
  `jurisdiction` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_process_type_code` (`code`),
  KEY `idx_process_type_specialty` (`specialty_id`,`is_active`),
  KEY `fk_process_type_task_template` (`task_list_template_id`),
  KEY `idx_process_type_via_kind` (`via_kind`,`is_active`),
  CONSTRAINT `fk_process_type_specialty` FOREIGN KEY (`specialty_id`) REFERENCES `specialty` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_process_type_task_template` FOREIGN KEY (`task_list_template_id`) REFERENCES `task_list_template` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` char(4) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT '1',
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned NOT NULL,
  `permission_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_permission` (`role_id`,`permission_id`),
  KEY `fk_role_permission_permission` (`permission_id`),
  CONSTRAINT `fk_role_permission_permission` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_role_permission_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `schema_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_metadata` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `meta_key` varchar(100) NOT NULL,
  `meta_value` varchar(500) NOT NULL,
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_schema_metadata_key` (`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `specialty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialty` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `deleted_at` datetime(6) DEFAULT NULL,
  `code` varchar(4) NOT NULL,
  `name` varchar(80) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_specialty_code` (`code`),
  UNIQUE KEY `uk_specialty_name` (`name`),
  KEY `idx_specialty_active_order` (`is_active`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `task_list_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_list_template` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `name` varchar(160) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_task_list_template_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `task_list_template_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_list_template_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `template_id` bigint unsigned NOT NULL,
  `sort_order` int NOT NULL,
  `title` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_task_list_template_item` (`template_id`,`sort_order`),
  CONSTRAINT `fk_task_list_item_template` FOREIGN KEY (`template_id`) REFERENCES `task_list_template` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `task_list_template_item_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_list_template_item_checklist` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `template_item_id` bigint unsigned NOT NULL,
  `sort_order` int NOT NULL,
  `text` varchar(250) NOT NULL,
  `is_perform` tinyint(1) NOT NULL DEFAULT '0',
  `is_validate` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tlti_checklist` (`template_item_id`,`sort_order`),
  CONSTRAINT `fk_tlti_checklist_item` FOREIGN KEY (`template_item_id`) REFERENCES `task_list_template_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `app_organization_logo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_organization_logo` (
  `organization_id` bigint unsigned NOT NULL,
  `content_type` varchar(80) DEFAULT NULL,
  `data` mediumblob NOT NULL,
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`organization_id`),
  CONSTRAINT `fk_app_organization_logo_org` FOREIGN KEY (`organization_id`) REFERENCES `app_organization` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_avatar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_avatar` (
  `user_id` bigint unsigned NOT NULL,
  `content_type` varchar(80) NOT NULL,
  `data` mediumblob NOT NULL,
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_avatar_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_position` (
  `user_id` bigint unsigned NOT NULL,
  `position_code` varchar(40) NOT NULL,
  PRIMARY KEY (`user_id`,`position_code`),
  KEY `fk_user_position_position` (`position_code`),
  CONSTRAINT `fk_user_position_position` FOREIGN KEY (`position_code`) REFERENCES `position` (`code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_position_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  `assigned_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `assigned_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_role` (`user_id`,`role_id`),
  KEY `fk_user_role_role` (`role_id`),
  KEY `fk_user_role_assigned_by` (`assigned_by`),
  CONSTRAINT `fk_user_role_assigned_by` FOREIGN KEY (`assigned_by`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_role_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_security_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_security_question` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `question_code` varchar(60) NOT NULL,
  `question_text` varchar(200) NOT NULL,
  `answer_hash` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int NOT NULL DEFAULT '0',
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_security_question` (`user_id`,`question_code`),
  CONSTRAINT `fk_user_security_question_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `verification_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_token` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `type` varchar(30) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `used_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned DEFAULT NULL,
  `version` int NOT NULL DEFAULT '0',
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_verification_token_public_id` (`public_id`),
  UNIQUE KEY `uk_verification_token_hash` (`token_hash`),
  KEY `idx_verification_token_user_type` (`user_id`,`type`),
  KEY `fk_verification_token_created_by` (`created_by`),
  CONSTRAINT `fk_verification_token_created_by` FOREIGN KEY (`created_by`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_verification_token_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `work_board_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_board_template` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `code` varchar(64) NOT NULL,
  `name` varchar(160) NOT NULL,
  `offering_code` varchar(64) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_work_board_template_public_id` (`public_id`),
  UNIQUE KEY `uk_work_board_template_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `work_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `matter_id` bigint unsigned NOT NULL,
  `matter_phase_id` bigint unsigned DEFAULT NULL,
  `board_column_id` bigint unsigned DEFAULT NULL,
  `process_type_id` bigint unsigned DEFAULT NULL,
  `title` varchar(250) NOT NULL,
  `description` text,
  `task_type` varchar(40) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  `lifecycle` varchar(20) NOT NULL DEFAULT 'ACTIVE',
  `assignee_user_public_id` char(36) DEFAULT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `due_at` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `sort_order` int NOT NULL,
  `notes` text,
  `source_template_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_work_item_public_id` (`public_id`),
  KEY `idx_work_item_matter` (`matter_id`),
  KEY `idx_work_item_phase` (`matter_phase_id`,`sort_order`),
  KEY `idx_work_item_assignee` (`assignee_user_public_id`),
  KEY `fk_work_item_template` (`source_template_id`),
  KEY `idx_work_item_board_column` (`board_column_id`),
  KEY `idx_work_item_lifecycle` (`lifecycle`),
  KEY `idx_work_item_process_type` (`process_type_id`),
  CONSTRAINT `fk_work_item_board_column` FOREIGN KEY (`board_column_id`) REFERENCES `organization_board_column` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_work_item_matter` FOREIGN KEY (`matter_id`) REFERENCES `matter` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_work_item_phase` FOREIGN KEY (`matter_phase_id`) REFERENCES `matter_phase` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_work_item_process_type` FOREIGN KEY (`process_type_id`) REFERENCES `process_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_work_item_template` FOREIGN KEY (`source_template_id`) REFERENCES `work_task_template` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `work_item_checklist_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_item_checklist_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `work_item_id` bigint unsigned NOT NULL,
  `sort_order` int NOT NULL,
  `text` varchar(250) NOT NULL,
  `done` tinyint(1) NOT NULL DEFAULT '0',
  `is_perform` tinyint(1) NOT NULL DEFAULT '0',
  `is_validate` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_work_item_checklist` (`work_item_id`,`sort_order`),
  CONSTRAINT `fk_work_item_checklist_item` FOREIGN KEY (`work_item_id`) REFERENCES `work_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `work_item_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_item_comment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `work_item_id` bigint unsigned NOT NULL,
  `author_user_public_id` char(36) NOT NULL,
  `author_display_name` varchar(160) NOT NULL,
  `commented_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `body` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_work_item_comment` (`work_item_id`,`commented_at`),
  CONSTRAINT `fk_work_item_comment_item` FOREIGN KEY (`work_item_id`) REFERENCES `work_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `work_phase_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_phase_template` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `board_template_id` bigint unsigned NOT NULL,
  `sort_order` int NOT NULL,
  `name` varchar(160) NOT NULL,
  `code` varchar(64) DEFAULT NULL,
  `is_terminal` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_work_phase_template_board` (`board_template_id`,`sort_order`),
  CONSTRAINT `fk_work_phase_template_board` FOREIGN KEY (`board_template_id`) REFERENCES `work_board_template` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `work_task_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_task_template` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_by` bigint unsigned NOT NULL DEFAULT '0',
  `updated_by` bigint unsigned NOT NULL DEFAULT '0',
  `phase_template_id` bigint unsigned NOT NULL,
  `sort_order` int NOT NULL,
  `title` varchar(250) NOT NULL,
  `task_type` varchar(40) NOT NULL,
  `default_assignee_role` varchar(20) NOT NULL,
  `suggested_duration_days` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_work_task_template_phase` (`phase_template_id`,`sort_order`),
  CONSTRAINT `fk_work_task_template_phase` FOREIGN KEY (`phase_template_id`) REFERENCES `work_phase_template` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
