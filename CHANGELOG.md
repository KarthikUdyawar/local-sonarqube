# Changelog

All notable changes to this project are documented here.
Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.1.0] - 2026-11-08

### Added

- Docker Compose setup for SonarQube Community Build with PostgreSQL 17.
- `make` targets: `help`, `doctor`, `config`, `up`, `down`, `stop`, `start`, `restart`, `logs`, `ps`, `pull`, `backup`.
- Local-only defaults: web port bound to `127.0.0.1`, database not published to the host.
- Documentation: README, `docs/SETUP.md`, `docs/TROUBLESHOOTING.md`, backup and restore instructions.
- Open-source project files: MIT license, contributing guide, code of conduct, security policy, issue and PR templates, CI workflow, Dependabot config, `.editorconfig`.

### Changed

- Pinned SonarQube image to `26.10.0.133078-community`.

[Unreleased]: https://github.com/KarthikUdyawar/local-sonarqube/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/KarthikUdyawar/local-sonarqube/releases/tag/v0.1.0
