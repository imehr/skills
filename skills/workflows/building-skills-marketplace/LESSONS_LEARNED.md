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

### 7. Git Tagging Is Essential

**Version releases:**
```bash
git tag -a v1.0.0 -m "Release v1.0.0 - Description"
git push origin v1.0.0
```

**Marketplace references versions:**
```json
{
  "plugins": [{
    "version": "1.0.0"  // Must match git tag
  }]
}
```

### 8. Installation Testing Workflow

**Always test clean install:**
```bash
# Backup existing
cp -r ~/.claude/skills/[skill] ~/backups/

# Remove for clean test
rm -rf ~/.claude/skills/[skill]

# Test installation
/plugin marketplace add owner/marketplace
/plugin install plugin@marketplace

# Verify
/help  # Should show command
ls ~/.claude/skills/  # Should have skill
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
- [ ] Git tagged (v1.0.0)
- [ ] Clean install tested
- [ ] Shows in `/help`

## Key Insights

1. **Skills ≠ Slash Commands** - Skills auto-activate, slash commands show in `/help`
2. **Schema is strict** - Must match superpowers exactly
3. **Testing is mandatory** - No skill without RED-GREEN-REFACTOR
4. **Two repos required** - Catalog + Content separation
5. **Verification safeguards** - Platform-specific skills need boundaries
6. **Documentation proves quality** - TEST_RESULTS.md is not optional

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
