# Learner Clear Command

Clear data from a learner tool to start fresh.

## Usage

```bash
/learner-clear [learner_name]
```

## Clear All Learners

```bash
/learner-clear all

⚠️  This will delete ALL learner data!

Learners to clear:
  1. Decision Historian
  2. Style Learner
  3. Meta-Recipe Tuner
  4. Knowledge Compressor

Continue? (y/n): y

Clearing...
✓ Cleared decision_historian (8 executions, 3 feedback entries)
✓ Cleared style_learner (15 executions, 42 edits)
✓ Cleared meta_recipe_tuner (6 executions, 18 stage logs)
✓ Cleared knowledge_compressor (12 executions, 11 feedback)

Total cleaned: 41 executions

All learners reset to empty state.
```

## Clear Specific Learner

```bash
/learner-clear style_learner

⚠️  This will delete all Style Learner data!

  • Executions: 15 samples
  • Feedback: 42 edit entries
  • Recommendations: style_model.json

Continue? (y/n): y

✓ Deleted executions.jsonl (15 samples)
✓ Deleted feedback.jsonl (42 entries)
✓ Deleted style_model.json (recommendations)

Style Learner is now empty.
Run /learner-log to start fresh.
```

## Clear Specific Learners

```bash
/learner-clear
> Select learners to clear:
>   ☐ Decision Historian
>   ☑ Style Learner
>   ☑ Meta-Recipe Tuner
>   ☐ Knowledge Compressor
>
> Clear 2 learners? (y/n): y
>
> ✓ Cleared style_learner
> ✓ Cleared meta_recipe_tuner
```

## Available Options

- `all` - Clear all 4 learners
- `decision_historian` - Clear Decision Historian only
- `style_learner` - Clear Style Learner only
- `meta_recipe_tuner` - Clear Meta-Recipe Tuner only
- `knowledge_compressor` - Clear Knowledge Compressor only

## What Gets Deleted

Clearing a learner removes:
1. `executions.jsonl` - All logged executions
2. `feedback.jsonl` - All logged feedback (if applicable)
3. `*.json` (recommendations file) - All learned patterns

## Safety

- Always prompts for confirmation before deleting
- Shows what will be deleted
- Cannot undo - data is permanently removed
- Recommendations: backup data first if needed

## After Clearing

After clearing, the learner is empty and ready to:
1. Start collecting new execution data
2. Build new patterns from scratch
3. Learn different behaviors

## Related Commands

- `/learner-log` - Log new execution data
- `/learner-status` - Check data status
- `/learner-export` - Export data before clearing
- `/learner-analyze` - Analyze before clearing
