-- Baseline DDL for schema vigilis (squashed from sql/migrations 001-006).
-- Cold-start PDN: Flyway clean + migrate. Do not edit casually; prefer new versioned migrations.

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
DROP TABLE IF EXISTS `actuaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actuaciones` (
  `id_reg_actuacion` bigint NOT NULL,
  `id_proceso` bigint NOT NULL,
  `llave_proceso` varchar(64) NOT NULL,
  `cons_actuacion` int DEFAULT NULL,
  `fecha_actuacion` varchar(40) NOT NULL,
  `actuacion` varchar(512) NOT NULL,
  `anotacion` text,
  `fecha_inicial` varchar(40) DEFAULT NULL,
  `fecha_final` varchar(40) DEFAULT NULL,
  `fecha_registro` varchar(40) DEFAULT NULL,
  `con_documentos` tinyint(1) DEFAULT '0',
  `cant` int DEFAULT '0',
  `es_novedad` tinyint(1) DEFAULT '1',
  `fecha_notificado_email` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `updated_at` datetime(3) NOT NULL,
  `updated_by` varchar(64) NOT NULL,
  `tipo_notificacion` varchar(64) DEFAULT NULL,
  `numero_notificacion` varchar(64) DEFAULT NULL,
  `enlace_origen` text,
  `enlace_auto` text,
  `id_criterio` int DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id_reg_actuacion`),
  KEY `idx_actuaciones_proceso` (`id_proceso`),
  KEY `idx_actuaciones_novedad` (`es_novedad`),
  KEY `idx_actuaciones_fecha` (`fecha_actuacion`),
  KEY `idx_actuaciones_activo` (`activo`),
  KEY `idx_actuaciones_tipo_notif` (`tipo_notificacion`),
  KEY `idx_actuaciones_numero_notif` (`numero_notificacion`),
  CONSTRAINT `fk_actuaciones_proceso` FOREIGN KEY (`id_proceso`) REFERENCES `procesos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `app_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_config` (
  `key` varchar(191) NOT NULL,
  `value` json NOT NULL,
  `updated_at` datetime(3) NOT NULL,
  `updated_by` varchar(64) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `catalogo_ciudades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_ciudades` (
  `codigo` varchar(16) NOT NULL,
  `cod_departamento` varchar(16) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `updated_at` datetime(3) NOT NULL,
  `updated_by` varchar(64) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idx_ciudades_depto` (`cod_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `catalogo_departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_departamentos` (
  `codigo` varchar(16) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `updated_at` datetime(3) NOT NULL,
  `updated_by` varchar(64) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `catalogo_filtros_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_filtros_cache` (
  `tipo` varchar(64) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `payload_json` json NOT NULL,
  `updated_at` datetime(3) NOT NULL,
  `updated_by` varchar(64) NOT NULL,
  PRIMARY KEY (`tipo`,`clave`),
  KEY `idx_filtros_cache_tipo` (`tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `clases_proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clases_proceso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_clases_proceso_nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `criterios_monitoreo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `criterios_monitoreo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(64) NOT NULL,
  `valor` varchar(512) NOT NULL,
  `tipo_persona` varchar(8) DEFAULT 'N',
  `solo_activos` tinyint(1) DEFAULT '0',
  `cod_despacho` varchar(64) DEFAULT '',
  `filtro_despacho_nombre` varchar(512) DEFAULT '',
  `email_destinatario` varchar(320) DEFAULT '',
  `nombre_destinatario` varchar(255) DEFAULT '',
  `tratamiento_destinatario` varchar(64) DEFAULT '',
  `cc_destinatario` varchar(1024) DEFAULT '',
  `activo` tinyint(1) DEFAULT '1',
  `ultimo_check` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL,
  `fuente` varchar(32) NOT NULL DEFAULT 'RAMA',
  `filtros_json` json DEFAULT NULL,
  `updated_at` datetime(3) NOT NULL,
  `updated_by` varchar(64) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_criterios_monitoreo_fuente_valor` (`fuente`,`valor`),
  KEY `idx_criterios_monitoreo_fuente` (`fuente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `directorio_contactos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `directorio_contactos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tratamiento` varchar(64) DEFAULT '',
  `nombre` varchar(255) DEFAULT '',
  `email_para` varchar(320) NOT NULL,
  `email_cc` varchar(1024) DEFAULT '',
  `fuente` varchar(64) DEFAULT 'MANUAL',
  `created_at` datetime(3) NOT NULL,
  `updated_at` datetime(3) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `updated_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_directorio_email` (`email_para`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentos` (
  `id_reg_documento` bigint NOT NULL,
  `id_proceso` bigint NOT NULL,
  `id_reg_actuacion` bigint NOT NULL,
  `nombre_archivo` varchar(512) NOT NULL,
  `tipo` varchar(64) DEFAULT NULL,
  `ruta_local` varchar(1024) NOT NULL,
  `tamano_bytes` bigint DEFAULT NULL,
  `hash_sha256` varchar(64) DEFAULT NULL,
  `fecha_descarga` datetime(3) NOT NULL,
  PRIMARY KEY (`id_reg_documento`),
  KEY `idx_documentos_actuacion` (`id_reg_actuacion`),
  KEY `fk_documentos_proceso` (`id_proceso`),
  CONSTRAINT `fk_documentos_actuacion` FOREIGN KEY (`id_reg_actuacion`) REFERENCES `actuaciones` (`id_reg_actuacion`) ON DELETE CASCADE,
  CONSTRAINT `fk_documentos_proceso` FOREIGN KEY (`id_proceso`) REFERENCES `procesos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `notificaciones_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones_email` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_proceso` bigint NOT NULL,
  `id_reg_actuacion` bigint DEFAULT NULL,
  `llave_proceso` varchar(64) NOT NULL,
  `asunto` varchar(512) NOT NULL,
  `cuerpo_html` mediumtext NOT NULL,
  `destinatarios` text,
  `adjuntos_json` json DEFAULT NULL,
  `estado` varchar(32) DEFAULT 'PENDIENTE',
  `fecha_creacion` datetime(3) NOT NULL,
  `fecha_envio` datetime(3) DEFAULT NULL,
  `intentos_envio` int DEFAULT '0',
  `ultimo_error` text,
  `ultimo_error_codigo` varchar(32) DEFAULT '',
  `ultimo_error_detalle` text,
  `fecha_ultimo_intento` datetime(3) DEFAULT NULL,
  `fuente` varchar(32) NOT NULL DEFAULT 'RAMA',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `updated_at` datetime(3) NOT NULL,
  `updated_by` varchar(64) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_notif_actuacion` (`id_reg_actuacion`),
  KEY `idx_notif_estado` (`estado`),
  KEY `idx_notif_fuente` (`fuente`),
  KEY `idx_notif_activo` (`activo`),
  KEY `fk_notif_proceso` (`id_proceso`),
  CONSTRAINT `fk_notif_proceso` FOREIGN KEY (`id_proceso`) REFERENCES `procesos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ponentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ponentes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ponentes_nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `procesos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procesos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `public_id` char(36) NOT NULL,
  `fuente` varchar(32) NOT NULL DEFAULT 'RAMA',
  `id_externo` varchar(64) DEFAULT NULL,
  `llave_proceso` varchar(64) NOT NULL,
  `despacho` varchar(512) DEFAULT NULL,
  `ponente` varchar(255) DEFAULT NULL,
  `tipo_proceso` varchar(255) DEFAULT NULL,
  `clase_proceso` varchar(255) DEFAULT NULL,
  `subclase_proceso` varchar(255) DEFAULT NULL,
  `recurso` varchar(255) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `id_tipo_proceso` int DEFAULT NULL,
  `id_clase_proceso` int DEFAULT NULL,
  `id_subclase_proceso` int DEFAULT NULL,
  `id_ponente` int DEFAULT NULL,
  `fecha_proceso` varchar(40) DEFAULT NULL,
  `fecha_ultima_actuacion` varchar(40) DEFAULT NULL,
  `sujetos_procesales_raw` text,
  `es_privado` tinyint(1) DEFAULT '0',
  `cant_actuaciones` int DEFAULT '0',
  `created_at` datetime(3) NOT NULL,
  `updated_at` datetime(3) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `updated_by` varchar(64) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_procesos_id` (`id`),
  UNIQUE KEY `uq_procesos_public_id` (`public_id`),
  KEY `idx_procesos_llave` (`llave_proceso`),
  KEY `fk_procesos_tipo` (`id_tipo_proceso`),
  KEY `fk_procesos_clase` (`id_clase_proceso`),
  KEY `fk_procesos_subclase` (`id_subclase_proceso`),
  KEY `fk_procesos_ponente` (`id_ponente`),
  KEY `idx_procesos_activo` (`activo`),
  KEY `idx_procesos_fuente_llave_activo` (`fuente`,`llave_proceso`,`activo`),
  KEY `idx_procesos_id_externo` (`id_externo`),
  KEY `idx_procesos_fuente` (`fuente`),
  CONSTRAINT `fk_procesos_clase` FOREIGN KEY (`id_clase_proceso`) REFERENCES `clases_proceso` (`id`),
  CONSTRAINT `fk_procesos_ponente` FOREIGN KEY (`id_ponente`) REFERENCES `ponentes` (`id`),
  CONSTRAINT `fk_procesos_subclase` FOREIGN KEY (`id_subclase_proceso`) REFERENCES `subclases_proceso` (`id`),
  CONSTRAINT `fk_procesos_tipo` FOREIGN KEY (`id_tipo_proceso`) REFERENCES `tipos_proceso` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(64) NOT NULL,
  `applied_at` datetime(3) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `subclases_proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subclases_proceso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_subclases_proceso_nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `sujetos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sujetos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_proceso` bigint NOT NULL,
  `tipo_sujeto` varchar(128) DEFAULT NULL,
  `nombre` varchar(512) NOT NULL,
  `identificacion` varchar(64) DEFAULT NULL,
  `es_empresa` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_sujetos_proceso` (`id_proceso`),
  CONSTRAINT `fk_sujetos_proceso` FOREIGN KEY (`id_proceso`) REFERENCES `procesos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tipos_proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_proceso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tipos_proceso_nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `vigilancia_sic_criterios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vigilancia_sic_criterios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_criterio` varchar(32) NOT NULL,
  `valor` varchar(512) NOT NULL,
  `email_notificacion` varchar(320) DEFAULT '',
  `nombre_destinatario` varchar(255) DEFAULT '',
  `tratamiento_destinatario` varchar(64) DEFAULT '',
  `cc_destinatario` varchar(1024) DEFAULT '',
  `activo` tinyint(1) DEFAULT '1',
  `ultimo_check` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL,
  `updated_at` datetime(3) NOT NULL,
  `updated_by` varchar(64) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_vig_sic_criterio` (`tipo_criterio`,`valor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `vigilancia_sic_hallazgos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vigilancia_sic_hallazgos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_criterio` int NOT NULL,
  `fecha_generacion` varchar(40) NOT NULL,
  `fecha_publicacion` varchar(40) DEFAULT NULL,
  `enlace_archivo_original` text NOT NULL,
  `nombre_demandante` text,
  `nombre_demandado` text,
  `radicado` varchar(64) NOT NULL,
  `fecha_auto` varchar(40) DEFAULT NULL,
  `auto` varchar(512) DEFAULT '',
  `enlace_auto` text,
  `ruta_local_auto` varchar(1024) DEFAULT NULL,
  `tipo_boletin` varchar(64) NOT NULL,
  `numero_boletin` varchar(64) DEFAULT '',
  `clase_proceso` varchar(255) DEFAULT NULL,
  `tipo_traslado` varchar(255) DEFAULT NULL,
  `fecha_inicio_traslado` varchar(40) DEFAULT NULL,
  `fecha_vencimiento_traslado` varchar(40) DEFAULT NULL,
  `asunto_email` varchar(512) DEFAULT '',
  `cuerpo_html` mediumtext,
  `destinatarios` text,
  `adjuntos_json` json DEFAULT NULL,
  `estado_email` varchar(32) DEFAULT 'PENDIENTE',
  `fecha_envio` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL,
  `intentos_envio` int DEFAULT '0',
  `ultimo_error` text,
  `ultimo_error_codigo` varchar(32) DEFAULT '',
  `ultimo_error_detalle` text,
  `fecha_ultimo_intento` datetime(3) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `updated_at` datetime(3) NOT NULL,
  `updated_by` varchar(64) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_vig_sic_hallazgo` (`id_criterio`,`radicado`,`auto`,`fecha_auto`,`numero_boletin`),
  KEY `idx_vig_sic_rad` (`radicado`),
  KEY `idx_vig_sic_crit` (`id_criterio`),
  KEY `idx_vig_sic_estado` (`estado_email`),
  KEY `idx_vig_sic_hallazgo_activo` (`activo`),
  CONSTRAINT `fk_vig_sic_criterio` FOREIGN KEY (`id_criterio`) REFERENCES `vigilancia_sic_criterios` (`id`) ON DELETE CASCADE
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
