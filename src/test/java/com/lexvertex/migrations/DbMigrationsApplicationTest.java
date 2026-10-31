package com.lexvertex.migrations;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class DbMigrationsApplicationTest {

    @Test
    void resolveSchemaFromArgs() {
        assertEquals("lex_core", DbMigrationsApplication.resolveSchema(new String[]{"--schema=lex_core"}));
        assertEquals("lex_config", DbMigrationsApplication.resolveSchema(new String[]{"--schema=lex_config"}));
        assertEquals("vigilis", DbMigrationsApplication.resolveSchema(new String[]{"--schema=vigilis"}));
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
}
