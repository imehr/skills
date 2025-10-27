---
name: your-skill-name
description: Use when [specific triggers, symptoms, error messages user will see] - [what this skill does and how it helps, in third person]
---

# Skill Title

## ⚠️ VERIFICATION REQUIRED (if platform/tool-specific)

**BEFORE using this skill, verify:**

1. **User explicitly mentions "[Platform/Tool]"** in their request, OR
2. **Check for artifacts:**
   - `config-file.json` exists
   - `.platform-dir/` exists
3. **When in doubt, ASK:** "Are you using [Platform/Tool]?"

**DO NOT use this skill for:**
- [Competing platforms/tools]
- [Similar but different use cases]

## Overview

[1-2 sentence description of what this skill provides]

**Core principle:** [The fundamental approach or rule this skill follows]

## When to Use

**ONLY after verifying [conditions], use this skill when you see:**
- User explicitly says "[keyword]"
- "[symptom]" or "[error message]"
- "[specific problem pattern]"

## When NOT to Use

**NEVER use this skill for:**
- [Platform A, Platform B, Platform C]
- Generic "[topic]" questions (ask which [platform/tool] first)
- [Specific excluded scenarios]
- **When [condition] is unclear** - ASK THE USER FIRST

**If uncertain, verify first:**
```bash
# Check for [platform] configuration
ls config-file.json .platform-dir/
# If files don't exist → NOT using [platform] → DON'T use this skill
```

## Quick Reference

| Task | Command/Pattern |
|------|----------------|
| [Common task 1] | `command-example` |
| [Common task 2] | `command-example` |
| [Common task 3] | `command-example` |
| [Common task 4] | `command-example` |

## Project Verification (if applicable)

**Before running ANY [platform] commands, verify:**

```bash
# Method 1: Check for config files
ls config-file.json

# Method 2: Check if linked
platform-cli status

# Method 3: Ask user
# "Are you using [Platform], or another [alternative]?"
```

**If no artifacts found → ASK USER before proceeding.**

## Essential Patterns

**[Workflow Name]:**
```bash
# Step-by-step commands with inline comments
command-one && command-two
```

**[Another Workflow]:**
```bash
# Another common pattern
command-example
```

## Common Mistakes

**1. [Mistake description]** - [impact and correct approach]
**2. [Mistake description]** - [impact and correct approach]
**3. [Mistake description]** - [impact and correct approach]

## Additional Resources

**Detailed documentation in supporting files:**
- **[reference.md](reference.md)** - [What's in this file]
- **[examples.md](examples.md)** - [What's in this file]
- **[troubleshooting.md](troubleshooting.md)** - [What's in this file]

**Official resources:**
- **Docs:** [URL]
- **Status:** [URL]
- **Community:** [URL]

## Best Practices

- **[Practice 1]:** [description]
- **[Practice 2]:** [description]
- **[Practice 3]:** [description]

## When [Critical Scenario] Happens

**CRITICAL: [Core principle for this scenario]**

1. `command-one` - [what this checks]
2. `command-two` - [what this checks]
3. `command-three` - [what this does]

**[Important safety note]**

---

## Notes for Skill Authors

**Delete this section before submitting!**

**Required Testing:**
- Create TEST_RESULTS.md with 3+ pressure scenarios
- Test with time pressure, sunk cost, authority pressure, exhaustion
- Document agent quotes showing skill compliance
- Test false-positive prevention (if platform-specific)

**Word Count Target:**
- Main SKILL.md: <1000 words (ideally <500)
- Check with: `wc -w SKILL.md`
- Move heavy content to reference.md, examples.md, troubleshooting.md

**Verification Checklist:**
- [ ] YAML frontmatter (name, description)
- [ ] Description starts with "Use when..."
- [ ] "When to Use" and "When NOT to Use"
- [ ] Quick Reference table
- [ ] Common Mistakes section
- [ ] TEST_RESULTS.md exists
- [ ] Word count <1000
