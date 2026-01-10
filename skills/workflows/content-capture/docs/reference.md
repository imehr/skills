# Content Capture - Complete Interview Reference

This document shows a complete interview interaction from start to finish.

---

## Interview Structure

The skill conducts interviews in 4 phases with 8-12 questions total. Questions adapt based on your answers.

---

## Complete Interview Example

### Context
User just finished implementing content capture system - 2 hours of work setting up hook, skill, and publishing scripts. Encountered and solved skill structure format issue.

---

### Phase 1: What Happened (3-4 questions)

```
Assistant: I noticed this session involved implementing a content capture system. Let's capture this as content.

**Phase 1: What Happened**

Q1: What were you trying to accomplish when you started this session?

User: I wanted to set up the content capture system from a GitHub gist. The goal was to make it easier to turn my Claude Code sessions into Twitter threads without spending hours writing them.

---

Q2: What specific tools or approaches did you use? Please name them specifically.

User: I used Claude Code skills (directory-based structure), SessionEnd hooks to detect interesting work, bird CLI for Twitter publishing, and jq for JSON processing. Also packaged bash scripts for the publishing workflow.

---

Q3: Walk me through the key moment - what exactly happened that made this work or not work?

User: The skill wouldn't show up in autocomplete. I created it as a single file called `capture-content` but Claude Code didn't recognize it. Spent 30 minutes debugging. Finally discovered it needs to be a directory with an uppercase `SKILL.md` file inside, plus YAML frontmatter. Once I fixed that and restarted Claude Code, `/capture-content` appeared immediately.

---

Q4: How long did this take, and were there any unexpected challenges?

User: About 2 hours total. The unexpected part was the skill structure format - the documentation doesn't clearly explain the two different formats (single-file with namespace vs directory-based). The error handling is silent, so you just get nothing when it fails.
```

### Phase 2: Why It Matters (2-3 questions)

```
**Phase 2: Why It Matters**

Q5: What surprised you most about this experience?

User: That Claude Code has two completely different skill formats and the choice isn't obvious. Single-file skills need a namespace like `episodic-memory:search-conversations`, but directory-based skills need uppercase `SKILL.md`. No error messages guide you - it just silently fails if you get it wrong.

---

Q6: Why is this different from how it usually works in other tools or systems?

User: Most CLI tools have one installation format. They also give you error messages when things fail. This has multiple formats with silent failures. It's like if VS Code extensions could be .vsix OR a directory structure, and the extension just wouldn't load if you picked the wrong one, with no explanation.

---

Q7: Who else is likely struggling with this same problem?

User: Anyone installing custom Claude Code skills for the first time. Especially developers coming from other extensible tools (VS Code, Sublime, vim) who expect consistent patterns and helpful error messages. The silent failure is what makes it painful.
```

### Phase 3: Content Strategy (2-3 questions)

```
**Phase 3: Content Strategy**

Q8: What's the single most important insight from this experience?

User: Skill file structure matters in Claude Code - you need uppercase SKILL.md for directory-based skills, lowercase for single-file with namespaces. Get it wrong and Claude Code silently ignores your skill. No feedback, no errors, just nothing.

---

Q9: Is this more of a "behind-the-scenes reveal" (how you built something) or "framework teaching" (here's how this system works)?

User: It's both. It shows the behind-the-scenes of implementing content capture, BUT the main value is teaching others how skill installation actually works, especially the gotchas that aren't documented.

---

Q10: Which writing style fits this best: Technical Observer (nuanced analysis), Enthusiastic Builder (it actually worked!), or Framework Teacher (here's the system)?

User: Mix of Technical Observer and Enthusiastic Builder. The "here's what went wrong and why" is Observer, but "and here's what finally worked!" is Builder. It's a debugging story with a happy ending.
```

### Phase 4: Visual Capture (1-2 questions)

```
**Phase 4: Visual Capture**

Q11: What should be screenshotted to prove this worked?

User: The `/capture-content` command appearing in Claude Code's autocomplete. That's the proof - before the fix, it was invisible. After the fix, it shows up with the description. That before/after is the visual story.

---

Q12: Would a 30-second screen recording add value? What would it show?

User: Maybe. Could show typing `/capture`, nothing appears, then fixing the SKILL.md filename, restarting Claude Code, typing `/capture` again and seeing it appear. But honestly a screenshot of the working autocomplete is probably enough. Video feels like overkill for this.
```

---

## Draft Generation

