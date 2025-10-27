# Lessons Learned: Building Skills Marketplace

**Date:** October 27, 2025
**Project:** Railway Skill + Marketplace Setup

## Critical Discoveries

### 1. marketplace.json Schema Must Match Exactly

**Problem:** Initial schema used wrong fields (author, repository, displayName)

**Error:**
```
Invalid schema: owner: Required, plugins.0.author: Expected object,
received string, plugins.0: Unrecognized key(s) in object: 'displayName'
```

**Solution:** Match superpowers-marketplace schema exactly:
```json
{
  "name": "marketplace-name",
  "owner": {  // ❌ NOT "author"
    "name": "Name",
    "email": "email@example.com"
  },
  "metadata": {  // ❌ NOT "description" directly
    "description": "...",
    "version": "1.0.0"
  },
  "plugins": [{
    "source": {  // ❌ NOT "repository: github:owner/repo"
      "source": "url",
      "url": "https://github.com/owner/repo.git"
    }
  }]
}
```

### 2. Slash Commands Are Required for /help Visibility

**Problem:** Skill installed but didn't show in `/help`

**Root cause:** Skills auto-activate but don't appear in `/help` without slash commands

**Solution:** Add `commands/` directory:
```
skills-repo/
├── commands/
│   └── railway.md        # Shows in /help
└── skills/
    └── deployment/
        └── railway/
            └── SKILL.md  # Auto-activates
```

**Manifest must link them:**
```json
{
  "commands_directory": "commands",
  "skills": [{
    "path": "skills/deployment/railway",
    "command": "commands/railway.md"  // Critical link
  }]
}
```

### 3. Two-Repository Structure Is Mandatory

**Like superpowers:**
- Repository 1: Marketplace catalog (marketplace.json)
- Repository 2: Skills content (actual skills)

**Why:**
- Catalog is lightweight, just lists plugins
- Skills can be large with many files
- Follows plugin architecture pattern

**Installation flow:**
```bash
/plugin marketplace add owner/marketplace-repo  # Adds catalog
/plugin install plugin-name@marketplace-repo    # Fetches skills
```

### 4. Testing Must Come BEFORE Writing

**RED-GREEN-REFACTOR methodology:**
1. **RED:** Write pressure tests, document baseline failures
2. **GREEN:** Write minimal skill to pass tests
3. **REFACTOR:** Identify gaps, add safeguards, re-test

**Railway skill testing:**
- 3 pressure scenarios (time, sunk cost, exhaustion)
- 2 false-positive prevention tests
- 100% pass rate after refactoring
- 3 gaps identified and fixed

### 5. Verification Safeguards Prevent False Positives

**Problem:** Platform-specific skills might activate on wrong platforms

**Solution:** Add verification section:
```markdown
## ⚠️ VERIFICATION REQUIRED

**BEFORE using this skill, verify:**
1. User explicitly mentions "Platform", OR
2. Check for artifacts (config.json, .platform/)
3. When in doubt, ASK

**DO NOT use for:** [List competing platforms]
```

**Testing showed:** Agents correctly asked "Which platform?" when unclear

### 6. Word Count Matters

**Target:** <500 words (main SKILL.md)
**Maximum:** <1000 words
**Strategy:** Move heavy content to supporting files

**Railway skill:**
- SKILL.md: 820 words (acceptable, includes safety protocols)
- reference.md: 15KB (CLI reference)
- examples.md: 19KB (workflows)
- troubleshooting.md: 21KB (error diagnosis)

### 7. Git Tagging Is MANDATORY Before Publishing

**Critical:** Plugin system fetches specific git tags, not main branch!

**Problem:** Published v1.1.0 to marketplace.json but users couldn't install it

**Root cause:** No git tag created - plugin system had nothing to fetch

**Solution - Tag BOTH repositories:**
```bash
# Skills repository (content)
cd skills-repo
git tag -a v1.1.0 -m "Release v1.1.0 - Description"
git push origin v1.1.0

# Marketplace repository (catalog)
cd marketplace-repo
git tag -a v1.1.0 -m "Release v1.1.0 - Description"
git push origin v1.1.0
```

**Marketplace references these tags:**
```json
{
  "metadata": { "version": "1.1.0" },
  "plugins": [{ "version": "1.1.0" }]  // Must match git tags
}
```

### 8. Plugin Updates Require Uninstall/Reinstall

**Problem:** `/plugin update` didn't fetch new skills in v1.1.0

