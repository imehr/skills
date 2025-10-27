# Skills Marketplace

A curated collection of professional skills for Claude Code, covering deployment, infrastructure, and development workflows.

## About

This marketplace provides battle-tested skills that enhance Claude Code's capabilities across different domains. Each skill follows rigorous quality standards, including:

- TDD methodology (RED-GREEN-REFACTOR)
- Pressure testing with multiple scenarios
- Clear boundaries (When to Use / When NOT to Use)
- Token efficiency (<1000 words per main skill)
- Verification safeguards

## Installation

### Recommended: Install via Marketplace (Easiest)

```bash
# Add the marketplace
/plugin marketplace add imehr/imehr-marketplace

# Install all skills
/plugin install imehr-skills@imehr-marketplace

# Restart Claude Code to load slash commands
exit
claude

# Verify installation
/help  # Should show all skill commands
```

### Alternative: Install Individual Skills Manually

```bash
# Clone this repository
git clone https://github.com/imehr/skills.git

# Copy a skill to your global Claude skills directory
cp -r skills/deployment/railway ~/.claude/skills/

# Or copy to a project-specific location
cp -r skills/deployment/railway /path/to/project/.claude/skills/
```

## Getting Updates

**IMPORTANT:** `/plugin update` does NOT work for getting new versions or new skills!

The `/plugin update` command only checks if NEW plugin packages have been added to the marketplace catalog. It does NOT:
- Update existing plugins to new versions
- Detect new skills added to existing plugins
- Pull updated content from the skills repository

### How to Update to Latest Version

When new skills are added or existing skills are updated, use this workflow:

```bash
# 1. Uninstall the current version
/plugin uninstall imehr-skills

# 2. Reinstall to get the latest version (fetches latest git tag)
/plugin install imehr-skills@imehr-marketplace

# 3. RESTART Claude Code (required for slash commands)
exit
claude

# 4. Verify new skills are available
/help  # Check for new slash commands
```

**Why this is necessary:**
- The plugin system caches installed content
- Version updates require a fresh install to fetch the latest git tag
- New skills within an existing plugin are not detected by `/plugin update`
- Slash commands only load at startup, so restart is mandatory

### Checking Your Current Version

```bash
# Check installed version
cat ~/.claude/plugins/cache/imehr-skills/.claude-plugin/manifest.json | grep version

# List all installed skills
ls ~/.claude/plugins/cache/imehr-skills/skills/
```

## Available Skills

### Deployment

- **[railway](skills/deployment/railway/)** - Railway.com deployment and management for Next.js applications with PostgreSQL
  - Use when: Railway deployment, environment variables, database migrations
  - Features: CLI workflows, troubleshooting, verification safeguards
  - Size: 820 words (82% reduction from original)
  - Status: ✅ Production-tested
  - Slash command: `/railway`

- **[telegram-integration](skills/deployment/telegram-integration/)** - Telegram bot and Mini App integration using Telegraf
  - Use when: Telegram bot development, Mini App setup, webhook/polling debugging, deployment to Railway/Vercel
  - Features: Diagnostic router, environment-specific patterns (local/production), platform-specific solutions, Mini App security validation
  - Size: 1,200 words
  - Status: ✅ Production-ready
  - Slash command: `/telegram`

### Workflows

- **[building-skills-marketplace](skills/workflows/building-skills-marketplace/)** - Complete workflow for creating and publishing Claude Code skills and marketplaces
  - Use when: Creating new skills, setting up marketplaces, packaging for distribution
  - Features: TDD methodology, two-repo structure, schema guides, verification checklists
  - Size: 982 words
  - Status: ✅ Documentation complete
  - Slash command: `/build-skills`

## Skill Quality Standards

All skills in this marketplace must meet these criteria:

### 1. Testing Requirements
- ✅ Tested with RED-GREEN-REFACTOR methodology
- ✅ Minimum 3 pressure scenarios (time, sunk cost, authority, exhaustion)
- ✅ False-positive prevention tests
- ✅ Documented test results

### 2. Structure Requirements
- ✅ YAML frontmatter with `name` and `description`
- ✅ Description starts with "Use when..."
- ✅ "When to Use" and "When NOT to Use" sections
- ✅ Quick Reference table
- ✅ Common Mistakes section

### 3. Token Efficiency
- ✅ Main SKILL.md <1000 words (ideally <500)
- ✅ Heavy reference material in supporting files
- ✅ Clear cross-references

### 4. Safety Features
- ✅ Verification requirements where applicable
- ✅ Explicit boundaries (platform-specific skills)
- ✅ "Ask user when uncertain" guidance

## Contributing

We welcome contributions! To add a skill to this marketplace:

1. **Follow the testing methodology** from superpowers:writing-skills
2. **Test your skill** with pressure scenarios
3. **Document test results** in TEST_RESULTS.md
4. **Submit a PR** with your skill in the appropriate category

### Skill Categories

- `deployment/` - Platform-specific deployment skills (Railway, Vercel, AWS, etc.)
- `infrastructure/` - Database, caching, monitoring skills
- `development/` - Language, framework, and tool-specific skills
- `workflows/` - CI/CD, testing, and process skills

### Creating a New Skill

```bash
# Create skill directory in appropriate category
mkdir -p skills/deployment/your-skill

# Create main skill file
touch skills/deployment/your-skill/SKILL.md

# Add supporting files as needed
touch skills/deployment/your-skill/reference.md
touch skills/deployment/your-skill/examples.md
touch skills/deployment/your-skill/troubleshooting.md

# Document your testing
touch skills/deployment/your-skill/TEST_RESULTS.md
```

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## Skill Template

See [skills/TEMPLATE/](skills/TEMPLATE/) for a complete skill template with:
- SKILL.md structure
- YAML frontmatter format
- Required sections
- Testing documentation template

## License

MIT License - See [LICENSE](LICENSE) for details.

## Acknowledgments

- Inspired by [obra/superpowers](https://github.com/obra/superpowers)
- Testing methodology from superpowers:writing-skills
- Quality standards from superpowers:testing-skills-with-subagents

## Author

**Mehran Mozaffari** - [GitHub](https://github.com/imehr)

## Support

- **Issues**: [GitHub Issues](https://github.com/imehr/skills/issues)
- **Discussions**: [GitHub Discussions](https://github.com/imehr/skills/discussions)

---

**Version:** 1.2.0
**Last Updated:** January 2025
