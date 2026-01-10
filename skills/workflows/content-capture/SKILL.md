---
name: capture-content
description: Use when you've done interesting work but don't know how to articulate it - journalist-style interview extracts publishable content through structured questions
---

# Content Capture - From Work to Published Content

## Purpose

You just built something, solved a problem, or discovered an insight. It's interesting, but you don't know how to talk about it yet. This skill acts as a journalist interviewing you to extract:
- What you accomplished and why it matters
- Who else cares and how to frame it
- What visuals prove it worked
- Draft content ready for publishing

**Problem solved**: "I do interesting work but it never becomes content"
**Time**: 10-18 minutes from session work to ready-to-publish draft

## When to Use

Use `/capture-content` when you've:
- ✅ Solved a significant problem (not trivial bug fixes)
- ✅ Built or updated a system
- ✅ Discovered an interesting tool/workflow through hands-on testing
- ✅ Had a meaningful realization with concrete examples
- ✅ Completed interesting analysis or synthesis work
- ✅ Work is 20+ minutes of substantive effort
- ✅ Content can be shared publicly

## When NOT to Use

Skip `/capture-content` when:
- ❌ Session was purely exploratory (no concrete outcome)
- ❌ Work is confidential, under NDA, or company-proprietary
- ❌ You haven't actually completed anything yet (premature capture)
- ❌ Less than 10 minutes of substantive work
- ❌ Content would require extensive private context to understand
- ❌ Just reading documentation (no original work produced)
- ❌ Creating long-form blog posts (use direct writing instead)
- ❌ Quick status updates (write directly, no interview needed)

## Quick Reference

| Scenario | Use? | Reason |
|----------|------|--------|
| Built feature in 2+ hours | ✅ | Substantial work, clear outcome |
| Fixed interesting bug | ✅ | Problem-solution story |
| Evaluated 3+ tools hands-on | ✅ | Comparative insights |
| Read documentation | ❌ | No original work |
| NDA/proprietary project | ❌ | Cannot share publicly |
| 10-min quick fix | ⚠️ | Only if broadly applicable |
| Tool discovery without testing | ❌ | Insufficient depth |
| Session still in progress | ❌ | Wait for completion |

## Interview Process

The skill asks 8-12 questions across 4 phases:

**Phase 1: What Happened** (3-4 questions)
- What were you working on?
- What specific tools/approaches did you use?
- Walk me through the key moment

**Phase 2: Why It Matters** (2-3 questions)
- What surprised you?
- Why is this different from usual?
- Who else struggles with this?

**Phase 3: Content Strategy** (2-3 questions)
- What's the single most important insight?
- Is this "behind-the-scenes" or "framework teaching"?
- What would make someone else care?

**Phase 4: Visual Capture** (1-2 questions)
- What should be screenshotted?
- Would a screen recording add value?

See [reference.md](./reference.md) for complete interview flow example.

## Output Formats

After the interview, generates:

**Twitter/X Thread** (7-12 tweets)
- Hook, process breakdown, key insight, call to action
- Character validation shows over-limit tweets
- Publishing via bird CLI integration

**LinkedIn Post** (1,800-2,100 characters)
- Concrete opening, process, insight, implication

**Quote-Tweet Addition** (for synthesis content)
- Technical commentary, implementation experience

**Screenshot/Video Script**
- What to capture, how to annotate, what to highlight

## Usage

```bash
/capture-content                    # Full interview
/capture-content quick              # Shorter version (6-8 questions)
/capture-content synthesis          # For synthesis/framework content
/capture-content "solved bug"       # With context hint
```

## Publishing Workflow

1. **Interview** (3-5 min): Answer questions in Claude Code
2. **Draft generation**: Skill generates content + character analysis
3. **Validation**: `bird-save-draft.sh` shows over-limit tweets
4. **Review**: Trim over-limit tweets, capture visuals
5. **Publish**: `bird-publish-draft.sh` posts threaded tweets
6. **Track** (24-48h later): `bird-track-engagement.sh` measures performance
7. **Optimize**: High performers feed into synthesis priority queue

See [examples.md](./examples.md) for complete workflow examples.

## Common Mistakes

**1. Capturing too early**
- ❌ Running `/capture-content` before work is complete
- ✅ Wait until you have a concrete outcome or insight

**2. Over-explaining private context**
- ❌ "Our proprietary system for handling X that does Y..."
- ✅ "A caching system that solved Z problem..."

**3. Generating content without clear audience**
- ❌ "I did this thing and it was interesting"
- ✅ Interview guides you to "Who else struggles with this?"

**4. Skipping character validation**
- ❌ Publishing tweets over 280 characters (they get rejected)
- ✅ Always run `bird-save-draft.sh` first to see character counts

**5. Not tracking engagement**
- ❌ Publishing once and never reviewing what worked
- ✅ Track after 24-48h to inform next topics

**6. Answering generically**
- ❌ "I used AI tools to help" (vague, no insight)
- ✅ "I used Claude Code + bird CLI + jq for..." (specific, actionable)

**7. Skipping visuals**
- ❌ Text-only threads without proof
- ✅ Screenshots show the actual work, not stock images

## Integration

**Automatic Detection**:
- Hook detects 3+ signals in session transcript ("solved", "created", "implemented")
- Prompts at session end: "🎯 CONTENT CAPTURE OPPORTUNITY DETECTED"
- Suggests running `/capture-content` while context is fresh

**Publishing Tools**:
- `bird-save-draft.sh` - Character validation for Twitter limits
- `bird-publish-draft.sh` - Threaded tweet publishing via bird CLI
- `bird-track-engagement.sh` - Metrics tracking and synthesis priorities

**Performance Optimization**:
- High engagement (50+ score) → Added to synthesis priority queue
- Signals validated audience interest
- Prioritize similar topics for next content

## Requirements

- Claude Code v2.1.0+
- bird CLI v0.5.1+ (`npm install -g @steipete/bird`)
- jq (`brew install jq`)
- Twitter/X account (logged in via browser for cookie auth)

## Installation

See [../README.md](../README.md) for complete installation instructions.

## Troubleshooting

See [troubleshooting.md](./troubleshooting.md) for common issues and solutions.

---

**Credits**: Based on [elrolio's content capture system](https://gist.github.com/elrolio/9485c69c55875c0af2c6e6786521f5a2)
**License**: MIT
**Category**: workflows/content-capture