**Root cause:** `/plugin update` only checks for NEW plugins in marketplace, not version updates of existing plugins

**Solution for users getting updates:**
```bash
# This WON'T work for version updates:
/plugin update plugin-name@marketplace  # Only checks for new plugins

# This WILL work:
/plugin uninstall plugin-name
/plugin install plugin-name@marketplace  # Fetches latest git tag
```

**Why:** Marketplace only lists plugin names. System doesn't compare versions, just checks "is this plugin new?"

### 9. Restart Required for Slash Commands

**Problem:** After installing v1.1.0, only /railway showed in /help, not /build-skills

**Root cause:** Slash commands load at Claude Code startup, not dynamically

**Solution:** Always tell users to restart:
```bash
# After ANY plugin install/update:
exit        # Exit Claude Code
claude      # Restart

# Then verify:
/help       # Should show all new commands
```

**Installation path:** Plugins install to `~/.claude/plugins/cache/[plugin-name]/`, NOT `~/.claude/skills/`

### 10. Installation Testing Workflow

**Always test clean install:**
```bash
# Remove for clean test
/plugin uninstall plugin-name

# Test installation
/plugin install plugin-name@marketplace

# RESTART Claude Code
exit && claude

# Verify
/help  # Should show all commands
ls ~/.claude/plugins/cache/plugin-name/  # Should have all files
cat ~/.claude/plugins/cache/plugin-name/.claude-plugin/manifest.json  # Check version
```

## Process Improvements

### What Worked Well

1. **TDD methodology** - Found 3 gaps through pressure testing
2. **Two-repo structure** - Clean separation of catalog and content
3. **Superpowers pattern** - Copying proven structure saved time
4. **Documentation** - TEST_RESULTS.md provided evidence
5. **Iterative testing** - Multiple rounds caught edge cases

### What Could Be Better

1. **Schema validation earlier** - Could have validated marketplace.json schema before pushing
2. **Slash commands from start** - Should have known this requirement upfront
3. **Installation testing** - Should test immediately after creation

## Checklist for Future Skills

**Before starting:**
- [ ] Study superpowers examples
- [ ] Understand two-repo structure
- [ ] Know marketplace.json schema

**During creation:**
- [ ] Write pressure tests FIRST (RED phase)
- [ ] Document baseline failures with quotes
- [ ] Write minimal skill (GREEN phase)
- [ ] Create slash command immediately
- [ ] Test with refactoring (REFACTOR phase)
- [ ] Create TEST_RESULTS.md

**Before publishing:**
- [ ] Word count <1000 (check: `wc -w SKILL.md`)
- [ ] Slash command in commands/
- [ ] Manifest links skill to command
- [ ] marketplace.json schema correct
- [ ] **CRITICAL: Git tag BOTH repos** (skills + marketplace)
- [ ] Tags pushed to remote
- [ ] Clean install tested
- [ ] **CRITICAL: Restart Claude Code after install**
- [ ] Shows in `/help` after restart

## Key Insights

1. **Skills ≠ Slash Commands** - Skills auto-activate, slash commands show in `/help`
2. **Schema is strict** - Must match superpowers exactly
3. **Testing is mandatory** - No skill without RED-GREEN-REFACTOR
4. **Two repos required** - Catalog + Content separation
5. **Verification safeguards** - Platform-specific skills need boundaries
6. **Documentation proves quality** - TEST_RESULTS.md is not optional
7. **Git tags are mandatory** - Plugin system fetches tags, not main branch. Tag BEFORE users install
8. **Restart required** - Slash commands only load at Claude Code startup
9. **Update ≠ Upgrade** - `/plugin update` only finds NEW plugins, not version updates
10. **Installation path** - Plugins live in `~/.claude/plugins/cache/`, not `~/.claude/skills/`

## Resources Created

**Repositories:**
- Marketplace: github.com/imehr/imehr-marketplace
- Skills: github.com/imehr/skills

**Documentation:**
- INSTALLATION_GUIDE.md - User installation guide
- MARKETPLACE_COMPLETE.md - Complete setup summary
- TEST_RESULTS.md - Railway skill testing
- VERIFICATION_TESTS.md - Safeguard testing

**Skills:**
- Railway deployment (820 words, tested, verified)
- Building skills marketplace (this skill)

---

**Bottom line:** Follow the pattern, test first, verify schema, add slash commands, and document everything.
