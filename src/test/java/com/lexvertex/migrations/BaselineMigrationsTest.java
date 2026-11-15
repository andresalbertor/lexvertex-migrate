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
 * Validates squashed baseline migration scripts required for cold-start PDN.
 */
class BaselineMigrationsTest {

    private static final List<String> GRANULAR_PERMISSIONS = List.of(
            "document-type:read", "document-type:create", "document-type:update", "document-type:delete",
            "location:read", "location:create", "location:update", "location:delete",
            "chamber:read", "chamber:create", "chamber:update", "chamber:delete",
            "disability-category:read", "disability-category:create", "disability-category:update",
            "disability-category:delete",
            "position:read", "position:create", "position:update", "position:delete",
            "specialty:read", "specialty:create", "specialty:update", "specialty:delete",
            "process-type:read", "process-type:create", "process-type:update", "process-type:delete",
            "channel:read", "channel:create", "channel:delete"
    );

    @Test
    @DisplayName("lex_core baseline schema and bootstrap seed exist")
    void lexCoreBaselineExists() throws IOException {
        assertResource("/db/migration/lex_core/V1__schema.sql");
        assertResource("/db/migration/lex_core/V2__bootstrap_seed.sql");
    }

    @Test
    @DisplayName("lex_core schema includes professional_card on app_user")
    void lexCoreHasProfessionalCard() throws IOException {
        final String ddl = read("/db/migration/lex_core/V1__schema.sql");
        assertTrue(ddl.contains("professional_card"), "DDL must declare professional_card");
        assertTrue(ddl.contains("`app_user`") || ddl.contains("app_user"), "DDL must declare app_user");
    }

    @Test
    @DisplayName("lex_core bootstrap seed includes SYSTEM user and granular permissions")
    void lexCoreSeedHasBootstrapData() throws IOException {
        final String seed = read("/db/migration/lex_core/V2__bootstrap_seed.sql");
        assertTrue(seed.contains("system@lexvertex.internal"), "Must seed SYSTEM user");
        assertTrue(seed.contains("NO_AUTO_VALUE_ON_ZERO"), "Must allow SYSTEM id=0");
        for (final String permission : GRANULAR_PERMISSIONS) {
            assertTrue(seed.contains(permission), "Missing permission seed: " + permission);
        }
    }

    @Test
    @DisplayName("lex_core seeds default administrator login")
    void lexCoreSeedsDefaultAdmin() throws IOException {
        final String admin = read("/db/migration/lex_core/V3__default_admin_user.sql");
        assertTrue(admin.contains("admin@example.test"), "Must seed bootstrap admin email");
        assertTrue(admin.contains("ADMN"), "Must assign ADMN role");
        assertTrue(admin.contains("$argon2id$"), "Must store Argon2id password hash");
        assertTrue(admin.contains("BOOTSTRAP-ADMIN"), "Must use stable person document");
    }

    @Test
    @DisplayName("lex_config baseline and consolidated PROPERTIES seed exist")
    void lexConfigBaselineExists() throws IOException {
        assertResource("/db/migration/lex_config/V1__properties_table.sql");
        final String seed = read("/db/migration/lex_config/V2__config_bootstrap.sql");
        assertTrue(seed.contains("account-service"), "Config seed must include account-service");
        assertTrue(seed.contains("'spring.flyway.enabled','false'"),
                "audit-service (and others) must use central Flyway");
        assertFalse(seed.contains("'spring.flyway.enabled','true'"),
                "No service should enable its own Flyway against lex_audit/lex_core");
    }

    @Test
    @DisplayName("lex_audit baseline exists")
    void auditBaselineExists() throws IOException {
        final String audit = read("/db/migration/lex_audit/V1__audit_event.sql");
        assertTrue(audit.contains("audit_event"), "lex_audit must create audit_event");
    }

    @Test
    @DisplayName("vigilis baseline schema and bootstrap seed exist")
    void vigilisBaselineExists() throws IOException {
        final String ddl = read("/db/migration/vigilis/V1__schema.sql");
        assertTrue(ddl.contains("CREATE TABLE `app_config`") || ddl.contains("CREATE TABLE app_config"),
                "vigilis DDL must create app_config");
        assertTrue(ddl.contains("updated_by"), "vigilis DDL must include updated_by audit columns");
        assertTrue(ddl.contains("CREATE TABLE `procesos`") || ddl.contains("CREATE TABLE procesos"),
                "vigilis DDL must create procesos");

        final String seed = read("/db/migration/vigilis/V2__bootstrap_seed.sql");
        assertTrue(seed.contains("scheduler_config"), "Must seed scheduler_config");
        assertTrue(seed.contains("sic_chequeo_inicial"), "Must seed sic_chequeo_inicial");
        assertTrue(seed.contains("documentos_retencion_dias"), "Must seed documentos_retencion_dias");
        assertTrue(seed.contains("despacho_smtp_default"), "Must seed despacho_smtp_default");
        assertTrue(seed.contains("006_audit_created_by_updated_by"),
                "Must mark vigilis SQL migrations as applied");
    }

    @Test
    @DisplayName("PDN SMTP usa mail.lexvertex.cloud")
    void smtpProdUsesPublicMailHost() throws IOException {
        final String config = read("/db/migration/lex_config/V5__smtp_prod_public_host.sql");
        assertTrue(config.contains("mail.lexvertex.cloud"), "Account/identity host must be the public mail name");
        assertTrue(config.contains("spring.mail.host"));
        assertTrue(config.contains("mail.smtp.ssl.trust"));
        assertFalse(config.contains("checkserveridentity"), "Hostname verification stays enabled");

        final String vigilis = read("/db/migration/vigilis/V4__smtp_default_public_host.sql");
        assertTrue(vigilis.contains("mail.lexvertex.cloud"));
        assertTrue(vigilis.contains("no-reply@lexvertex.cloud"));
        assertTrue(vigilis.contains("despacho_smtp_default"));
        assertFalse(vigilis.contains("smtp_password"), "SMTP password must not be stored by Flyway");
    }

    private static void assertResource(final String path) throws IOException {
        try (InputStream in = BaselineMigrationsTest.class.getResourceAsStream(path)) {
            assertNotNull(in, "Missing classpath resource: " + path);
        }
    }

    private static String read(final String path) throws IOException {
        try (InputStream in = BaselineMigrationsTest.class.getResourceAsStream(path)) {
            assertNotNull(in, "Missing classpath resource: " + path);
            return new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
    }
}
