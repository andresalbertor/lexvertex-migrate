package com.lexvertex.migrations;

import org.flywaydb.core.Flyway;

import java.util.Locale;
import java.util.Set;

/**
 * Single Flyway runner. Requires {@code --schema=lex_core|lex_config|vigilis}
 * (or {@code MIGRATE_SCHEMA}).
 */
public final class DbMigrationsApplication {

    private static final Set<String> ALLOWED_SCHEMAS = Set.of("lex_core", "lex_config", "vigilis");

    private DbMigrationsApplication() {
    }

    public static void main(String[] args) {
        final String schema = resolveSchema(args);
        final String url = resolveUrl(schema);
        final String user = resolveUser(schema);
        final String password = resolvePassword(schema);

        // Seeds for config-server store Spring placeholders like ${DB_URL:...} as literal
        // VALUES; Flyway must not try to resolve them.
        // outOfOrder: VPS may have applied a later version before intermediate ones landed.
        final Flyway flyway = Flyway.configure()
                .dataSource(url, user, password)
                .schemas(schema)
                .defaultSchema(schema)
                .createSchemas(true)
                .baselineOnMigrate(true)
                .outOfOrder(true)
                .placeholderReplacement(false)
                .locations("classpath:db/migration/" + schema)
                .load();

        final var result = flyway.migrate();
        System.out.printf(
                "Flyway schema=%s applied %d migration(s). Current version=%s%n",
                schema,
                result.migrationsExecuted,
                flyway.info().current() != null ? flyway.info().current().getVersion() : "none"
        );
    }

    static String resolveSchema(final String[] args) {
        String schema = env("MIGRATE_SCHEMA", "");
        for (final String arg : args) {
            if (arg.startsWith("--schema=")) {
                schema = arg.substring("--schema=".length()).trim();
            } else if ("--schema".equals(arg)) {
                throw new IllegalArgumentException("Use --schema=<name>, not --schema alone");
            }
        }
        schema = schema == null ? "" : schema.trim().toLowerCase(Locale.ROOT);
        if (schema.isEmpty()) {
            throw new IllegalArgumentException(
                    "Missing required --schema=lex_core|lex_config|vigilis (or env MIGRATE_SCHEMA)"
            );
        }
        if (!ALLOWED_SCHEMAS.contains(schema)) {
            throw new IllegalArgumentException(
                    "Unsupported schema '" + schema + "'. Allowed: lex_core, lex_config, vigilis"
            );
        }
        return schema;
    }

    private static String resolveUrl(final String schema) {
        final String override = env("DB_URL", "");
        if (!override.isBlank()) {
            return override;
        }
        return "jdbc:mysql://localhost:3306/" + schema
                + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    }

    private static String resolveUser(final String schema) {
        if ("vigilis".equals(schema)) {
            return env("DB_MIGRATION_USER", env("MYSQL_VIGILIS_MIGRATION_USER", "vigilis_migration"));
        }
        return env("DB_MIGRATION_USER", env("MYSQL_MIGRATION_USER", "lex_migration"));
    }

    private static String resolvePassword(final String schema) {
        if ("vigilis".equals(schema)) {
            return env("DB_MIGRATION_PASSWORD", env("MYSQL_VIGILIS_MIGRATION_PASSWORD", "vigilis_migration_dev"));
        }
        return env("DB_MIGRATION_PASSWORD", env("MYSQL_MIGRATION_PASSWORD", "lex_migration_dev"));
    }

    private static String env(final String name, final String defaultValue) {
        final String value = System.getenv(name);
        return value == null || value.isBlank() ? defaultValue : value;
    }
}
