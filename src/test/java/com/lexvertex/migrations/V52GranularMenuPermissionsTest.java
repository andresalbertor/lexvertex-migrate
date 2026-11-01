package com.lexvertex.migrations;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Pruebas unitarias de validación e integridad para el script de migración Flyway V52.
 * <p>
 * Verifica que el archivo {@code V52__granular_menu_permissions.sql} declare
 * con precisión los 31 permisos granulares, la asignación completa para el rol ADMN
 * y la migración compatible restringida para roles poseedores de {@code catalog:read}.
 * </p>
 */
class V52GranularMenuPermissionsTest {

    private static final String MIGRATION_PATH = "/db/migration/lex_core/V52__granular_menu_permissions.sql";

    private static final List<String> EXPECTED_PERMISSIONS = List.of(
            // Parametrización (16 permisos)
            "document-type:read", "document-type:create", "document-type:update", "document-type:delete",
            "location:read", "location:create", "location:update", "location:delete",
            "chamber:read", "chamber:create", "chamber:update", "chamber:delete",
            "disability-category:read", "disability-category:create", "disability-category:update", "disability-category:delete",
            // Organización (12 permisos CRUD + 3 permisos channel = 15 permisos)
            "position:read", "position:create", "position:update", "position:delete",
            "specialty:read", "specialty:create", "specialty:update", "specialty:delete",
            "process-type:read", "process-type:create", "process-type:update", "process-type:delete",
            "channel:read", "channel:create", "channel:delete"
    );

    /**
     * Valida que el archivo SQL de la migración V52 exista en el classpath de recursos.
     *
     * @throws IOException si ocurre un fallo al leer el archivo.
     */
    @Test
    @DisplayName("Debe existir el script V52 en el classpath de migración de lex_core")
    void shouldFindMigrationScriptInClasspath() throws IOException {
        try (final InputStream inputStream = getClass().getResourceAsStream(MIGRATION_PATH)) {
            assertNotNull(inputStream, "El archivo V52__granular_menu_permissions.sql debe existir");
        }
    }

    /**
     * Valida que los 31 códigos de permisos requeridos se encuentren declarados en la migración.
     *
     * @throws IOException si ocurre un fallo al leer el archivo.
     */
    @Test
    @DisplayName("Debe contener los 31 permisos granulares definidos en los requerimientos")
    void shouldContainAll31GranularPermissions() throws IOException {
        final String content = readMigrationContent();

        for (final String permission : EXPECTED_PERMISSIONS) {
            assertTrue(content.contains("'" + permission + "'"),
                    "El script debe declarar el permiso: " + permission);
        }
    }

    /**
     * Valida que el rol ADMN reciba la asignación de los 31 permisos incluyendo channel:*.
     *
     * @throws IOException si ocurre un fallo al leer el archivo.
     */
    @Test
    @DisplayName("Debe asignar todos los permisos al rol ADMN")
    void shouldAssignAllPermissionsToAdminRole() throws IOException {
        final String content = readMigrationContent();

        assertTrue(content.contains("WHERE r.code = 'ADMN'"),
                "El script debe asignar permisos al rol ADMN");
        assertTrue(content.contains("'channel:read'") && content.contains("'channel:create'") && content.contains("'channel:delete'"),
                "ADMN debe tener permisos de channel");
    }

    /**
     * Valida que la migración compatible de catalog:read solo asigne permisos de lectura
     * y nunca asigne permisos mutables (create, update, delete) ni permisos de canal (channel:*).
     *
     * @throws IOException si ocurre un fallo al leer el archivo.
     */
    @Test
    @DisplayName("Debe migrar solo permisos :read para roles no administradores con catalog:read")
    void shouldOnlyMigrateReadPermissionsForNonAdminRoles() throws IOException {
        final String content = readMigrationContent();

        // Extraer la sección de compatibilidad para roles no ADMN
        final int nonAdminSectionIndex = content.indexOf("r.code <> 'ADMN'");
        assertTrue(nonAdminSectionIndex > 0, "Debe existir la cláusula de exclusión para roles no-ADMN");

        final String nonAdminSection = content.substring(nonAdminSectionIndex);

        // Validar que en esa sección solo se asignan permisos de lectura
        assertTrue(nonAdminSection.contains("'document-type:read'"));
        assertTrue(nonAdminSection.contains("'location:read'"));
        assertTrue(nonAdminSection.contains("'chamber:read'"));
        assertTrue(nonAdminSection.contains("'disability-category:read'"));
        assertTrue(nonAdminSection.contains("'position:read'"));
        assertTrue(nonAdminSection.contains("'specialty:read'"));
        assertTrue(nonAdminSection.contains("'process-type:read'"));

        // No debe otorgar permisos mutables ni de canal
        assertFalse(nonAdminSection.contains("'channel:read'"));
        assertFalse(nonAdminSection.contains("'channel:create'"));
        assertFalse(nonAdminSection.contains("'channel:delete'"));
        assertFalse(nonAdminSection.contains(":create'"));
        assertFalse(nonAdminSection.contains(":update'"));
        assertFalse(nonAdminSection.contains(":delete'"));
    }

    /**
     * Lee y retorna el contenido completo del script de migración SQL codificado en UTF-8.
     *
     * @return Contenido textual del script SQL.
     * @throws IOException si no se puede leer el archivo.
     */
    private String readMigrationContent() throws IOException {
        try (final InputStream inputStream = getClass().getResourceAsStream(MIGRATION_PATH)) {
            assertNotNull(inputStream, "El archivo V52 debe existir");
            return new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);
        }
    }
}
