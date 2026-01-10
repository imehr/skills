# Content Capture - Workflow Examples

Complete end-to-end examples showing the content capture system in action.

---

## Example 1: Feature Implementation → Twitter Thread

### Session Work
- Built content capture system (2 hours)
- Installed hook, skill, and publishing scripts
- Encountered skill structure format issue
- Solved by converting to directory-based format

### Interview (5 minutes)
**Q: What were you working on?**
A: Implementing content capture system from a GitHub gist to help turn coding sessions into Twitter content.

**Q: What specific tools did you use?**
A: Claude Code skills, SessionEnd hooks, bird CLI for Twitter publishing, jq for JSON processing.

**Q: Walk me through the key moment?**
A: The skill wouldn't load. Spent 30 minutes debugging. Discovered it needs to be a directory with uppercase SKILL.md, not a single file.

**Q: What surprised you?**
A: Claude Code has two skill formats - single-file with namespace (namespace:skillname) or directory-based with SKILL.md uppercase. The docs don't make this super clear.

**Q: Why is this different from usual?**
A: Most systems have one installation format. This has two, and the error messages don't tell you which one you need.

**Q: Who else struggles with this?**
A: Anyone installing custom Claude Code skills for the first time. Especially coming from other tools.

**Q: What's the single most important insight?**
A: Skill structure matters - directory-based needs uppercase SKILL.md with YAML frontmatter. Get this wrong and Claude Code silently ignores it.

**Q: Is this "here's what I built" or "here's what I learned"?**
A: Both - built the system AND learned about skill installation gotchas.

**Q: What should be screenshotted?**
A: The working /capture-content command in autocomplete, showing it finally loaded.

### Generated Content
**Twitter Thread (7 tweets)**:

1/ Spent 2 hours setting up content capture for Claude Code. The skill wouldn't load. Here's what I learned about skill installation formats 🧵

2/ Claude Code has TWO skill formats:
- Single file: namespace:skillname  
- Directory: skillname/SKILL.md (uppercase!)

I used lowercase. Claude Code silently ignored it. No error. Nothing.

3/ The fix: mkdir capture-content/ && create SKILL.md (uppercase). Add YAML frontmatter. Restart Claude Code.

Boom. /capture-content appears in autocomplete.

4/ Why this matters: Error messages don't tell you about format requirements. You just get... nothing. Skill doesn't load. No feedback.

5/ Other gotchas:
- YAML frontmatter required (name + description)
- Description should start with "Use when..."  
- Restart Claude Code after changes
- Directory skills need uppercase SKILL.md

6/ If your skill isn't loading:
✓ Check filename case (SKILL.md not skill.md)
✓ Verify YAML frontmatter exists
✓ Restart Claude Code
✓ Check ~/.claude/skills/ directory structure

7/ Once working, content capture is 🔥. Type /capture-content after interesting work. Answer 8-12 questions. Get publishable Twitter thread. Takes 10-18 min vs hours of drafting.

### Publishing Workflow
```bash
# Save draft with character validation
cd ~/Documents/github/smaug
./bird-save-draft.sh "skill-structure" thread.txt screenshot.png

# Output shows:
# ✅ Tweet 1: 178 chars (102 room)
# ✅ Tweet 2: 234 chars (46 room)
# ❌ Tweet 3: 295 chars (OVER by 15 - needs trimming)

# Edit content.txt to trim tweet 3
vim ~/drafts/20260110-150000-skill-structure/content.txt

# Publish
./bird-publish-draft.sh 20260110-150000-skill-structure

# Track engagement (24-48h later)
./bird-track-engagement.sh 20260110-150000-skill-structure
# Output: Engagement Score: 67 (HIGH)
```

---

## Example 2: Tool Evaluation → LinkedIn Post

### Session Work
- Tested 3 screen recording tools (1.5 hours)
- Loom vs OBS vs ScreenFlow
- Performance testing with 4K video
- Evaluated export options and pricing

### Interview (4 minutes)
**Q: What were you testing?**
A: Screen recording tools for tech tutorials. Needed 4K support without lag.

**Q: What surprised you?**
A: ScreenFlow handled 4K perfectly. Loom choked. OBS was free but complex setup.

**Q: Who else cares?**
A: Content creators making technical tutorials who need reliable 4K recording.

**Q: What's the key insight?**
A: Price doesn't equal performance. The $150 tool (ScreenFlow) outperformed the subscription tools.

### Generated Content
**LinkedIn Post (1,950 characters)**:

I tested 3 screen recording tools for 4K tech tutorials. The results surprised me.

