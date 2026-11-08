# Local SonarQube

A reusable, local-only SonarQube Community Build setup using Docker Compose and PostgreSQL. Intended for local development and connecting the SonarQube for IDE extension in VS Code.

> SonarQube is a trademark of SonarSource SA. This project is community-maintained and is not affiliated with or endorsed by SonarSource.

## Requirements

- Docker Engine and the Docker Compose plugin
- `make`
- Enough available RAM for SonarQube and Elasticsearch; first startup may take a few minutes

## Quick start

```bash
cp .env.example .env
```

Edit `.env` and set `SONAR_DB_PASSWORD` to a long, random password. Do not commit `.env`.

Validate prerequisites and configuration:

```bash
make doctor
make config
```

Start services:

```bash
make up
make logs
```

When SonarQube is ready, open **http://localhost:9000** (or the port configured in `.env`). The first-login credentials for a fresh instance are `admin` / `admin`; change the password when prompted.

## Commands

| Command                    | Purpose                                          |
| -------------------------- | ------------------------------------------------ |
| `make help`                | List commands                                    |
| `make doctor`              | Check Docker, Compose, `.env`, and configuration |
| `make config`              | Validate Compose configuration                   |
| `make up`                  | Start services                                   |
| `make down`                | Remove containers but keep data volumes          |
| `make stop` / `make start` | Stop/start existing containers                   |
| `make restart`             | Restart services                                 |
| `make logs`                | Follow SonarQube logs                            |
| `make ps`                  | Show container status                            |
| `make pull`                | Pull configured images                           |
| `make backup`              | Create a PostgreSQL SQL backup under `backups/`  |

## VS Code connection

1. Install `SonarSource.sonarlint-vscode` if it is not already installed.
2. Sign in to the local SonarQube web UI and change the initial admin password.
3. Create a user token in SonarQube's account/security settings. Treat it as a secret.
4. In VS Code, use the SonarQube for IDE command palette commands to add a SonarQube Server connection.
5. Use `http://localhost:9000` (or your configured port) as the server URL and provide the token.
6. Bind the workspace to a project on your local server if you want connected mode and synchronized supported rules/settings.

Standalone IDE analysis does not require a server. Connected mode capabilities depend on the SonarQube edition, language, and extension version.

## Data and security

- The web port is bound to `127.0.0.1`, so it is not exposed to other machines by this Compose configuration.
- PostgreSQL is not published to the host; only the SonarQube container can reach it on the private Compose network.
- Named Docker volumes preserve SonarQube and PostgreSQL data across `make down` and container recreation.
- **Do not run `docker compose down -v`** unless you intentionally want to delete the persistent volumes and all stored data.
- Do not commit `.env`, user tokens, database dumps, or other secrets.
- This is a local developer setup, not a hardened production deployment.

## Backups

Run:

```bash
make backup
```

This backs up the PostgreSQL database. For a complete recoverable backup, also plan a consistent backup of SonarQube's data/volume state and follow SonarQube's backup/restore documentation. Store backups securely; database dumps may contain project and account metadata.

## Restore

**Destructive:** this replaces the current database contents with the backup. Stop SonarQube, recreate the database, load the dump, then start SonarQube again:

```bash
docker compose stop sonarqube
docker compose exec -T db sh -c 'dropdb -U "$POSTGRES_USER" "$POSTGRES_DB" && createdb -U "$POSTGRES_USER" "$POSTGRES_DB"'
docker compose exec -T db sh -c 'psql -U "$POSTGRES_USER" "$POSTGRES_DB"' < backups/<file>.sql
docker compose start sonarqube
```

The first start after a restore can be slow.

## Troubleshooting

See [`docs/TROUBLESHOOTING.md`](docs/TROUBLESHOOTING.md) and [`docs/SETUP.md`](docs/SETUP.md).

## Contributing

Pull requests are welcome. See [`CONTRIBUTING.md`](CONTRIBUTING.md). Report security issues as described in [`SECURITY.md`](SECURITY.md).

## License

[MIT](LICENSE). SonarQube and PostgreSQL are separate projects with their own licenses.
