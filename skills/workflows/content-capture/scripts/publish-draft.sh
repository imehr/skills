#!/bin/bash
# Publish draft via bird CLI with threading
#
# Usage: ./bird-publish-draft.sh <draft-folder-name>
#
# Reads content.txt, posts as threaded tweets
# Attaches screenshot.png to first tweet if exists
# Updates metadata with published URLs

DRAFT_NAME="$1"

if [ -z "$DRAFT_NAME" ]; then
  echo "Usage: $0 <draft-folder-name>"
  echo ""
  echo "Available drafts:"
  ls -1 "$HOME/drafts" | grep -v "^\\."
  exit 1
fi

DRAFTS_DIR="$HOME/drafts"
DRAFT_DIR="$DRAFTS_DIR/$DRAFT_NAME"

if [ ! -d "$DRAFT_DIR" ]; then
  echo "❌ Draft not found: $DRAFT_DIR"
  exit 1
fi

CONTENT_FILE="$DRAFT_DIR/content.txt"
SCREENSHOT="$DRAFT_DIR/screenshot.png"

if [ ! -f "$CONTENT_FILE" ]; then
  echo "❌ No content.txt found in draft"
  exit 1
fi

echo "🚀 Publishing draft: $DRAFT_NAME"
echo ""

# Read first tweet
FIRST_TWEET=$(head -1 "$CONTENT_FILE")

# Post first tweet with media if exists
if [ -f "$SCREENSHOT" ]; then
  echo "📸 Posting first tweet with screenshot..."
  RESULT=$(bird tweet "$FIRST_TWEET" --media "$SCREENSHOT" --json)
else
  echo "📝 Posting first tweet (no media)..."
  RESULT=$(bird tweet "$FIRST_TWEET" --json)
fi

TWEET_ID=$(echo "$RESULT" | jq -r '.id')
TWEET_URL=$(echo "$RESULT" | jq -r '.url')

echo "✅ Tweet 1 posted: $TWEET_URL"
echo ""

# Save first tweet URL
echo "$TWEET_URL" > "$DRAFT_DIR/published-urls.txt"

# Post remaining tweets as replies
TWEET_NUM=2
tail -n +2 "$CONTENT_FILE" | while IFS= read -r tweet; do
  # Skip empty lines
  if [ -z "$tweet" ]; then
    continue
  fi

  echo "📝 Posting tweet $TWEET_NUM..."
  RESULT=$(bird reply "$TWEET_ID" "$tweet" --json)
  REPLY_ID=$(echo "$RESULT" | jq -r '.id')
  REPLY_URL=$(echo "$RESULT" | jq -r '.url')

  echo "✅ Tweet $TWEET_NUM posted: $REPLY_URL"
  echo "$REPLY_URL" >> "$DRAFT_DIR/published-urls.txt"

  # Update TWEET_ID for next reply (threads properly)
  TWEET_ID="$REPLY_ID"
  ((TWEET_NUM++))

  # Rate limit protection
  sleep 2
done

# Update metadata
jq '.status = "published" | .published_at = now | .thread_url = "'$TWEET_URL'"' \
  "$DRAFT_DIR/metadata.json" > "$DRAFT_DIR/metadata.json.tmp" && \
  mv "$DRAFT_DIR/metadata.json.tmp" "$DRAFT_DIR/metadata.json"

echo ""
echo "🎉 Thread published successfully!"
echo "📍 View thread: $TWEET_URL"
echo "📊 Track engagement: bird-track-engagement.sh $DRAFT_NAME"
echo ""