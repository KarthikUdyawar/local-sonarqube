# Setup notes

## 1. Configure the environment

```bash
cp .env.example .env
```

Generate a password, for example:

```bash
openssl rand -hex 32
```

Put the output in `SONAR_DB_PASSWORD` in `.env`. This is the PostgreSQL application password, not the SonarQube web UI password. Keep `.env` private.

## 2. Start

```bash
make doctor
make config
make up
make logs
```

The first startup can take several minutes. In another terminal, check:

```bash
docker compose ps
docker compose logs --tail=100 sonarqube
```

Then open `http://localhost:9000`.

## 3. VS Code connected mode

Use the SonarQube for IDE extension's Command Palette commands to add a connection to your local server. Exact command labels can vary by extension version. The server URL is `http://localhost:9000` unless you changed `SONAR_PORT`. Create a user token in the SonarQube UI; never put it in this repository.

## 4. Stop and preserve data

```bash
make down
```

This removes containers but preserves named volumes. Do not use `docker compose down -v` unless you intend to erase all stored data.

## Official documentation

- [SonarQube Community Build Docker setup](https://docs.sonarsource.com/sonarqube-community-build/server-installation/from-docker-image/set-up-and-start-container)
- [Official SonarSource Docker Compose example with PostgreSQL](https://github.com/SonarSource/docker-sonarqube/blob/master/example-compose-files/sq-with-postgres/docker-compose.yml)
- [SonarQube for VS Code: Connected mode](https://docs.sonarsource.com/sonarqube-for-vs-code/connect-your-ide/connected-mode)
