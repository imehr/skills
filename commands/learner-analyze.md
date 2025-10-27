# Learner Analyze Command

Analyze patterns learned by any of the 4 learner tools from existing execution data.

## Usage

```bash
/learner-analyze
```

Then select which learner to analyze:
- Decision Historian
- Style Learner
- Meta-Recipe Tuner
- Knowledge Compressor

## What it does

1. Loads all execution and feedback data from the learner
2. Runs the learn() method to extract patterns
3. Retrieves recommendations
4. Displays analysis in human-readable format
5. Shows confidence scores and reliability metrics

## Output

For each learner, you'll see:
- **Patterns found**: Number of patterns discovered
- **Confidence**: Reliability of recommendations (0-1)
- **Key insights**: Main findings from the data
- **Recommendations**: What the learner suggests
- **Next steps**: How to improve

## Example

```bash
/learner-analyze
> Select learner: Style Learner
>
> ✓ Analyzed 15 execution samples
> ✓ Found 3 patterns
> ✓ Confidence: 0.82
>
> Style Profile:
>   • Formality: 0.45 (conversational)
>   • Perspective: first-person
>   • Edits analyzed: 45
>
> Recommendation: Use more casual tone in future generations
```

## Data Requirements

Each learner needs minimum data to analyze:
- Decision Historian: 3+ samples, 2+ contexts
- Style Learner: 3+ samples, 5+ edits
- Meta-Recipe Tuner: 5+ samples, 2+ stages
- Knowledge Compressor: 5+ samples, 3+ sections

## Storage

Analysis reads from: `.data/learning/<learner_id>/`

See existing recommendations file for latest learned patterns.

## Related Commands

- `/learner-log` - Log new execution data
- `/learner-clear` - Clear learner data
- `/learner-status` - Check learner data status
