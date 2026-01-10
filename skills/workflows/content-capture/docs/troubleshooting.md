# Content Capture - Troubleshooting Guide

Common issues and solutions for the content capture system.

---

## Skill Installation Issues

### Skill not appearing in autocomplete

**Symptom**: Type `/capture` but nothing appears in autocomplete suggestions.

**Causes & Solutions**:

1. **Wrong file structure**
   ```bash
   # Check current structure
   ls -la ~/.claude/skills/capture-content/
   
   # Should see:
   # SKILL.md (uppercase!)
   
   # If you see skill.md (lowercase), fix it:
   mv ~/.claude/skills/capture-content/skill.md ~/.claude/skills/capture-content/SKILL.md
   ```

2. **Missing YAML frontmatter**
   ```bash
   # Check first 5 lines
   head -5 ~/.claude/skills/capture-content/SKILL.md
   
   # Should see:
   # ---
   # name: capture-content
   # description: Use when you've done interesting work...
   # ---
   ```
   
   If missing, add frontmatter at the top of SKILL.md.

3. **Claude Code hasn't restarted**
   - Exit Claude Code completely (not just close window)
   - Restart Claude Code
   - Skills are loaded at startup

4. **Wrong directory location**
   ```bash
   # Verify skill is in correct location
   [ -f ~/.claude/skills/capture-content/SKILL.md ] && echo "✓ Found" || echo "✗ Missing"
   
   # If missing, reinstall:
   cd ~/Documents/github/skills-marketplace-prep/content-capture
   ./install.sh
   ```

---

## Hook Configuration Issues

### Hook not triggering at session end

**Symptom**: Finish session with interesting work, but no "CONTENT CAPTURE OPPORTUNITY DETECTED" prompt appears.

**Causes & Solutions**:

1. **Hook not installed**
   ```bash
   # Check if hook exists
   ls -la ~/.claude/hooks/content-capture-trigger.sh
   
   # If missing:
   cp ~/Documents/github/skills-marketplace-prep/content-capture/scripts/hook.sh \
      ~/.claude/hooks/content-capture-trigger.sh
   chmod +x ~/.claude/hooks/content-capture-trigger.sh
   ```

2. **Hook not executable**
   ```bash
   # Make executable
   chmod +x ~/.claude/hooks/content-capture-trigger.sh
   ```

3. **Settings not configured**
   ```bash
   # Check settings
   grep -A 10 "SessionEnd" ~/.claude/settings.json
   
   # Should include:
   # "SessionEnd": [
   #   {
   #     "hooks": [
   #       {
   #         "type": "command",
   #         "command": "$HOME/.claude/hooks/content-capture-trigger.sh"
   #       }
   #     ]
   #   }
   # ]
   ```
   
   If missing, add hooks configuration to `~/.claude/settings.json` (see install.sh output).

4. **Not enough signals detected**
   - Hook requires 3+ signals in last 50 lines of transcript
   - Signals: "successfully", "solved", "created", "implemented", etc.
   - If session was very quiet (no status updates), hook won't trigger
   - This is intentional to prevent false positives

5. **Claude Code needs restart**
   - Settings changes require restart
   - Exit and restart Claude Code

---

## Bird CLI Issues

### Authentication failures

**Symptom**: `bird whoami` fails or returns authentication error.

**Causes & Solutions**:

