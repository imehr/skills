#!/bin/bash
# Content Capture System Installer for imehr-marketplace
# Installs skill, hook, and publishing scripts

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "  Content Capture System Installer"
echo "=========================================="
echo ""

# Check prerequisites
echo "Checking prerequisites..."

if ! command -v bird >/dev/null 2>&1; then
    echo -e "${RED}❌ bird CLI not found${NC}"
    echo "   Install: npm install -g @steipete/bird"
    echo "   Repo: https://github.com/steipete/bird"
    exit 1
fi
echo -e "${GREEN}✓${NC} bird CLI found"

if ! command -v jq >/dev/null 2>&1; then
    echo -e "${RED}❌ jq not found${NC}"
    echo "   Install: brew install jq"
    exit 1
fi
echo -e "${GREEN}✓${NC} jq found"

# Verify bird CLI is authenticated
echo ""
echo "Verifying bird CLI authentication..."
if bird whoami >/dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} bird CLI authenticated"
else
    echo -e "${YELLOW}⚠️  bird CLI not authenticated${NC}"
    echo "   Log into x.com in Chrome/Safari/Firefox"
    echo "   bird uses browser cookies automatically"
    echo ""
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo ""
echo "=========================================="
echo "Installing components..."
echo "=========================================="
echo ""

# Get installation directory (current directory should be the skill directory)
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install skill (should already be in ~/.claude/skills/content-capture if installed via marketplace)
# This installer assumes it's being run from the skill directory
echo "1. Skill"
echo -e "   ${GREEN}✓${NC} Already installed via marketplace"
echo "   Location: ${SKILL_DIR}"

# Install hook
echo ""
echo "2. Session detection hook"
mkdir -p ~/.claude/hooks
cp "$SKILL_DIR/scripts/hook.sh" ~/.claude/hooks/content-capture-trigger.sh
chmod +x ~/.claude/hooks/content-capture-trigger.sh
echo -e "   ${GREEN}✓${NC} Installed: ~/.claude/hooks/content-capture-trigger.sh"

# Install publishing scripts
echo ""
echo "3. Publishing scripts"
SCRIPTS_DIR=~/Documents/github/smaug
mkdir -p "$SCRIPTS_DIR"
cp "$SKILL_DIR/scripts/save-draft.sh" "$SCRIPTS_DIR/bird-save-draft.sh"
cp "$SKILL_DIR/scripts/publish-draft.sh" "$SCRIPTS_DIR/bird-publish-draft.sh"
cp "$SKILL_DIR/scripts/track-engagement.sh" "$SCRIPTS_DIR/bird-track-engagement.sh"
chmod +x "$SCRIPTS_DIR"/bird-*.sh
echo -e "   ${GREEN}✓${NC} Installed: $SCRIPTS_DIR/bird-*.sh"

# Create working directories
echo ""
echo "4. Working directories"
mkdir -p ~/drafts
echo -e "   ${GREEN}✓${NC} Created: ~/drafts/"

if [ ! -f ~/synthesis-priority-queue.md ]; then
    cat > ~/synthesis-priority-queue.md <<'SYNTH_EOF'
# Synthesis Priority Queue

High-performing content signals for topic selection

---

SYNTH_EOF
    echo -e "   ${GREEN}✓${NC} Created: ~/synthesis-priority-queue.md"
else
    echo -e "   ${GREEN}✓${NC} Exists: ~/synthesis-priority-queue.md"
fi

# Check settings.json configuration
echo ""
echo "5. Claude Code settings"
SETTINGS_FILE=~/.claude/settings.json

if [ ! -f "$SETTINGS_FILE" ]; then
    echo -e "   ${RED}❌ ~/.claude/settings.json not found${NC}"
    echo "   Create it and add hooks configuration manually"
    NEEDS_MANUAL_SETUP=true
else
    # Check if hooks are already configured
    if grep -q "content-capture-trigger.sh" "$SETTINGS_FILE" 2>/dev/null; then
        echo -e "   ${GREEN}✓${NC} Hooks already configured"
    else
        echo -e "   ${YELLOW}⚠️  Hooks not configured${NC}"
        NEEDS_MANUAL_SETUP=true
    fi
fi

echo ""
echo "=========================================="
echo "Installation complete!"
echo "=========================================="
echo ""

if [ "$NEEDS_MANUAL_SETUP" = true ]; then
    echo -e "${YELLOW}⚠️  Manual configuration required:${NC}"
    echo ""
    echo "Add the following to ~/.claude/settings.json:"
    echo ""
    echo '{
  "hooks": {
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/content-capture-trigger.sh"
          }
        ]
      }
    ],
    "PreCompact": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/content-capture-trigger.sh"
          }
        ]
      }
    ]
  }
}'
    echo ""
    echo "Then restart Claude Code."
    echo ""
else
    echo -e "${GREEN}✓${NC} All components installed successfully!"
    echo ""
    echo "Restart Claude Code to activate the hook."
    echo ""
fi

echo "=========================================="
echo "Next Steps:"
echo "=========================================="
echo ""
echo "1. Restart Claude Code"
echo "2. Do interesting work in a session"
echo "3. When session ends, watch for:"
echo "   🎯 CONTENT CAPTURE OPPORTUNITY DETECTED"
echo "4. Run: /capture-content"
echo "5. Answer 8-12 interview questions"
echo "6. Follow publishing workflow:"
echo "   cd $SCRIPTS_DIR"
echo "   ./bird-save-draft.sh <name> <content> [screenshot]"
echo "   ./bird-publish-draft.sh <draft-folder>"
echo "   ./bird-track-engagement.sh <draft-folder>  # 24-48h later"
echo ""
echo "Documentation:"
echo "  Skill: ${SKILL_DIR}/SKILL.md"
echo "  Examples: ${SKILL_DIR}/docs/examples.md"
echo "  Troubleshooting: ${SKILL_DIR}/docs/troubleshooting.md"
echo ""
echo "Happy content creating! 🚀"
echo ""
