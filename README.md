# Inception

Production-like, containerized WordPress stack powered by Docker: Nginx (TLS), PHP-FPM, MariaDB, Redis object cache, Adminer, FTP (vsftpd), a static site, and Fail2ban. Built as part of the 42 Inception project and refined for local development and demonstration.

## Table of contents

- Overview
- Architecture
- Tech stack
- Prerequisites
- Quick start
- Configuration (env)
- Make targets
- Data and logs
- Networking and ports
- Service notes
- Development tips
- Troubleshooting
- Project structure
- Commit and push

## Overview

This repository defines a small but complete WordPress infrastructure using Docker Compose. It provisions the CMS, database, reverse proxy with TLS, object cache, and helpful extras (Adminer, FTP, static site, Fail2ban) with persistent storage via bind mounts.

## Architecture

```
Browser ──HTTPS:443──> Nginx ──fastcgi──> WordPress (PHP-FPM:9000)
                                  │
                                  ├──> MariaDB:3306
                                  └──> Redis:6379

Adminer :8080 ────────────────> MariaDB
Static site :8081 ─────────────> Nginx (static)
FTP :21,30000-30009 ───────────> vsftpd
Fail2ban <── monitors /var/log/nginx and custom WP logs
```

## Tech stack

- Nginx with self-signed TLS cert (CN: `hel-bouk.42.fr`)
- PHP-FPM 8.2 (WordPress runtime) + WP-CLI bootstrap
- MariaDB (persistent data)
- Redis (WordPress object cache via `redis-cache` plugin)
- Adminer (DB UI) on :8080
- vsftpd (demo FTP) on :21 with passive :30000-30009
- Fail2ban (basic log-driven protections)

## Prerequisites

- Linux host
- Docker Engine 20.10+ and docker-compose (v1 or v2)
- Make
- Free host ports: 443, 8080, 8081, 21, 30000-30009

Note: The Makefile uses `docker-compose` (hyphen). If your system only offers `docker compose` (space), install the v1 shim or create an alias.

## Quick start

1) Copy environment example and customize:

```bash
cp .env.example .env
```

2) Build and run everything (also creates local bind-mounts):

```bash
make all
```

3) Optional: Map hostname for friendlier URL and to match the TLS CN:

```
127.0.0.1  hel-bouk.42.fr
```

4) Open the services:

- WordPress: https://hel-bouk.42.fr/ (or https://localhost/)
- Adminer:  http://localhost:8080/
- Static site: http://localhost:8081/
- FTP:       localhost:21 (passive: 30000-30009)

On first run, WordPress is installed via WP-CLI using your `.env` values; Redis object cache is auto-enabled.

## Configuration (env)

Create `.env` at the repo root. See `.env.example` for suggested values.

MariaDB + WordPress connectivity:

- MYSQL_ROOT_PASSWORD — MariaDB root password
- MYSQL_DATABASE — WordPress DB name
- MYSQL_USER — WordPress DB user
- MYSQL_PASSWORD — WordPress DB password
- MYSQL_Host — DB host used by WP (keep `mariadb`)

WordPress site setup:

- WP_URL — e.g. `https://hel-bouk.42.fr`
- WP_TITLE — Site title
- WP_ADMIN — Admin username
- WP_ADMIN_PASS — Admin password
- WP_ADMIN_MAIL — Admin email
- WP_USER — Additional editor user
- WP_MAIL_USER — Email for additional user
- WP_PASS — Password for additional user

FTP user (demo only):

- FTP_USER — FTP username
- FTP_PASS — FTP password

Security note: Do not commit real credentials. `.env.example` is safe to commit; `.env` is not.

## Make targets

- make all            → Create volumes, build, start
- make build          → Build images
- make up             → Start in detached mode
- make down           → Stop and remove containers
- make clean          → docker system prune -af + remove `~/data` (DANGEROUS)
- make volumes_clean  → remove only `~/data` (DANGEROUS)
- make re             → Clean and rebuild everything

## Data and logs

Bind mounts (created by `srcs/volumes.sh`):

- WordPress: `/home/$USER/data/MyDatabase/Wordpress`
- MariaDB:   `/home/$USER/data/MyDatabase/MariaDB`
- Nginx logs:    `/home/$USER/data/logs/nginx`
- Fail2ban logs: `/home/$USER/data/logs/fail2ban`

Deleting these directories will remove your data. Treat `make clean` and `make volumes_clean` with care.

## Networking and ports

- Nginx (WordPress): 443 → `nginx`
- Adminer: 8080 → `adminer`
- Static site: 8081 → `static-site`
- MariaDB: internal only
- WordPress PHP-FPM: internal :9000
- Redis: internal :6379
- FTP: 21 and 30000-30009 → `ftp`
- Fail2ban: container exposes :22 (mapped to host :2022) and watches mounted logs

All services join the `inception` bridge network.

## Service notes

- TLS: Self-signed certificate (CN `hel-bouk.42.fr`) → expect a browser warning.
- WordPress: Idempotent bootstrap; re-runs only when no `wp-config.php` / install present.
- Redis: `redis-cache` plugin installed/activated; constants are added to `wp-config.php`.
- Adminer: Minimal DB UI on :8080.
- FTP: Creates a local user from `.env`. Intended for demo; no WP volume is exposed by default.
- Fail2ban: Uses provided jail, filter, and action configs under `srcs/requirements/bonus/fail2ban/conf`.

## Development tips

- Rebuild a single service:
  - `docker-compose build <service>`
  - `docker-compose up -d <service>`
- Tail logs: `docker-compose logs -f <service>`
- Shell access: `docker-compose exec <service> bash`

## Troubleshooting

- HTTPS warning: Accept the self-signed cert or manage a local CA. Consider `/etc/hosts` mapping.
- Port conflicts: Stop the conflicting app or adjust host ports in `docker-compose.yml`.
- Full reset: `make re` (removes data) or `make down` to stop without deletion.
- WordPress not installed: Check `wordpress` logs and `.env` values. Removing the WP data dir forces a reinstall.
- Adminer login: Use `MYSQL_USER` / `MYSQL_PASSWORD`, host `mariadb`, DB `MYSQL_DATABASE`. Root requires `MYSQL_ROOT_PASSWORD`.
- FTP passive mode: Ensure ports 30000-30009 are open locally; configure your client for passive mode.

## Project structure

```
Inception/
├─ docker-compose.yml
├─ Makefile
├─ srcs/
│  ├─ volumes.sh
│  └─ requirements/
│     ├─ mariadb/
│     ├─ nginx/
│     ├─ wordpress/
│     └─ bonus/
│        ├─ adminer/
│        ├─ fail2ban/
│        ├─ ftp/
│        ├─ redis/
│        └─ StaticWebSite/
└─ README.md
```
