---
description: Railway.com deployment and management - deployment, logs, migrations, troubleshooting, monorepo strategies, security, and CLI reference. Use when deploying to Railway, configuring services, managing environment variables, or debugging deployment issues.
location: plugin
---

Use the railway skill to help with Railway.com deployment tasks.

**This will activate the Railway skill which provides:**
- Complete CLI reference with current syntax (2026-02)
- Deployment workflows (monorepo, multi-environment, CI/CD)
- Environment variable management (`railway variable set/list/delete`)
- Database migrations with backup-first safety
- Troubleshooting failed deployments (build logs, runtime logs, SSH)
- Networking, domains, and volume management

The skill will:
1. Verify this is a Railway project (check for `railway.json`, `railway.toml`, `.railway/`)
2. Help with systematic Railway workflows
3. Follow best practices (check logs first, test locally, backup before migrations)
