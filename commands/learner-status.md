# Learner Status Command

Check the status and data count for all learner tools.

## Usage

```bash
/learner-status
```

Shows summary of all 4 learners with data counts and readiness status.

## Output Example

```bash
/learner-status

📊 LEARNER STATUS SUMMARY
════════════════════════════════════════════════════════════════

Decision Historian
  • Executions: 8
  • Feedback: 3
  • Status: ⚠️ NEEDS MORE DATA (minimum 3 contexts needed)
  • Last updated: 2 hours ago
  • Recommendations file: ✓ Exists (updated 30 mins ago)

Style Learner
  • Executions: 15
  • Feedback: 42 edits across 12 executions
  • Status: ✓ READY (15 samples, 42 edits)
  • Last updated: 30 mins ago
  • Recommendations file: ✓ Exists (updated 5 mins ago)
  • Current profile: formality=0.45, perspective=first

Meta-Recipe Tuner
  • Executions: 6
  • Stages logged: 18 (3 stages × 6 runs)
  • Status: ✓ READY (6 samples, 3 stages)
  • Last updated: 1 hour ago
  • Recommendations file: ✓ Exists (updated 45 mins ago)
  • Bottleneck identified: research stage

Knowledge Compressor
  • Executions: 12
  • Feedback entries: 11
  • Sections discovered: 8
  • Status: ✓ READY (12 samples, 8 sections)
  • Last updated: 1 hour ago
  • Recommendations file: ✓ Exists (updated 50 mins ago)
  • Top priority sections: abstract, results

════════════════════════════════════════════════════════════════

OVERALL STATUS:
  • Total executions logged: 41
  • Learners ready: 3/4
  • Learners needing data: 1/4

QUICK ACTIONS:
  • Run `/learner-analyze` to see detailed patterns
  • Run `/learner-log` to add more data
  • Run `/learner-clear decision_historian` to reset
```

## Per-Learner Status

Use with learner name to see detailed info:

```bash
/learner-status style_learner

Style Learner - Detailed Status
════════════════════════════════════════════════════════════════

Data Files:
  • executions.jsonl: 15 samples (45 KB)
  • feedback.jsonl: 12 entries (28 KB)
  • style_model.json: ✓ Exists (latest)

Current Profile:
  • Formality: 0.45 (conversational)
  • Perspective: first-person
  • Confidence: 0.82
  • Edits analyzed: 42

Preferences Learned:
  • casual: 25 occurrences
  • concise: 12 occurrences
  • conversational: 8 occurrences

Readiness:
  ✓ Minimum samples: YES (15 >= 3)
  ✓ Sufficient feedback: YES (42 edits >= 5)
  ✓ Patterns found: YES (3 patterns)
  ✓ Confidence adequate: YES (0.82 >= 0.7)

Recommendation:
  Ready to use! Learner has reliable patterns extracted.
```

## Status Indicators

- ✓ **READY** - Has sufficient data, patterns reliable, ready to use
- ⚠️ **NEEDS MORE DATA** - Below minimum samples or feedback
- ⏳ **NEEDS LEARNING** - Has data but hasn't learned yet
- ❌ **NO DATA** - No executions logged yet

## Data Locations

Status checks these files:
```
.data/learning/
├── decision_historian/
│   ├── executions.jsonl
│   ├── feedback.jsonl
│   └── recommendations.json
├── style_learner/
│   ├── executions.jsonl
│   ├── feedback.jsonl
│   └── style_model.json
├── meta_recipe_tuner/
│   ├── executions.jsonl
│   └── tuning_model.json
└── knowledge_compressor/
    ├── executions.jsonl
    ├── feedback.jsonl
    └── compression_model.json
```

## Related Commands

- `/learner-analyze` - Analyze patterns in detail
- `/learner-log` - Log new execution data
- `/learner-clear` - Clear learner data
- `/learner-export` - Export data for analysis
