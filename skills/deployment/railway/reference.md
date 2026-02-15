# Railway CLI Complete Command Reference

Complete reference for all Railway CLI commands with current syntax, flags, and examples.
Last updated: 2026-02-16

## Table of Contents

1. [Installation & Authentication](#installation--authentication)
2. [Global Options](#global-options)
3. [Project Management](#project-management)
4. [Service Management](#service-management)
5. [Deployment Commands](#deployment-commands)
6. [Environment Variables](#environment-variables)
7. [Environment Management](#environment-management)
8. [Logs & Debugging](#logs--debugging)
9. [Networking & Domains](#networking--domains)
10. [Volumes](#volumes)
11. [Local Development](#local-development)
12. [CI/CD Integration](#cicd-integration)
13. [Exit Codes & Status](#exit-codes--status)

---

## Installation & Authentication

### Installation Methods

**Homebrew (macOS):**
```bash
brew install railway
```

**npm (cross-platform):**
```bash
npm i -g @railway/cli
```
*Requires Node.js 16+*

**Shell script (macOS, Linux, WSL):**
```bash
bash <(curl -fsSL cli.new)
```

**Scoop (Windows):**
```powershell
scoop install railway
```

### Authentication Commands

| Command | Purpose |
|---------|---------|
| `railway login` | Authenticate with Railway account (opens browser) |
| `railway login --browserless` | Login without browser access (displays URL + code) |
| `railway logout` | End current session |
| `railway whoami` | Display authenticated user information |

### CI/CD Authentication

Set environment variables for automated pipelines:

- `RAILWAY_TOKEN` — Project-level operations (deploy, redeploy, logs)
- `RAILWAY_API_TOKEN` — Account/workspace-level operations

```bash
RAILWAY_TOKEN=xxx railway up
```

---

## Global Options

These flags are available across most Railway CLI commands:

| Option | Shorthand | Purpose |
|--------|-----------|---------|
| `--service <SERVICE>` | `-s` | Target specific service by name or ID |
| `--environment <ENV>` | `-e` | Target specific environment by name or ID |
| `--project <ID>` | `-p` | Target specific project by ID |
| `--workspace <NAME>` | `-w` | Target specific workspace |
| `--json` | — | Output in JSON format (scriptable) |
| `--yes` | `-y` | Skip confirmation prompts |
| `--help` | `-h` | Display help information |
| `--version` | — | Show CLI version |
| `--verbose` | — | Detailed output for debugging |

**Example:**
```bash
railway logs --service backend --environment staging --json
```

---

## Project Management

### Basic Project Commands

```bash
# Create new project
railway init

# Link to existing project (interactive)
railway link

# Link to specific project
railway link --project my-project-id
railway link --project my-project --environment staging --service api

# Unlink current directory
railway unlink

# List all projects
railway list

# Show current project details
railway status
railway status --json

# Open project in browser
railway open

# Delete project (careful!)
railway delete
```

### Link Command Options

```bash
railway link [OPTIONS]
```

| Flag | Purpose |
|------|---------|
| `-p, --project <ID\|NAME>` | Project to link to |
| `-e, --environment <ID\|NAME>` | Environment to link to |
| `-s, --service <ID\|NAME>` | Service to link to |
| `-w, --workspace <ID\|NAME>` | Workspace to link to |
| `--json` | Output in JSON format |

**Workflow Note:**
By default, the CLI links to the `production` environment. Change the linked environment with `railway environment`.

---

## Service Management

### Service Commands Overview

```bash
# Add service (interactive)
railway add

# Add database service
railway add --database postgres
railway add --database mysql
railway add --database redis
railway add --database mongodb

# Add from GitHub repository
railway add --repo user/repo

# Link to a service
railway service
railway service backend

# Scale service across regions
railway scale
railway service scale --us-west1=2 --eu-west1=1
```

### Service Status & Operations

```bash
railway service [SERVICE] [COMMAND]
```

#### Subcommands

| Command | Purpose |
|---------|---------|
| `link` | Connect a service to the project |
| `status` | Display deployment status |
| `logs` | Retrieve service logs |
| `redeploy` | Launch latest deployment again |
| `restart` | Reboot current deployment |
| `scale` | Distribute service across regions |

#### Status Flags

```bash
railway service status [OPTIONS]
```

| Flag | Purpose |
|------|---------|
| `-a, --all` | Show status for all services in the environment |
| `--json` | JSON output format |

**Examples:**
```bash
# Check status of linked service
railway service status

# Check all services
railway service status --all

# JSON output for scripting
railway service status --json
```

---

## Deployment Commands

### Deploy from Local Source

```bash
railway up [PATH] [OPTIONS]
```

The `railway up` command compresses and uploads your app's files to Railway.

#### Flags and Options

| Flag | Purpose |
|------|---------|
| `-d, --detach` | Don't attach to the log stream (returns immediately) |
| `-c, --ci` | Stream build logs only, then exit (CI mode) |
| `-s, --service <SERVICE>` | Deploy to specified service |
| `-e, --environment <ENV>` | Deploy to specified environment |
| `-p, --project <ID>` | Deploy to specified project (requires `--environment`) |
| `--no-gitignore` | Don't ignore paths from `.gitignore` |
| `--path-as-root` | Use path argument as archive root |
| `--verbose` | Provide detailed output |
| `--json` | Output logs in JSON format (implies CI mode) |

#### Usage Examples

```bash
# Basic deployment (current directory)
railway up

# Deploy without watching logs
railway up --detach

# Deploy subdirectory
railway up ./backend

# Deploy subdirectory as root (critical for monorepos)
railway up --path-as-root ./web

# Deploy to specific service
railway up --service backend

# Deploy to staging environment
railway up --environment staging

# CI mode (build logs only)
railway up --ci

# CI mode with JSON output
railway up --json
```

#### File Handling

The command respects `.gitignore` and `.railwayignore` files by default, automatically ignoring:
- `.git` directory
- `node_modules` directory

Use `--no-gitignore` to override this behavior.

### Deploy from Template

```bash
railway deploy --template postgres
railway deploy --template mysql
```

### Redeploy & Restart

```bash
# Redeploy latest deployment (same code, new environment)
railway redeploy
railway redeploy --yes  # skip confirmation

# Restart service (same deployment)
railway restart
```

### Deployment List & Management

```bash
railway deployment <COMMAND> [OPTIONS]
```

#### Subcommands

| Command | Alias | Purpose |
|---------|-------|---------|
| `list` | `ls` | List deployments with IDs, statuses, and timestamps |
| `up` | — | Initiates upload and deploy process |
| `redeploy` | — | Activates latest deployment again |

#### List Flags

```bash
railway deployment list [OPTIONS]
```

| Flag | Purpose |
|------|---------|
| `-s, --service <SERVICE>` | Target specific service |
| `-e, --environment <ENV>` | Specify environment |
| `--limit <N>` | Cap number displayed (default 20, max 1000) |
| `--json` | Structured output format |

**Examples:**
```bash
# Display recent deployments
railway deployment list

# Get last 50 deployments
railway deployment list --limit 50

# Filter by service
railway deployment list --service backend

# Export as JSON
railway deployment list --json

# Extract latest deployment ID
railway deployment list --json --limit 1 | jq -r '.[0].id'
```

### Remove Deployment

```bash
railway down
```

Removes the active deployment.

---

## Environment Variables

### Variable Commands

```bash
railway variable [COMMAND] [OPTIONS]
```

**Aliases:** `variables`, `vars`, `var`

### List Variables

```bash
railway variable list [OPTIONS]
```

| Flag | Purpose |
|------|---------|
| `-s, --service <SERVICE>` | Target specific service |
| `-e, --environment <ENV>` | Target specific environment |
| `-k, --kv` | Output in key=value format |
| `--json` | JSON output format |

**Examples:**
```bash
# List variables for linked service
railway variable list

# List in key-value format
railway variable list --kv

# List for specific service and environment
railway variable list --service backend --environment staging

# JSON output
railway variable list --json
```

### Set Variables

```bash
railway variable set KEY=VALUE [KEY=VALUE...] [OPTIONS]
```

| Flag | Purpose |
|------|---------|
| `-s, --service <SERVICE>` | Target specific service |
| `-e, --environment <ENV>` | Target specific environment |
| `--stdin` | Read value from stdin |
| `--skip-deploys` | Don't trigger redeployment |
| `--json` | JSON output format |

**Examples:**
```bash
# Set single variable
railway variable set API_KEY=secret123

# Set multiple variables
railway variable set API_KEY=secret123 DEBUG=true PORT=8080

# Set from stdin (useful for multiline secrets)
echo "-----BEGIN PRIVATE KEY-----
..." | railway variable set PRIVATE_KEY --stdin

# Set without triggering redeploy
railway variable set DEBUG=true --skip-deploys

# Set for specific service
railway variable set DATABASE_URL=postgres://... --service backend
```

### Delete Variables

```bash
railway variable delete KEY [OPTIONS]
```

| Flag | Purpose |
|------|---------|
| `-s, --service <SERVICE>` | Target specific service |
| `-e, --environment <ENV>` | Target specific environment |
| `--json` | JSON output format |

**Examples:**
```bash
# Delete variable
railway variable delete API_KEY

# Delete from specific service
railway variable delete DEBUG --service backend
```

---

## Environment Management

### Environment Commands

```bash
railway environment [ENVIRONMENT] [COMMAND]
```

**Alias:** `railway env`

### Subcommands

| Command | Purpose |
|---------|---------|
| `link` | Link an environment to the current project |
| `new` | Create a new environment |
| `delete` | Delete an environment |
| `edit` | Edit an environment's configuration |
| `config` | Show environment configuration |

### Switch Environment

```bash
# Interactive environment selection
railway environment

# Link to specific environment
railway environment link staging
```

### Create Environment

```bash
railway environment new <NAME> [OPTIONS]
```

| Flag | Purpose |
|------|---------|
| `-d, --duplicate <ENV>` | Duplicate settings from another environment |
| `--json` | JSON output format |

**Examples:**
```bash
# Create new environment
railway environment new staging

# Create with duplicated settings
railway environment new staging --duplicate production
```

### Delete Environment

```bash
railway environment delete <NAME> [OPTIONS]
```

| Flag | Purpose |
|------|---------|
| `-y, --yes` | Skip confirmation |
| `--2fa-code <CODE>` | Two-factor authentication verification |
| `--json` | JSON output format |

**Examples:**
```bash
# Delete environment (with confirmation)
railway environment delete dev

# Delete without confirmation
railway environment delete dev --yes
```

### Edit Environment

```bash
railway environment edit [OPTIONS]
```

| Flag | Purpose |
|------|---------|
| `-e, --environment <ENV>` | Target environment to modify |
| `-s, --service-config <SERVICE> <PATH> <VALUE>` | Configure via dot-path notation |
| `-m, --message <MSG>` | Commit message for changes |
| `--stage` | Stage without committing |
| `--json` | JSON output format |

**Example using dot-path notation:**
```bash
railway environment edit \
  --service-config backend variables.API_KEY.value "secret" \
  --message "Update API key"
```

### Show Environment Config

```bash
railway environment config [OPTIONS]
```

| Flag | Purpose |
|------|---------|
| `-e, --environment <ENV>` | Specify which environment to display |
| `--json` | JSON output format |

---

## Logs & Debugging

### Service Logs

```bash
railway logs [OPTIONS]
railway service logs [OPTIONS]
```

#### Logs Flags

| Flag | Purpose |
|------|---------|
| `-d, --deployment` | Deployment log view |
| `-b, --build` | Build log view |
| `-n, --lines <N>` | Number of log lines to fetch (disables streaming) |
| `-f, --filter <QUERY>` | Filter logs using Railway's query syntax |
| `--latest` | Show logs from latest deployment |
| `-S, --since <TIME>` | Logs after specified timestamp |
| `-U, --until <TIME>` | Logs before specified timestamp |
| `--json` | JSON output format |

**Examples:**
```bash
# Stream deployment logs (default)
railway logs

# View build logs
railway logs --build

# Show last 100 lines
railway logs -n 100

# Filter logs
railway logs --filter "error"

# Logs from specific deployment
railway logs 7422c95b-c604-46bc-9de4-b7a43e1fd53d

# Logs since timestamp
railway logs --since 2024-01-15T10:00:00Z

# JSON output
railway logs --json
```

### SSH into Service Container

```bash
railway ssh [SERVICE]
```

Access the service container shell for debugging.

**Examples:**
```bash
# SSH into linked service
railway ssh

# SSH into specific service
railway ssh backend
```

### Database Connection

```bash
railway connect [SERVICE_NAME] [OPTIONS]
```

Opens an interactive database shell using local client tools.

| Flag | Purpose |
|------|---------|
| `-e, --environment <ENV>` | Pull variables from specified environment |

**Supported Databases:**
- PostgreSQL (requires `psql`)
- MySQL (requires `mysql`)
- Redis (requires `redis-cli`)
- MongoDB (requires `mongosh`)

**Prerequisites:**
- Database must have TCP Proxy enabled
- Appropriate database client installed locally

**Examples:**
```bash
# Interactive selection
railway connect

# Connect to specific database
railway connect postgres

# Connect to staging database
railway connect postgres --environment staging
```

---

## Networking & Domains

### Domain Management

```bash
railway domain [DOMAIN] [OPTIONS]
```

#### Flags

| Flag | Purpose |
|------|---------|
| `-p, --port <PORT>` | The port to connect to the domain |
| `-s, --service <SERVICE>` | The service to add the domain to |
| `--json` | Output in JSON format |

#### Usage Examples

```bash
# Generate Railway domain (*.up.railway.app)
railway domain

# Add custom domain
railway domain example.com

# Add domain with specific port
railway domain example.com --port 8080

# Add domain to specific service
railway domain example.com --service api
```

#### Domain Limits

- **Railway-provided domain:** One per service
- **Custom domains:** Multiple per service

---

## Volumes

### Volume Commands

```bash
railway volume <COMMAND> [OPTIONS]
```

### Available Commands

| Command | Purpose |
|---------|---------|
| `list` | Display all volumes |
| `add` | Create a new volume |
| `delete` | Remove a volume |
| `update` | Modify volume properties |
| `detach` | Detach volume from service |
| `attach` | Attach volume to service |

### Common Flags

| Flag | Purpose |
|------|---------|
| `-s, --service <SERVICE>` | Specify service |
| `-e, --environment <ENV>` | Specify environment |
| `-v, --volume <VOLUME>` | Volume identifier |
| `-m, --mount-path <PATH>` | Storage location (must start with `/`) |
| `-n, --name <NAME>` | Volume name |
| `-y, --yes` | Bypass confirmation prompts |
| `--json` | JSON output format |

### Usage Examples

```bash
# List volumes
railway volume list

# Add a volume
railway volume add --mount-path /data

# Delete a volume
railway volume delete --volume my-volume

# Update volume mount path
railway volume update --volume my-volume --mount-path /new/path

# Rename volume
railway volume update --volume my-volume --name new-name

# Detach from service
railway volume detach --volume my-volume

# Attach to service
railway volume attach --volume my-volume --service backend
```

---

## Local Development

### Run Command with Railway Variables

```bash
railway run <COMMAND>
```

Execute commands with Railway environment variables injected.

**Examples:**
```bash
# Start Node.js app with Railway variables
railway run npm start

# Run Python script
railway run python app.py

# Run database migrations
railway run npm run migrate
```

### Shell with Railway Variables

```bash
railway shell
```

Opens an interactive shell with Railway environment variables loaded.

### Local Docker Development

```bash
railway dev
```

Run services locally via Docker with Railway configuration.

---

## CI/CD Integration

### Authentication in CI/CD

Railway provides two token types for automation:

1. **Project Token** (`RAILWAY_TOKEN`)
   - Scoped to specific project + environment
   - Can: deploy code, redeploy, view logs
   - Cannot: modify project settings, manage users

2. **API Token** (`RAILWAY_API_TOKEN`)
   - Account/workspace-level access
   - Full API access

**Usage:**
```bash
# Set token in environment
export RAILWAY_TOKEN=your-token-here

# Deploy in CI
RAILWAY_TOKEN=$RAILWAY_TOKEN railway up --ci

# Or inline
RAILWAY_TOKEN=xxx railway up --detach
```

### CI-Specific Flags

```bash
railway up --ci         # Build logs only, non-interactive
railway up --json       # JSON output (implies --ci)
railway up --detach     # Return immediately after upload
```

### GitHub Actions Integration

Railway supports:
- `deployment_status` events for post-deployment triggers
- Automatic PR environment creation/deletion
- Deploy previews for pull requests

**Example workflow:**
```yaml
name: Deploy to Railway
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Railway CLI
        run: npm i -g @railway/cli
      - name: Deploy
        run: railway up --ci
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
```

---

## Exit Codes & Status

### Command Exit Codes

- `0` — Success
- `1` — Failure or crash

### Status Checking

```bash
railway status [OPTIONS]
```

Outputs the currently linked project, environment, and service details.

| Flag | Purpose |
|------|---------|
| `--json` | Output in JSON format |

**Examples:**
```bash
# Basic status display
railway status

# JSON output for scripting
railway status --json
```

**Sample Output:**
```
Project: my-project (7d7fd6ff-1a22-4708-8d13-0a4e9674d414)
Environment: production (b565a15d-d765-4d3a-a0bf-90b8b1f699f7)
Service: web (36c8b81a-f702-472b-aaba-298241f97516)
```

---

## Additional Utilities

### Documentation & Help

```bash
# Open Railway documentation
railway docs

# Command-specific help
railway <command> --help
railway up --help
```

### Version Management

```bash
# Check CLI version
railway --version

# Update CLI
railway upgrade
```

### Shell Completions

```bash
# Generate bash completions
railway completion bash

# Generate zsh completions
railway completion zsh

# Generate fish completions
railway completion fish
```

**Setup (bash):**
```bash
railway completion bash > /etc/bash_completion.d/railway
```

**Setup (zsh):**
```bash
railway completion zsh > "${fpath[1]}/_railway"
```

---

## Functions (Beta)

Railway Functions support:

```bash
# List functions
railway functions list

# Create function
railway functions new

# Upload function updates
railway functions push
```

---

## Common Workflows

### Initial Setup Workflow

```bash
# 1. Install CLI
brew install railway

# 2. Authenticate
railway login

# 3. Link to project
railway link --project my-project

# 4. Check status
railway status

# 5. Deploy
railway up
```

### Monorepo Deployment

```bash
# Deploy subdirectory as root (critical!)
cd /path/to/monorepo
railway up --path-as-root ./backend --service backend
railway up --path-as-root ./frontend --service frontend
```

### Multi-Environment Deployment

```bash
# Deploy to staging
railway up --environment staging

# Deploy to production
railway up --environment production

# Or switch environment first
railway environment production
railway up
```

### Setting Up New Service with Database

```bash
# 1. Add database
railway add --database postgres

# 2. Create service
railway add --repo username/repo

# 3. Link service
railway service backend

# 4. Set variables
railway variable set DATABASE_URL=$DATABASE_URL

# 5. Deploy
railway up
```

### Debugging Deployment Issues

```bash
# 1. Check deployment status
railway deployment list --limit 5

# 2. View build logs
railway logs --build

# 3. View deployment logs
railway logs --deployment

# 4. SSH into container
railway ssh

# 5. Check environment variables
railway variable list
```

### Database Migration (Always Backup First)

```bash
# 1. Backup
railway run pg_dump -Fc > backup.dump

# 2. Verify state
railway connect postgres

# 3. Migrate
railway run npm run migrate

# 4. Verify
railway connect postgres
```

---

## Key Gotchas & Tips

### Path-as-Root Flag

**Critical for monorepos:** When deploying a subdirectory, always use `--path-as-root` to ensure the subdirectory is treated as the archive root.

```bash
# Wrong (subdirectory becomes nested in archive)
railway up ./web

# Correct (subdirectory becomes root of archive)
railway up --path-as-root ./web
```

### Environment Flag Required with Project

When using `--project`, you **must** also specify `--environment`:

```bash
# Wrong
railway up --project my-project-id

# Correct
railway up --project my-project-id --environment production
```

### Variable Changes Trigger Redeployment

By default, setting variables triggers a redeployment. Use `--skip-deploys` to prevent this:

```bash
railway variable set DEBUG=true --skip-deploys
```

### Logs Streaming vs History

- **Without `-n` flag:** Streams logs in real-time
- **With `-n` flag:** Fetches last N lines and exits

```bash
# Stream logs (live)
railway logs

# Get last 100 lines (exit immediately)
railway logs -n 100
```

### TLS Between Railway Services

Railway-to-Railway calls may fail with `UNABLE_TO_GET_ISSUER_CERT_LOCALLY`. Workarounds:
- Set `NODE_TLS_REJECT_UNAUTHORIZED=0` (development only)
- Use private networking for inter-service communication

---

## Complete Command Index

### Authentication
- `railway login [--browserless]`
- `railway logout`
- `railway whoami`

### Projects
- `railway init`
- `railway link [-p PROJECT] [-e ENV] [-s SERVICE]`
- `railway unlink`
- `railway list`
- `railway status [--json]`
- `railway open`
- `railway delete`

### Services
- `railway add [--database TYPE | --repo USER/REPO]`
- `railway service [link | status | logs | redeploy | restart | scale]`

### Deployment
- `railway up [PATH] [--detach | --ci | --json | --path-as-root]`
- `railway deploy --template TYPE`
- `railway redeploy [--yes]`
- `railway restart`
- `railway down`
- `railway deployment list [--limit N] [--json]`

### Variables
- `railway variable list [-k] [--json]`
- `railway variable set KEY=VALUE [--stdin] [--skip-deploys]`
- `railway variable delete KEY`

### Environments
- `railway environment [link | new | delete | edit | config]`

### Logs & Debug
- `railway logs [-d | -b] [-n N] [-f QUERY] [--json]`
- `railway ssh [SERVICE]`
- `railway connect [SERVICE]`

### Networking
- `railway domain [DOMAIN] [-p PORT] [-s SERVICE]`

### Volumes
- `railway volume [list | add | delete | update | detach | attach]`

### Local Dev
- `railway run COMMAND`
- `railway shell`
- `railway dev`

### Utilities
- `railway docs`
- `railway upgrade`
- `railway completion SHELL`

---

## Sources

This reference was compiled from the official Railway documentation:

- [Railway CLI Guide](https://docs.railway.com/guides/cli)
- [CLI API Reference](https://docs.railway.com/reference/cli-api)
- [Deploying with CLI](https://docs.railway.com/cli/deploying)
- [railway up](https://docs.railway.com/cli/up)
- [railway service](https://docs.railway.com/cli/service)
- [railway status](https://docs.railway.com/cli/status)
- [railway deployment](https://docs.railway.com/cli/deployment)
- [railway variable](https://docs.railway.com/cli/variable)
- [railway domain](https://docs.railway.com/cli/domain)
- [railway link](https://docs.railway.com/cli/link)
- [railway environment](https://docs.railway.com/cli/environment)
- [railway volume](https://docs.railway.com/cli/volume)
- [railway connect](https://docs.railway.com/cli/connect)
- [Global Options](https://docs.railway.com/cli/global-options)
- [Viewing Logs](https://docs.railway.com/guides/logs)

---

**Last Updated:** 2026-02-16
**CLI Version:** Latest (as of February 2026)
**Documentation:** https://docs.railway.com
