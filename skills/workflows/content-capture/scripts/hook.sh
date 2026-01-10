#!/bin/bash
# Content Capture Trigger Hook for Claude Code
# Detects interesting work moments and suggests content creation
#
# Triggers on:
# - Session compact (end of session - review what was accomplished)
# - Significant system updates
# - Problem resolution moments
# - New realizations documented
#
# Installation:
# 1. Save to ~/.claude/hooks/content-capture-trigger.sh
# 2. chmod +x ~/.claude/hooks/content-capture-trigger.sh
# 3. Add to ~/.claude/settings.json hooks configuration

# Get the hook event type
EVENT_TYPE="${1:-unknown}"
TRANSCRIPT_FILE="${2:-}"

# Only trigger on these events
case "$EVENT_TYPE" in
  "PreCompact"|"SessionEnd")
    # Session ending - check if interesting work happened

    # Signal patterns that indicate content-worthy moments
    CONTENT_SIGNALS=(
      "successfully"
      "solved"
      "working"
      "created"
      "implemented"
      "discovered"
      "realized"
      "interesting"
      "synthesis"
      "framework"
    )

    # Check last 50 lines of transcript for signals
    if [ -n "$TRANSCRIPT_FILE" ] && [ -f "$TRANSCRIPT_FILE" ]; then
      SIGNAL_COUNT=0
      for signal in "${CONTENT_SIGNALS[@]}"; do
        if tail -50 "$TRANSCRIPT_FILE" | grep -qi "$signal"; then
          ((SIGNAL_COUNT++))
        fi
      done

      # If 3+ signals detected, suggest content capture
      if [ "$SIGNAL_COUNT" -ge 3 ]; then
        cat <<'CAPTURE_PROMPT'

---
🎯 **CONTENT CAPTURE OPPORTUNITY DETECTED**

This session contained interesting work that could become content.

Before you close this session, consider:
- Run `/capture-content` to extract a LinkedIn post or tweet thread
- The interview will identify the best moments and help you articulate them
- Takes 3-5 minutes, captures while context is fresh

Type `/capture-content` now, or continue if not the right moment.
---
CAPTURE_PROMPT
      fi
    fi
    ;;

  *)
    # Other events - no action
    ;;
esac

exit 0