# Content Capture - From Work to Published Content

Transform interesting work into publishable content through a 10-18 minute journalist-style interview.

## Problem Solved

"I do interesting work but it never becomes content." This skill solves the friction between doing work and sharing it.

## What It Does

1. **Automatic Detection**: Hook detects interesting work at session end
2. **Guided Interview**: 8-12 questions extract what matters and why
3. **Content Generation**: Generates Twitter threads, LinkedIn posts, with character validation
4. **Publishing Integration**: Scripts for validation, publishing (bird CLI), and engagement tracking
5. **Performance Optimization**: High-engagement content feeds synthesis priorities

## Time Investment

- Interview: 3-5 minutes
- Visual capture: 2-3 minutes
- Refinement: 5-10 minutes
- **Total: 10-18 minutes** from session work to ready-to-publish draft

## Quick Start

```bash
# Install (from marketplace)
/plugin install content-capture@imehr-marketplace

# Run installation script
cd ~/.claude/skills/content-capture
./install.sh

# Restart Claude Code

# Use it
/capture-content
```

## Usage

```bash
/capture-content           # Full interview (8-12 questions)
/capture-content quick     # Shorter version (6-8 questions)
/capture-content synthesis # For synthesis/framework content
```

## When to Use

✅ Use when you've:
- Solved a significant problem
- Built or updated a system
- Discovered a tool/workflow through hands-on testing
- Had a meaningful realization with concrete examples
- 20+ minutes of substantive work
- Content can be shared publicly

❌ Skip when:
- Work is confidential/NDA
- Just reading documentation (no original work)
- Less than 10 minutes of work
- Session still in progress

See [SKILL.md](./SKILL.md) for complete Quick Reference table.

## Publishing Workflow

```
/capture-content
↓
Answer interview questions (3-5 min)
↓
Draft generated with character analysis
↓
bird-save-draft.sh <name> <content> [screenshot]
↓
Review and trim over-limit tweets
↓
bird-publish-draft.sh <draft-folder>
↓
Track engagement (24-48h later)
↓
bird-track-engagement.sh <draft-folder>
↓
High performers → synthesis priority queue
```

## Requirements

- **Claude Code**: v2.1.0+
- **bird CLI**: v0.5.1+ ([install](https://github.com/steipete/bird))
- **jq**: `brew install jq`
- **Twitter/X**: Logged in via browser (for cookie auth)

## Installation

### Via Marketplace (Recommended)

```bash
/plugin install content-capture@imehr-marketplace
cd ~/.claude/skills/content-capture
./install.sh
```

### Manual Installation

```bash
# Clone or download skill files
git clone https://github.com/imehr/skills
cd skills/workflows/content-capture

# Run installer
./install.sh

# Follow prompts to configure hooks
```

## Components

### 1. Skill (`/capture-content`)
- Journalist-style interview (8-12 questions)
- Extracts: what, why, who-cares, visual proof
- Generates Twitter threads, LinkedIn posts

### 2. Detection Hook
- Automatically runs at session end
- Scans for 10 signal patterns
- Prompts when 3+ signals detected

### 3. Publishing Scripts
- `bird-save-draft.sh` - Character validation
- `bird-publish-draft.sh` - Threaded publishing
- `bird-track-engagement.sh` - Metrics tracking

### 4. Performance Loop
- Track engagement after 24-48h
- High performers (50+ score) → synthesis queue
- Optimize future topic selection

## File Structure

```
content-capture/
├── SKILL.md                 # Main skill (<1000 words)
├── TEST_RESULTS.md          # Testing documentation
├── README.md                # This file
├── install.sh               # Installation script
├── scripts/
│   ├── hook.sh             # Session detection
│   ├── save-draft.sh       # Character validation
│   ├── publish-draft.sh    # Publishing
│   └── track-engagement.sh # Metrics
└── docs/
    ├── reference.md        # Complete interview flow
    ├── examples.md         # Workflow examples
    └── troubleshooting.md  # Common issues
```

## Documentation

- **[SKILL.md](./SKILL.md)** - Complete skill documentation
- **[TEST_RESULTS.md](./TEST_RESULTS.md)** - Testing methodology and results
- **[docs/examples.md](./docs/examples.md)** - Full workflow examples
- **[docs/troubleshooting.md](./docs/troubleshooting.md)** - Common issues and solutions
- **[docs/reference.md](./docs/reference.md)** - Complete interview flow

## Testing

Tested with RED-GREEN-REFACTOR methodology:
- ✅ Complex implementation (2+ hours)
- ✅ Simple tool evaluation
- ✅ Documentation reading (skip)
- ✅ False positive prevention
- ⚠️ Failed experiments (partially tested)

See [TEST_RESULTS.md](./TEST_RESULTS.md) for complete test scenarios.

## Example Output

**Input**: 2 hours implementing content capture system

**Interview extracts**:
- Problem: Skill structure format issues
- Solution: Directory-based with uppercase SKILL.md
- Insight: Single-file vs directory formats
- Audience: Others installing custom skills

**Generated content**: Twitter thread with:
- Hook: "Spent 2 hours figuring out why my Claude Code skill wouldn't load..."
- Process: Directory structure requirements
- Insight: SKILL.md must be uppercase
- Proof: Working `/capture-content` command

## Integration

### With Automatic Detection
Hook runs at session end, prompts when interesting work detected.

### With Publishing
Bird CLI integration for Twitter threading, character validation.

### With Performance Tracking
Engagement metrics feed synthesis priority queue for topic optimization.

### With Other Skills
- Works with episodic-memory for recalling past captures
- Complements writing-clearly-and-concisely for long-form content
- Feeds brainstorming for content strategy

## Troubleshooting

**Skill not appearing**:
- Ensure directory structure: `~/.claude/skills/content-capture/SKILL.md`
- SKILL.md must be uppercase
- Restart Claude Code

**Hook not triggering**:
- Check `~/.claude/settings.json` has hooks configured
- Verify hook file is executable: `chmod +x ~/.claude/hooks/content-capture-trigger.sh`
- Restart Claude Code

**Bird CLI authentication**:
- Log into x.com in Chrome/Safari/Firefox
- Bird uses browser cookies automatically
- Run `bird whoami` to verify

See [docs/troubleshooting.md](./docs/troubleshooting.md) for more.

## Contributing

Found a bug or have a suggestion?
1. Test your scenario
2. Document expected vs actual behavior
3. Submit issue to [imehr/skills](https://github.com/imehr/skills)

## Credits

- **Original concept**: [elrolio](https://gist.github.com/elrolio/9485c69c55875c0af2c6e6786521f5a2)
- **Marketplace adaptation**: [imehr](https://github.com/imehr)
- **Bird CLI**: [@steipete](https://github.com/steipete/bird)

## License

MIT License - See LICENSE file

## Category

`workflows/content-capture`

## Version

1.0.0

---

**Ready to turn your work into content? Install and run `/capture-content`** 🚀
