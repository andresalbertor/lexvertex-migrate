FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY build/install/db-migrations /app/db-migrations
ENTRYPOINT ["/app/db-migrations/bin/db-migrations"]