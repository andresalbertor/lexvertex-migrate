-- V53: Persistencia de Tarjeta Profesional en app_user (HU-USR-01)
-- Permite almacenar la tarjeta profesional del usuario editable únicamente desde el perfil propio.

ALTER TABLE app_user ADD COLUMN professional_card VARCHAR(50) NULL AFTER display_name;
