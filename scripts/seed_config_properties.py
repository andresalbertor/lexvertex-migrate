"""Flatten config-repo YAML into Flyway V34 INSERT statements for Spring Cloud Config JDBC."""
from __future__ import annotations

from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[3]
REPO = ROOT / "config-repo"
OUT = (
    ROOT
    / "backend"
    / "db-migrations"
    / "src"
    / "main"
    / "resources"
    / "db"
    / "migration"
    / "V34__config_server_properties_seed.sql"
)

APPS = [
    "application",
    "identity-service",
    "client-service",
    "catalog-service",
    "gateway-service",
    "discovery-service",
    "audit-service",
    "case-service",
    "document-service",
    "notification-service",
    "reporting-service",
]


def flatten(obj, prefix: str = ""):
    items = []
    if isinstance(obj, dict):
        for k, v in obj.items():
            key = f"{prefix}.{k}" if prefix else str(k)
            items.extend(flatten(v, key))
    elif isinstance(obj, list):
        for i, v in enumerate(obj):
            key = f"{prefix}[{i}]"
            items.extend(flatten(v, key))
    else:
        if obj is None:
            val = ""
        elif isinstance(obj, bool):
            val = "true" if obj else "false"
        else:
            val = str(obj)
        items.append((prefix, val))
    return items


def sql_escape(s: str) -> str:
    return s.replace("\\", "\\\\").replace("'", "''")


def main() -> None:
    rows = []
    for app in APPS:
        path = REPO / f"{app}.yml"
        if not path.exists():
            continue
        data = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
        for key, value in flatten(data):
            rows.append((app, "default", "master", key, value))

    lines = [
        "-- Seed Spring Cloud Config JDBC from config-repo YAML (flattened).",
        "-- Regenerar: python backend/db-migrations/scripts/seed_config_properties.py",
        "DELETE FROM PROPERTIES WHERE LABEL = 'master';",
        "",
    ]
    for app, profile, label, key, value in rows:
        lines.append(
            "INSERT INTO PROPERTIES (APPLICATION, PROFILE, LABEL, `KEY`, VALUE) VALUES ("
            f"'{sql_escape(app)}', '{sql_escape(profile)}', '{sql_escape(label)}', "
            f"'{sql_escape(key)}', '{sql_escape(value)}');"
        )
    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"Wrote {len(rows)} property rows to {OUT}")


if __name__ == "__main__":
    main()
