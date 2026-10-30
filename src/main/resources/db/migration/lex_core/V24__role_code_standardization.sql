-- V24: Estandarizacion de Codigos de Roles a 4 caracteres exactos (BUG-008)

-- 1. Actualizar roles existentes
UPDATE role SET code = 'ADMN' WHERE code = 'ADMIN';
UPDATE role SET code = 'ABOG' WHERE code = 'ABOGADO';
UPDATE role SET code = 'AUXI' WHERE code = 'AUXILIAR';

-- 2. Asegurar que la columna tenga el tamano exacto de 4 y modificar la definicion en la base de datos
ALTER TABLE role MODIFY code CHAR(4) NOT NULL;
