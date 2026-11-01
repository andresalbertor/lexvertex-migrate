package com.lexvertex.migrations;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Pruebas unitarias para validar la existencia y estructura de la migración V53.
 */
class V53UserProfessionalCardTest {

    private static final String MIGRATION_PATH = "/db/migration/lex_core/V53__user_professional_card.sql";

    @Test
    @DisplayName("Debe existir el script V53 en el classpath de migración de lex_core")
    void shouldFindMigrationScriptInClasspath() throws IOException {
        try (final InputStream inputStream = getClass().getResourceAsStream(MIGRATION_PATH)) {
            assertNotNull(inputStream, "El archivo V53__user_professional_card.sql debe existir");
        }
    }

    @Test
    @DisplayName("Debe agregar la columna professional_card de 50 caracteres a app_user")
    void shouldAlterAppUserWithProfessionalCard() throws IOException {
        try (final InputStream inputStream = getClass().getResourceAsStream(MIGRATION_PATH)) {
            assertNotNull(inputStream);
            final String content = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);
            assertTrue(content.contains("ALTER TABLE app_user"), "Debe alterar la tabla app_user");
            assertTrue(content.contains("professional_card"), "Debe declarar la columna professional_card");
            assertTrue(content.contains("VARCHAR(50)"), "Debe definir VARCHAR(50)");
        }
    }
}
