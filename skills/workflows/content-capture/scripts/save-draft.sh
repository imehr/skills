#!/bin/bash
# Bird CLI Draft Saver with Character Count Validation
# Saves interview-generated content to drafts with Twitter length analysis
#
# Usage: ./bird-save-draft.sh <draft-name> <content-file> [screenshot-path]
#
# Validates Twitter character limits (280 chars/tweet)
# Shows which tweets need trimming
# Saves to ~/drafts/ with metadata

DRAFT_NAME="$1"
CONTENT_FILE="$2"
SCREENSHOT="$3"

if [ -z "$DRAFT_NAME" ] || [ -z "$CONTENT_FILE" ]; then
  echo "Usage: $0 <draft-name> <content-file> [screenshot-path]"
  exit 1
fi

# Create drafts directory if needed
# Adjust this path to your vault/workspace location
DRAFTS_DIR="$HOME/drafts"
mkdir -p "$DRAFTS_DIR"

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
DRAFT_DIR="$DRAFTS_DIR/$TIMESTAMP-$DRAFT_NAME"
mkdir -p "$DRAFT_DIR"

# Copy content to draft
cp "$CONTENT_FILE" "$DRAFT_DIR/content.txt"

# Copy screenshot if provided
if [ -n "$SCREENSHOT" ] && [ -f "$SCREENSHOT" ]; then
  cp "$SCREENSHOT" "$DRAFT_DIR/screenshot.png"
fi

# Analyze character counts for Twitter thread
echo "📊 Character Count Analysis" > "$DRAFT_DIR/analysis.txt"
echo "=============================" >> "$DRAFT_DIR/analysis.txt"
echo "" >> "$DRAFT_DIR/analysis.txt"

TWEET_NUM=1
while IFS= read -r line; do
  # Skip empty lines
  if [ -z "$line" ]; then
    continue
  fi

  CHAR_COUNT=${#line}

  if [ "$CHAR_COUNT" -gt 280 ]; then
    OVER=$((CHAR_COUNT - 280))
    echo "❌ Tweet $TWEET_NUM: $CHAR_COUNT chars (OVER by $OVER - needs trimming)" >> "$DRAFT_DIR/analysis.txt"
  elif [ "$CHAR_COUNT" -gt 260 ]; then
    ROOM=$((280 - CHAR_COUNT))
    echo "⚠️  Tweet $TWEET_NUM: $CHAR_COUNT chars (only $ROOM chars left - tight)" >> "$DRAFT_DIR/analysis.txt"
  else
    ROOM=$((280 - CHAR_COUNT))
    echo "✅ Tweet $TWEET_NUM: $CHAR_COUNT chars ($ROOM room)" >> "$DRAFT_DIR/analysis.txt"
  fi

  ((TWEET_NUM++))
done < "$CONTENT_FILE"

echo "" >> "$DRAFT_DIR/analysis.txt"
echo "Total tweets: $((TWEET_NUM - 1))" >> "$DRAFT_DIR/analysis.txt"

# Create metadata file
cat > "$DRAFT_DIR/metadata.json" <<EOF
{
  "draft_name": "$DRAFT_NAME",
  "created_at": "$TIMESTAMP",
  "has_screenshot": $([ -f "$DRAFT_DIR/screenshot.png" ] && echo "true" || echo "false"),
  "tweet_count": $((TWEET_NUM - 1)),
  "platform": "twitter",
  "status": "needs_review"
}
EOF

# Show summary
echo ""
echo "✅ Draft saved to: $DRAFT_DIR"
echo ""
cat "$DRAFT_DIR/analysis.txt"
echo ""
echo "📝 Next steps:"
echo "   1. Review content.txt and trim any over-limit tweets"
echo "   2. Verify screenshot.png looks good"
echo "   3. When ready: bird-publish-draft.sh $TIMESTAMP-$DRAFT_NAME"
echo ""