#!/bin/bash
# Track engagement for published content
# Feeds performance data into synthesis priority queue
#
# Usage: ./bird-track-engagement.sh <draft-folder-name>
#        ./bird-track-engagement.sh --weekly-report
#
# Outputs engagement metrics and updates synthesis priorities

MODE="${1}"

DRAFTS_DIR="$HOME/drafts"
# Adjust this path to your synthesis tracking location
SYNTHESIS_QUEUE="$HOME/synthesis-priority-queue.md"

if [ "$MODE" = "--weekly-report" ]; then
  echo "📊 Weekly Engagement Report"
  echo "============================"
  echo ""

  # Find all published drafts from last 7 days
  find "$DRAFTS_DIR" -name "metadata.json" -mtime -7 | while read -r meta; do
    STATUS=$(jq -r '.status' "$meta")
    if [ "$STATUS" = "published" ]; then
      DRAFT_NAME=$(jq -r '.draft_name' "$meta")
      THREAD_URL=$(jq -r '.thread_url' "$meta")

      if [ -n "$THREAD_URL" ]; then
        # Fetch engagement data
        ENGAGEMENT=$(bird read "$THREAD_URL" --json)
        LIKES=$(echo "$ENGAGEMENT" | jq -r '.favorite_count // 0')
        RETWEETS=$(echo "$ENGAGEMENT" | jq -r '.retweet_count // 0')
        REPLIES=$(echo "$ENGAGEMENT" | jq -r '.reply_count // 0')

        TOTAL=$((LIKES + RETWEETS * 3 + REPLIES * 5))

        echo "📈 $DRAFT_NAME"
        echo "   Likes: $LIKES | RTs: $RETWEETS | Replies: $REPLIES"
        echo "   Engagement Score: $TOTAL"
        echo "   URL: $THREAD_URL"
        echo ""
      fi
    fi
  done

  echo ""
  echo "💡 Top performing topics inform next synthesis priorities"
  echo "   See: $SYNTHESIS_QUEUE"
  exit 0
fi

# Single draft tracking
DRAFT_NAME="$MODE"
DRAFT_DIR="$DRAFTS_DIR/$DRAFT_NAME"

if [ ! -d "$DRAFT_DIR" ]; then
  echo "❌ Draft not found: $DRAFT_NAME"
  exit 1
fi

THREAD_URL=$(jq -r '.thread_url' "$DRAFT_DIR/metadata.json")

if [ -z "$THREAD_URL" ] || [ "$THREAD_URL" = "null" ]; then
  echo "❌ Draft not published yet"
  exit 1
fi

echo "📊 Engagement Tracking: $DRAFT_NAME"
echo "=================================="
echo ""

# Fetch engagement for main tweet
ENGAGEMENT=$(bird read "$THREAD_URL" --json)

LIKES=$(echo "$ENGAGEMENT" | jq -r '.favorite_count // 0')
RETWEETS=$(echo "$ENGAGEMENT" | jq -r '.retweet_count // 0')
REPLIES=$(echo "$ENGAGEMENT" | jq -r '.reply_count // 0')
IMPRESSIONS=$(echo "$ENGAGEMENT" | jq -r '.views // "N/A"')

echo "📈 Main Tweet Performance"
echo "   Likes: $LIKES"
echo "   Retweets: $RETWEETS"
echo "   Replies: $REPLIES"
echo "   Impressions: $IMPRESSIONS"
echo ""

# Calculate engagement score (weighted)
ENGAGEMENT_SCORE=$((LIKES + RETWEETS * 3 + REPLIES * 5))

echo "   Engagement Score: $ENGAGEMENT_SCORE"
echo "   (Likes + RTs×3 + Replies×5)"
echo ""

# Update metadata with engagement
jq --arg likes "$LIKES" \
   --arg retweets "$RETWEETS" \
   --arg replies "$REPLIES" \
   --arg score "$ENGAGEMENT_SCORE" \
   '.engagement = {likes: ($likes | tonumber), retweets: ($retweets | tonumber), replies: ($replies | tonumber), score: ($score | tonumber), tracked_at: now}' \
   "$DRAFT_DIR/metadata.json" > "$DRAFT_DIR/metadata.json.tmp" && \
   mv "$DRAFT_DIR/metadata.json.tmp" "$DRAFT_DIR/metadata.json"

echo "💾 Engagement data saved to metadata"
echo ""

# Extract topic/style for synthesis prioritization
STYLE_CLUSTER=$(jq -r '.style_cluster // "unknown"' "$DRAFT_DIR/metadata.json")
CONTENT_TYPE=$(jq -r '.content_type // "unknown"' "$DRAFT_DIR/metadata.json")

echo "📊 Performance Insights"
echo "   Style Cluster: $STYLE_CLUSTER"
echo "   Content Type: $CONTENT_TYPE"
echo "   Engagement Level: $([ "$ENGAGEMENT_SCORE" -gt 100 ] && echo "HIGH" || [ "$ENGAGEMENT_SCORE" -gt 30 ] && echo "MEDIUM" || echo "LOW")"
echo ""

# Update synthesis priority queue if high engagement
if [ "$ENGAGEMENT_SCORE" -gt 50 ]; then
  echo "🎯 HIGH ENGAGEMENT - Updating synthesis priorities"

  # Append to synthesis queue
  cat >> "$SYNTHESIS_QUEUE" <<EOF

## High-Performing Content Signal - $(date +%Y-%m-%d)
- **Draft**: $DRAFT_NAME
- **Engagement Score**: $ENGAGEMENT_SCORE (Likes: $LIKES, RTs: $RETWEETS, Replies: $REPLIES)
- **Style**: $STYLE_CLUSTER
- **Type**: $CONTENT_TYPE
- **Thread**: $THREAD_URL

**Synthesis Priority**: Look for similar topics/clusters to this high-performer. Audience validated interest.

---

EOF

  echo "   Added to synthesis priority queue"
fi

echo ""
echo "✅ Tracking complete"
echo "📍 Thread: $THREAD_URL"
echo ""