THE CONTENDERS
• Loom ($12.50/month)
• OBS Studio (free)
• ScreenFlow ($169 one-time)

THE TEST
Record 4K screen + webcam for 20 minutes. Export to 1080p. Measure CPU usage and dropped frames.

RESULTS

Loom: Struggled with 4K. 15% dropped frames. CPU at 85%. Export crashed once. Beautiful interface though.

OBS: Handled 4K fine. CPU at 60%. But setup took 45 minutes. Virtual cameras, scenes, filters—powerful but overwhelming.

ScreenFlow: Zero dropped frames. CPU at 55%. Export was smooth. Setup took 5 minutes.

THE INSIGHT

Price ≠ performance for screen recording.

The $150 one-time purchase outperformed the subscription tool. The free tool worked but required significant time investment in configuration.

For technical content creators:
- Need simplicity? ScreenFlow
- Want free and can invest setup time? OBS  
- Already use Loom for quick demos? Stay on 1080p

The "prosumer" tier (ScreenFlow) is the sweet spot for serious technical content.

What tools do you use for screen recording? Drop recommendations below. 👇

---

## Example 3: Failed Experiment → Learning Post

### Session Work
- Tried to implement custom MCP server (3 hours)
- Hit authentication issues with OAuth
- Multiple failed attempts at token refresh
- Eventually reverted to API keys

### Interview (6 minutes)
**Q: What were you attempting?**
A: Building custom MCP server with OAuth for better security than API keys.

**Q: What went wrong?**
A: OAuth token refresh flow kept breaking. Tokens expired mid-session. Users got kicked out.

**Q: What did you try?**
A: 5 different token refresh strategies. Read OAuth specs. Tried different libraries. Nothing stable.

**Q: What did you learn?**
A: Sometimes the "worse" solution (API keys) is actually better. OAuth adds complexity that doesn't match MCP's use case.

### Generated Content
**Twitter Thread (8 tweets)**:

1/ Spent 3 hours trying to add OAuth to my MCP server. Failed. Reverted to API keys. Here's why that's actually the right choice 🧵

2/ The goal: Replace API keys with OAuth for "better security"

The reality: MCP servers run locally. OAuth solves server-to-server auth. Wrong tool for the job.

3/ What broke:
- Tokens expired mid-session
- Refresh flow interrupted workflows
- Users got mystery auth errors
- Debugging was nightmare

4/ Attempt 1: Store refresh tokens in keychain
Result: Race conditions during refresh

Attempt 2: Aggressive token prefetching  
Result: Hit rate limits

Attempt 3-5: Various libraries
Result: Same problems, different error messages

5/ The realization: OAuth solves a different problem than I have.

OAuth: Server authenticating with another server
My case: Local tool with personal API key

Using OAuth here is like using a forklift to move a box.

6/ When API keys are actually better:
✓ Local development tools
✓ Personal use (not sharing credentials)
✓ Short-lived sessions
✓ Simple auth requirements

Don't add OAuth just because it "sounds more secure"

7/ The better approach for MCP servers:
- Use API keys
- Store in system keychain
- Rotate regularly
- Scope permissions properly

8/ Sometimes the "worse" solution is actually better. Match the tool to the problem, not the tool to the trend.

**Engagement note**: Failed experiment posts often perform well because they're honest and teach through mistakes.

---

## Example 4: Quick Discovery (Should Skip)

### Session Work
- Read documentation on git worktrees (15 minutes)
- No hands-on implementation
- Just exploring the concept

### Decision
**Skip /capture-content** because:
- No original work produced
- Just passive learning
- No concrete example to share
- Less than 20 minutes

**Better approach**: Wait until actually using git worktrees, then capture that experience.

---

## Key Patterns

### Good Capture Candidates
- ✅ 20+ minutes of substantive work
- ✅ Concrete outcome (built, fixed, discovered)
- ✅ Clear before/after or problem/solution
- ✅ Shareable publicly
- ✅ Others face same issue

### Poor Capture Candidates
- ❌ Passive learning (just reading)
- ❌ Incomplete work
- ❌ Company/NDA content
- ❌ Trivial tasks (<10 min)
- ❌ No clear insight

### Interview Success Tips
- Use specific tool names (not "AI tools")
- Include timeframes (2 hours, 3 attempts, etc.)
- Name the exact problem you solved
- Identify who else faces this
- Be honest about failures

### Publishing Tips
- Always run character validation first
- Trim from middle of tweets, not end (preserve punchline)
- Screenshot the proof (working feature, error fixed, etc.)
- Track engagement to learn what resonates
- High performers (50+ score) signal winning topics
