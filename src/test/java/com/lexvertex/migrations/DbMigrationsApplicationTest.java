package com.lexvertex.migrations;

import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class DbMigrationsApplicationTest {

    @Test
    void resolveSchemaFromArgs() {
        assertEquals("lex_core", DbMigrationsApplication.resolveSchema(new String[]{"--schema=lex_core"}));
        assertEquals("lex_config", DbMigrationsApplication.resolveSchema(new String[]{"--schema=lex_config"}));
        assertEquals("lex_audit", DbMigrationsApplication.resolveSchema(new String[]{"--schema=lex_audit"}));
        assertEquals("vigilis", DbMigrationsApplication.resolveSchema(new String[]{"--schema=vigilis"}));
    }

    @Test
    void resolveSchemasAllExpandsInOrder() {
        assertEquals(
                List.of("lex_config", "lex_core", "lex_audit", "vigilis"),
                DbMigrationsApplication.resolveSchemas(new String[]{"--schema=all"})
        );
    }

    @Test
    void resolveSchemaRejectsMissing() {
        assertThrows(IllegalArgumentException.class,
                () -> DbMigrationsApplication.resolveSchema(new String[]{}));
    }

    @Test
    void resolveSchemaRejectsUnknown() {
        assertThrows(IllegalArgumentException.class,
                () -> DbMigrationsApplication.resolveSchema(new String[]{"--schema=other"}));
    }

    @Test
    void resolveSchemaRejectsAllWhenExpectingSingle() {
        assertThrows(IllegalArgumentException.class,
                () -> DbMigrationsApplication.resolveSchema(new String[]{"--schema=all"}));
    }
}
