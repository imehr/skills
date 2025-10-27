# Skill Template

Use this template when creating a new skill for the marketplace.

## Quick Start

1. **Copy this template:**
   ```bash
   cp -r skills/TEMPLATE skills/[category]/[your-skill-name]
   ```

2. **Fill in SKILL.md:**
   - Update YAML frontmatter (name, description)
   - Replace all `[placeholders]` with your content
   - Delete the "Notes for Skill Authors" section
   - Keep word count <1000 (check with `wc -w SKILL.md`)

3. **Add supporting files (optional):**
   ```bash
   touch skills/[category]/[your-skill-name]/reference.md
   touch skills/[category]/[your-skill-name]/examples.md
   touch skills/[category]/[your-skill-name]/troubleshooting.md
   ```

4. **Test your skill:**
   - Create 3+ pressure scenarios
   - Test with subagents using Task tool
   - Document results in TEST_RESULTS.md
   - Include agent quotes showing compliance

5. **Submit:**
   - Update README.md with your skill
   - Update .claude-plugin/manifest.json
   - Create PR following CONTRIBUTING.md

## Template Structure

**SKILL.md sections:**
- ⚠️ Verification Required (if platform-specific)
- Overview
- When to Use
- When NOT to Use
- Quick Reference
- Project Verification (if applicable)
- Essential Patterns
- Common Mistakes
- Additional Resources
- Best Practices
- When [Critical Scenario]

## Required Testing

**Minimum requirements:**
- 3+ pressure scenarios combining:
  - Time pressure
  - Sunk cost
  - Authority pressure
  - Exhaustion
  - Missing context
- TEST_RESULTS.md with agent quotes
- False-positive prevention tests (if platform-specific)

## Word Count Guidelines

**Main SKILL.md:**
- Target: <500 words
- Maximum: 1000 words
- Check: `wc -w SKILL.md`

**Supporting files:**
- Unlimited
- reference.md: Complete API/CLI reference
- examples.md: Real-world workflows, scripts
- troubleshooting.md: Error diagnosis and solutions

## Examples

See existing skills for reference:
- **[railway](../deployment/railway/)** - Platform-specific with verification
- More skills coming soon!

## Questions?

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for detailed guidelines.