```
**Draft Generation**

Based on your answers, I'll generate a Twitter thread:

**Format**: Twitter/X Thread (7 tweets)
**Style**: Technical Observer + Enthusiastic Builder
**Hook**: Silent failure debugging story
**Visual**: Screenshot of /capture-content in autocomplete

[Generated content would appear here - see examples.md for the actual thread]

**Next Steps**:
1. Save this content using: `bird-save-draft.sh skill-structure thread.txt screenshot.png`
2. Character validation will show which tweets need trimming
3. Edit ~/drafts/TIMESTAMP-skill-structure/content.txt to fix over-limit tweets
4. Publish using: `bird-publish-draft.sh TIMESTAMP-skill-structure`
5. Track engagement after 24-48h: `bird-track-engagement.sh TIMESTAMP-skill-structure`
```

---

## Interview Patterns

### Question Adaptation

The interview adapts based on your answers:

**If you mention a failure**:
- Adds: "What did you try before finding the solution?"
- Adds: "What would you tell your past self?"

**If you mention specific tools**:
- May ask: "How does this compare to alternatives?"
- May skip: Generic "what tools did you use" if already covered

**If answer is very short**:
- Follows up: "Can you be more specific?"
- Example: "I fixed a bug" → "What bug? How did you fix it?"

**If answer is very long**:
- Moves on without follow-up
- Assumes you've covered the territory

### Time Investment

**Typical interview**: 3-5 minutes
- 8-12 questions
- 30-45 seconds per answer
- Faster if you're concise

**Quick mode** (`/capture-content quick`): 2-3 minutes
- 6-8 questions
- Skips visual capture questions
- Jumps straight to key insights

---

## Question Bank

The skill has a library of questions it can ask. Here are the most common:

### What Happened
- What were you working on when [event] happened?
- What specific tools/approaches did you use?
- What was the problem you were trying to solve?
- Walk me through the key moment - what exactly did you do?
- How long did this take?
- What unexpected challenges came up?

### Why It Matters
- What surprised you about this?
- Why is this different from how it usually works?
- What does this say about [broader trend/pattern]?
- Who else struggles with this problem?
- What would have saved you time here?

### Content Strategy
- Is this a "behind-the-scenes reveal" or "framework teaching" moment?
- What's the single most important insight here?
- What would make someone else care about this?
- What writing style cluster fits this best?
- Is this more "here's what I built" or "here's what I learned"?
- What's the practical takeaway for readers?

### Visual Capture
- What should be screenshotted to show this?
- Would a 30-second screen recording add value?
- What's the visual "proof" that this worked?
- What would you highlight or annotate?

---

## Tips for Great Answers

### Be Specific
❌ "I used AI tools to help"
✅ "I used Claude Code with the capture-content skill, bird CLI, and jq"

### Include Context
❌ "It took a while"
✅ "About 2 hours, with 30 minutes spent debugging the skill structure"

### Name The Problem
❌ "It wasn't working"
✅ "The skill file wasn't loading because I used lowercase skill.md instead of uppercase SKILL.md"

### Identify The Audience
❌ "People who code"
✅ "Developers installing custom Claude Code skills for the first time"

### Concrete Over Abstract
❌ "I learned about software patterns"
✅ "I learned Claude Code has two skill formats: single-file with namespace or directory with SKILL.md"

---

## What Happens After Interview

1. **Content generation** (30 seconds)
   - Analyzes your answers
   - Identifies key insights
   - Generates appropriate format (Twitter/LinkedIn/etc.)
   - Applies your writing style

2. **Character validation** (if Twitter)
   - Shows which tweets are over 280 chars
   - Provides trimming suggestions
   - Highlights tight-space tweets (275-280 chars)

3. **Publishing guidance**
   - Commands to run for saving draft
   - Where to find generated content
   - How to edit and publish
   - When to track engagement

4. **Visual instructions**
   - What to screenshot or record
   - How to capture it
   - Where it should appear in content

---

## Customizing The Interview

### Skip Questions
If a question doesn't apply:
"Skip - not relevant to this" or "N/A"

The skill will move on.

### Add Context Mid-Interview
Feel free to add extra details:
"Also, I should mention that..." 

The skill incorporates new information.

### Change Direction
If you realize the content angle should be different:
"Actually, the more interesting part is..."

The skill adapts.

---

## After The Interview

You'll receive:
- ✅ Generated content (Twitter thread / LinkedIn post / etc.)
- ✅ Character analysis (if Twitter)
- ✅ Publishing commands to run
- ✅ Visual capture instructions
- ✅ Next steps checklist

**Typical workflow**:
1. Review generated content (1-2 min)
2. Run bird-save-draft.sh (30 sec)
3. Trim over-limit tweets (2-3 min)
4. Capture screenshot (1-2 min)
5. Run bird-publish-draft.sh (1 min)
6. Track after 24-48h (1 min)

**Total time**: 10-18 minutes from interview to published thread.

---

## Questions About The Interview?

See:
- [examples.md](./examples.md) for complete workflow examples
- [troubleshooting.md](./troubleshooting.md) if interview isn't working
- [SKILL.md](../SKILL.md) for usage guidance and Quick Reference
