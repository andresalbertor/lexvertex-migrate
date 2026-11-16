-- Elimina code de especialidad y tipo de asunto: el id identifica el registro y el front no usa el código.
ALTER TABLE `process_type` DROP INDEX `uk_process_type_code`;
ALTER TABLE `process_type` DROP COLUMN `code`;

ALTER TABLE `specialty` DROP INDEX `uk_specialty_code`;
ALTER TABLE `specialty` DROP COLUMN `code`;