1. **Not logged into Twitter/X**
   - Open Chrome, Safari, or Firefox
   - Go to x.com and log in
   - Stay logged in (don't log out)
   - bird CLI reads cookies automatically

2. **Browser cookies not accessible**
   ```bash
   # Test bird CLI
   bird whoami
   
   # If fails, check which browser you're logged into
   # bird tries Safari → Chrome → Firefox in order
   ```
   
   **macOS Keychain access**:
   - Chrome on macOS may require granting Terminal access to Keychain
   - System Settings → Privacy & Security → Full Disk Access
   - Add Terminal to allowed apps

3. **Bird CLI not installed**
   ```bash
   # Check installation
   which bird
   
   # If not found:
   npm install -g @steipete/bird
   
   # Verify version (need 0.5.1+)
   bird --version
   ```

4. **Old bird CLI version**
   ```bash
   # Update bird CLI
   npm update -g @steipete/bird
   ```

### Publishing failures

**Symptom**: `bird-publish-draft.sh` fails or tweets don't appear.

**Solutions**:

1. **Check authentication first**
   ```bash
   bird whoami
   ```

2. **Rate limit hit**
   - Twitter has rate limits
   - Wait 15 minutes and try again
   - Script includes 2-second delays between tweets

3. **Content file missing**
   ```bash
   # Verify content file exists
   ls -la ~/drafts/TIMESTAMP-NAME/content.txt
   ```

4. **JSON parsing errors**
   - bird CLI returns JSON
   - Requires jq installed
   ```bash
   # Install jq if missing
   brew install jq
   ```

---

## Character Limit Issues

### Tweets over 280 characters

**Symptom**: `bird-save-draft.sh` shows "❌ OVER by X chars".

**Solutions**:

1. **Trim the tweet**
   ```bash
   # Edit content
   vim ~/drafts/TIMESTAMP-NAME/content.txt
   ```
   
   **Trimming strategies**:
   - Remove filler words: "actually", "basically", "essentially", "really"
   - Use em dashes (—) instead of "and" or "but"
   - Combine short sentences
   - Cut redundant phrases
   - Keep tool names (they drive engagement)

2. **Split into two tweets**
   - Add line break to create new tweet
   - Ensure context flows between tweets

3. **Use thread continuation**
   - "Part 1/2" tweets are OK
   - Readers expect threads to expand on ideas

**Example trim**:
```
Before (295 chars):
"So I was basically trying to implement this OAuth authentication system but it was actually causing a lot of problems with token refresh and it was really frustrating to debug."

After (267 chars):
"Tried implementing OAuth authentication. Token refresh kept breaking—frustrating to debug. Eventually reverted to API keys."

Saved: 28 characters
```

---

## Workflow Issues

### Interview feels too long

**Solution**: Use quick mode
```bash
/capture-content quick
```
Reduces from 8-12 questions to 6-8 questions.

### Forgot to capture during session

**Solution**: Run `/capture-content` retroactively
- Still works if session is recent (same day)
- Your memory will be fresh enough
- Less ideal than in-the-moment, but better than nothing

### Can't find published thread URL

**Solution**: Check published-urls.txt
```bash
cat ~/drafts/TIMESTAMP-NAME/published-urls.txt
```

First URL is the thread start.

### Engagement tracking returns zero

**Causes**:
1. **Too soon after publishing**
   - Wait 24-48 hours for meaningful metrics
   - Early tracking shows zeros

2. **Thread URL incorrect**
   ```bash
   # Verify URL in metadata
   jq '.thread_url' ~/drafts/TIMESTAMP-NAME/metadata.json
   ```

3. **Tweet deleted or made private**
   - Check if tweet still exists on Twitter/X

---

## Common Mistakes

### Capturing too early

**Mistake**: Running `/capture-content` before work is complete.

**Solution**: 
- Wait until you have a concrete outcome
- "I'm going to..." → too early
- "I just..." → good timing

### Over-explaining private context

**Mistake**: "Our proprietary system that does X which connects to Y..."

**Solution**:
- Generalize: "A caching system that handles..."
- Focus on the problem/solution, not internal details
- If you can't share it publicly, don't capture it

### Skipping character validation

**Mistake**: Publishing without running `bird-save-draft.sh` first.

**Solution**:
- ALWAYS run save-draft first
- Twitter rejects over-limit tweets
- Better to trim before publishing

### Not tracking engagement

**Mistake**: Publishing and never checking what performed well.

**Solution**:
- Set calendar reminder for 48h after publishing
- Run `bird-track-engagement.sh`
- Use high performers to guide next topics

---

## Getting Help

### Check installation
```bash
# Verify all components
ls -la ~/.claude/skills/capture-content/SKILL.md
ls -la ~/.claude/hooks/content-capture-trigger.sh
which bird
which jq
bird whoami
```

### Check logs
```bash
# Claude Code logs (if available)
tail -f ~/.claude/logs/*.log

# Test hook manually
~/.claude/hooks/content-capture-trigger.sh SessionEnd /path/to/test/transcript
```

### Reset and reinstall
```bash
# Backup current installation
cp -r ~/.claude/skills/capture-content ~/capture-content-backup

# Remove and reinstall
rm -rf ~/.claude/skills/capture-content
rm ~/.claude/hooks/content-capture-trigger.sh

# Run installer again
cd ~/Documents/github/skills-marketplace-prep/content-capture
./install.sh
```

### Still stuck?

1. Check [examples.md](./examples.md) for working examples
2. Review [reference.md](./reference.md) for interview flow
3. Re-read [SKILL.md](../SKILL.md) for usage guidance
4. Submit issue to [imehr/skills](https://github.com/imehr/skills) with:
   - What you tried
   - Error messages
   - System info (macOS version, Claude Code version)

---

## Tips for Success

### Make hook trigger reliably
- Mention outcomes: "successfully built", "fixed the bug", "implemented feature"
- Status updates help: "created the hook", "packaged the scripts"
- Natural documentation triggers hook

### Craft better tweets
- Start with hook (surprising insight or result)
- Use thread numbers (1/7, 2/7, etc.)
- End with call-to-action or question
- Include screenshot/proof

### Optimize for engagement
- Post when your audience is active
- Use relevant hashtags (1-2 max)
- Tag tools/people mentioned (when appropriate)
- Respond to early replies quickly

### Build content habit
- Run `/capture-content` after each significant session
- Set aside 30 min weekly to publish batch
- Track what works
- Iterate on content strategy
