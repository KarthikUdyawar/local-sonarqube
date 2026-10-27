# Troubleshooting

## Port 9000 is already in use

Check the listener:

```bash
ss -ltnp | grep ':9000'
```

Set another host port in `.env`, for example `SONAR_PORT=9001`, then run:

```bash
make up
```

Open `http://localhost:9001`.

## SonarQube is still starting

```bash
docker compose ps
docker compose logs --tail=200 sonarqube
docker compose logs --tail=100 db
```

Wait for the server to finish starting. If it repeatedly restarts, inspect logs and verify that the host has sufficient memory and meets SonarQube/Elasticsearch system requirements.

## PostgreSQL health check fails

```bash
docker compose logs --tail=150 db
```

Verify `.env` values and ensure `SONAR_DB_PASSWORD` is set. If the database volume was initialized with different credentials previously, changing `.env` alone does not change the password stored in that existing database.

## Reset everything (DESTRUCTIVE)

Only if you intentionally want to delete all SonarQube projects, settings, and database data:

```bash
docker compose down -v
```

This permanently removes the Compose-managed volumes. Do not use it as a routine troubleshooting step.

## Docker permissions

If `docker info` fails, confirm Docker is running and that your user has permission to access the Docker daemon. Avoid changing permissions broadly or exposing the Docker socket.
