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

### Install Individual Skills

```bash
# Clone this repository
git clone https://github.com/imehr/skills.git

# Copy a skill to your global Claude skills directory
cp -r skills/deployment/railway ~/.claude/skills/

# Or copy to a project-specific location
cp -r skills/deployment/railway /path/to/project/.claude/skills/
```

### Install as Claude Code Plugin

Add to your `.claude/plugins/config.json`:

```json
{
  "plugins": [
    {
      "name": "imehr-skills-marketplace",
      "source": "github:imehr/skills"
    }
  ]
}
```

## Available Skills

### Deployment

- **[railway](skills/deployment/railway/)** - Railway.com deployment and management for Next.js applications with PostgreSQL
  - Use when: Railway deployment, environment variables, database migrations
  - Features: CLI workflows, troubleshooting, verification safeguards
  - Size: 820 words (82% reduction from original)
  - Status: ✅ Production-tested

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

**Version:** 1.0.0
**Last Updated:** October 2025
