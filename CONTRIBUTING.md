# Contributing to Skills Marketplace

Thank you for your interest in contributing! This marketplace follows strict quality standards to ensure all skills are production-ready and battle-tested.

## Quality Standards

### Required Testing

All skills must be tested using the **RED-GREEN-REFACTOR** methodology from superpowers:writing-skills:

1. **GREEN Phase**: Test skill with pressure scenarios
2. **REFACTOR Phase**: Identify gaps and fix
3. **Document**: Create TEST_RESULTS.md with evidence

**Minimum Requirements:**
- ✅ 3+ pressure scenarios combining multiple stressors
- ✅ Test results documented with agent quotes
- ✅ False-positive prevention tests (where applicable)

### Required Structure

**YAML Frontmatter:**
```yaml
---
name: skill-name
description: Use when [specific triggers and symptoms] - [what it does in third person]
---
```

**Required Sections:**
1. Overview with core principle
2. When to Use (with specific symptoms)
3. When NOT to Use
4. Quick Reference (table or bullets)
5. Essential Patterns/Workflows
6. Common Mistakes
7. Additional Resources (cross-references)

**Optional but Recommended:**
- Best Practices
- Emergency Checklist
- Project Verification (for platform-specific skills)

### Token Efficiency

- **Main SKILL.md**: <1000 words (ideally <500)
- **Supporting files**: Unlimited (reference.md, examples.md, troubleshooting.md)
- **Heavy content**: Move to supporting files, cross-reference in main skill

### Verification Safeguards

**Platform-specific skills must include:**
- Verification requirements at top
- Project artifact checks
- "Ask user when uncertain" guidance
- Explicit boundary list (competing platforms)

**Example from Railway skill:**
```markdown
## ⚠️ VERIFICATION REQUIRED

**BEFORE using this skill, verify the project uses Railway:**
1. User explicitly mentions "Railway", OR
2. Check for railway.json, railway.toml, .railway/ directory
3. When in doubt, ASK: "Is this project deployed to Railway?"
```

## Contribution Process

### 1. Choose Category

Select the appropriate category for your skill:
- `deployment/` - Platform-specific deployment (Railway, Vercel, AWS, Fly.io)
- `infrastructure/` - Databases, caching, monitoring, logging
- `development/` - Languages, frameworks, tools (React, Python, Rust)
- `workflows/` - CI/CD, testing, git workflows

Not sure? Open an issue to discuss!

### 2. Create Skill Structure

```bash
# Create directory
mkdir -p skills/[category]/[skill-name]

# Create main skill file
touch skills/[category]/[skill-name]/SKILL.md

# Create supporting files (as needed)
touch skills/[category]/[skill-name]/reference.md
touch skills/[category]/[skill-name]/examples.md
touch skills/[category]/[skill-name]/troubleshooting.md

# Document testing (required)
touch skills/[category]/[skill-name]/TEST_RESULTS.md
```

### 3. Write and Test Skill

**Following TDD methodology:**

1. **Write pressure scenarios** (3+ combining multiple stressors)
2. **Test with subagents** (use Task tool with general-purpose)
3. **Document results** with agent quotes in TEST_RESULTS.md
4. **Identify gaps** from testing
5. **Fix gaps** and re-test
6. **Repeat** until bulletproof

**Pressure types to combine:**
- Time pressure (urgency, production down)
- Sunk cost (already invested effort)
- Authority pressure (manager/senior asked for it)
- Exhaustion (debugging for hours)
- Missing context (unclear requirements)

### 4. Verify Quality

**Checklist before submitting:**
- [ ] YAML frontmatter with name and description
- [ ] Description starts with "Use when..."
- [ ] "When to Use" and "When NOT to Use" sections
- [ ] Quick Reference table
- [ ] Common Mistakes section
- [ ] Word count <1000 (check with `wc -w SKILL.md`)
- [ ] TEST_RESULTS.md with 3+ pressure scenarios
- [ ] Gaps identified and fixed
- [ ] Supporting files for heavy content

**For platform-specific skills:**
- [ ] Verification requirements at top
- [ ] Project artifact checks
- [ ] "Ask user when uncertain" guidance
- [ ] False-positive prevention tests

### 5. Submit Pull Request

1. Fork this repository
2. Create branch: `git checkout -b add-skill-[name]`
3. Add your skill to appropriate category
4. Update README.md with skill entry
5. Commit: `git commit -m "Add [skill-name] skill"`
6. Push: `git push origin add-skill-[name]`
7. Open PR with description:
   - What problem the skill solves
   - Testing summary (scenarios passed)
   - Word count
   - Category justification

## PR Review Process

**Reviewers will check:**
1. ✅ Testing documentation (TEST_RESULTS.md exists)
2. ✅ Pressure scenarios evidence (agent quotes)
3. ✅ Required structure (YAML, sections)
4. ✅ Token efficiency (word count)
5. ✅ Verification safeguards (if platform-specific)
6. ✅ False-positive prevention (if applicable)

**Common rejection reasons:**
- ❌ No testing documentation
- ❌ Missing "When NOT to Use"
- ❌ Over 1000 words without justification
- ❌ Platform-specific skill without verification
- ❌ No pressure testing evidence

## Maintenance

**After your skill is merged:**
- You're the maintainer unless you request otherwise
- Respond to issues related to your skill
- Update based on user feedback
- Test updates with same rigor as original

## Skill Naming Conventions

**Use active voice, verb-first:**
- ✅ `deploying-to-railway` not `railway-deployment`
- ✅ `debugging-with-chrome` not `chrome-debugging-tools`

**Use hyphens, not underscores:**
- ✅ `railway-deployment` not `railway_deployment`

**No special characters:**
- ✅ `railway` not `railway!` or `(railway)`

## Questions?

- **General questions**: Open a [Discussion](https://github.com/imehr/skills/discussions)
- **Bug reports**: Open an [Issue](https://github.com/imehr/skills/issues)
- **Contribution ideas**: Open a [Discussion](https://github.com/imehr/skills/discussions) first

## Code of Conduct

- Be respectful and constructive
- Focus on skill quality, not ego
- Value evidence over opinions
- Help others improve their skills

---

**Thank you for contributing!** Your skills help developers worldwide work more effectively with Claude Code.
