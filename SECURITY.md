# Security Policy

## Supported versions

Only the latest commit on `main` is supported.

## Reporting a vulnerability

Please **do not** open a public issue for security problems.

Use GitHub's private reporting: **Security tab → Report a vulnerability** on this repository.

Include:

- A description of the issue and its impact.
- Steps to reproduce.
- Affected files or configuration.

You can expect an initial response within 7 days.

## Scope

This repo is a local development setup for SonarQube. In scope: misconfigurations here (exposed ports, weak defaults, leaked secrets, unsafe scripts). Vulnerabilities in SonarQube or PostgreSQL themselves should go to their upstream projects.

## Hardening reminders for users

- Change the default `admin` password on first login.
- Set a strong `SONAR_DB_PASSWORD` in `.env`; never commit `.env`.
- Keep the web port bound to `127.0.0.1` unless you add authentication and TLS in front.
- Treat database backups as sensitive.
