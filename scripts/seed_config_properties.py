"""DEPRECATED for day-to-day config changes.

Runtime config is MySQL lex_config.PROPERTIES (config-server JDBC).
To change env config, add a Flyway migration under
db/migration/lex_config/ that INSERT/UPDATE/DELETE rows in PROPERTIES
with PROFILE default|dev|prod. Run: migrate --schema=lex_config.

This script must not regenerate seed from YAML.
"""
from __future__ import annotations


def main() -> None:
    raise SystemExit(
        "Deprecated: do not regenerate config from YAML. "
        "Edit lex_config.PROPERTIES via Flyway "
        "(see db/migration/lex_config/V2__config_properties_by_environment.sql)."
    )


if __name__ == "__main__":
    main()
