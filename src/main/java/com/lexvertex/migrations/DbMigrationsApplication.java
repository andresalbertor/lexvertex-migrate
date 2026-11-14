package com.lexvertex.migrations;

import org.flywaydb.core.Flyway;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Set;

/**
 * Single Flyway runner. Requires {@code --schema=lex_core|lex_config|lex_audit|vigilis|all}
 * (or {@code MIGRATE_SCHEMA}).
 * <p>
 * Destructive clean: {@code --clean --yes} (or {@code MIGRATE_CLEAN=true} with {@code --yes})
 * drops all objects in the target schema(s) before migrate.
 * </p>
 */
public final class DbMigrationsApplication {

    static final List<String> SCHEMA_ORDER = List.of("lex_config", "lex_core", "lex_audit", "vigilis");
    private static final Set<String> ALLOWED_SCHEMAS = Set.copyOf(SCHEMA_ORDER);

    private DbMigrationsApplication() {
    }

    public static void main(String[] args) {
        final List<String> schemas = resolveSchemas(args);
        final boolean clean = wantsClean(args);
        if (clean && !hasFlag(args, "--yes")) {
            throw new IllegalArgumentException(
                    "Refusing --clean without --yes (destructive). Re-run with --clean --yes"
            );
        }

        for (final String schema : schemas) {
            migrateSchema(schema, clean, hasFlag(args, "--repair"));
        }
    }

    private static void migrateSchema(final String schema, final boolean clean, final boolean repair) {
        final String url = resolveUrl(schema);
        final String user = resolveUser(schema);
        final String password = resolvePassword(schema);

        // Seeds for config-server store Spring placeholders like ${DB_URL:...} as literal
        // VALUES; Flyway must not try to resolve them.
        final Flyway flyway = Flyway.configure()
                .dataSource(url, user, password)
                .schemas(schema)
                .defaultSchema(schema)
                .createSchemas(true)
                .baselineOnMigrate(true)
                .placeholderReplacement(false)
                .cleanDisabled(!clean)
                .locations("classpath:db/migration/" + schema)
                .load();

        if (clean) {
            flyway.clean();
            System.out.printf("Flyway schema=%s clean completed%n", schema);
        }

        if (repair) {
            flyway.repair();
            System.out.printf("Flyway schema=%s repair completed%n", schema);
        }

        final var result = flyway.migrate();
        System.out.printf(
                "Flyway schema=%s applied %d migration(s). Current version=%s%n",
                schema,
                result.migrationsExecuted,
                flyway.info().current() != null ? flyway.info().current().getVersion() : "none"
        );
    }

    private static boolean wantsClean(final String[] args) {
        return hasFlag(args, "--clean") || "true".equalsIgnoreCase(env("MIGRATE_CLEAN", "false"));
    }

    private static boolean hasFlag(final String[] args, final String flag) {
        for (final String arg : args) {
            if (flag.equals(arg)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Resolves one or more schemas from {@code --schema=} / {@code MIGRATE_SCHEMA}.
     * {@code all} expands to the fixed order: lex_config, lex_core, lex_audit, vigilis.
     */
    static List<String> resolveSchemas(final String[] args) {
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
                    "Missing required --schema=lex_core|lex_config|lex_audit|vigilis|all (or env MIGRATE_SCHEMA)"
            );
        }
        if ("all".equals(schema)) {
            return new ArrayList<>(SCHEMA_ORDER);
        }
        if (!ALLOWED_SCHEMAS.contains(schema)) {
            throw new IllegalArgumentException(
                    "Unsupported schema '" + schema + "'. Allowed: lex_core, lex_config, lex_audit, vigilis, all"
            );
        }
        return List.of(schema);
    }

    /** @deprecated use {@link #resolveSchemas(String[])} */
    @Deprecated
    static String resolveSchema(final String[] args) {
        final List<String> schemas = resolveSchemas(args);
        if (schemas.size() != 1) {
            throw new IllegalArgumentException("resolveSchema expects a single schema, got: " + schemas);
        }
        return schemas.getFirst();
    }

    private static String resolveUrl(final String schema) {
        final String override = env("DB_URL", "");
        if (!override.isBlank()) {
            // When migrating "all", DB_URL may point at one schema; rebuild per schema host/db.
            if (override.contains("/" + schema + "?") || override.endsWith("/" + schema)) {
                return override;
            }
            // Allow host override via DB_URL that still embeds a wrong database name:
            // replace path database with current schema when possible.
            final int schemeIdx = override.indexOf("://");
            final int pathStart = schemeIdx >= 0 ? override.indexOf('/', schemeIdx + 3) : -1;
            if (pathStart >= 0) {
                final int q = override.indexOf('?', pathStart);
                final String prefix = override.substring(0, pathStart + 1);
                final String suffix = q >= 0 ? override.substring(q) : "";
                return prefix + schema + suffix;
            }
        }
        return "jdbc:mysql://localhost:3306/" + schema
                + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    }

    private static String resolveUser(final String schema) {
        if ("vigilis".equals(schema)) {
            // Prefer dedicated vigilis user so --schema=all can keep lex_migration in env.
            final String vigilisUser = env("MYSQL_VIGILIS_MIGRATION_USER", "");
            if (!vigilisUser.isBlank()) {
                return vigilisUser;
            }
            return env("DB_MIGRATION_USER", "vigilis_migration");
        }
        return env("DB_MIGRATION_USER", env("MYSQL_MIGRATION_USER", "lex_migration"));
    }

    private static String resolvePassword(final String schema) {
        if ("vigilis".equals(schema)) {
            final String vigilisPassword = env("MYSQL_VIGILIS_MIGRATION_PASSWORD", "");
            if (!vigilisPassword.isBlank()) {
                return vigilisPassword;
            }
            return env("DB_MIGRATION_PASSWORD", "vigilis_migration_dev");
        }
        return env("DB_MIGRATION_PASSWORD", env("MYSQL_MIGRATION_PASSWORD", "lex_migration_dev"));
    }

    private static String env(final String name, final String defaultValue) {
        final String value = System.getenv(name);
        return value == null || value.isBlank() ? defaultValue : value;
    }
}
