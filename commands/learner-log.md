# Learner Log Command

Log new execution data to a learner tool for pattern analysis.

## Usage

```bash
/learner-log
```

Then select:
1. **Which learner** - Decision Historian, Style Learner, Meta-Recipe Tuner, or Knowledge Compressor
2. **Data to log** - Follow the prompts for your chosen learner

## Decision Historian

Log a decision and its outcome:

```bash
/learner-log
> Select learner: Decision Historian
> Execution ID: task_001
> Context (as JSON): {"difficulty": "hard", "time_available": "30 minutes"}
> Decision (as JSON): {"approach": "step_by_step"}
> Outcome (as JSON): {"success_rate": 0.95}
>
> ✓ Logged execution
> Samples in database: 5
```

## Style Learner

Log generated text and user edits:

```bash
/learner-log
> Select learner: Style Learner
> Execution ID: email_001
> Input prompt: Professional email to client
> Generated output: I am writing to inform you...
> Log edits? (y/n): y
> Edit 1 - Original: I am
> Edit 1 - Replacement: I'm
> Edit 1 - Reason: more conversational
>
> ✓ Logged execution and 1 edit
> Samples in database: 8
```

## Meta-Recipe Tuner

Log stage performance metrics:

```bash
/learner-log
> Select learner: Meta-Recipe Tuner
> Recipe ID: blog_writer
> Run ID: run_001
> Stage name: research
> Duration (seconds): 12.5
> Quality metric (0-1): 0.92
>
> ✓ Logged stage
> Stages logged: 3
```

## Knowledge Compressor

Log extraction and feedback:

```bash
/learner-log
> Select learner: Knowledge Compressor
> Extraction ID: doc_001
> Source type: research_paper
> Input tokens: 2500
> Section 1 name: abstract
> Section 1 tokens: 200
> Add more sections? (y/n): y
> ...
>
> ✓ Logged extraction
> Log feedback? (y/n): y
> Kept sections: abstract, results
> Removed sections: methods
> Reason: Focus on findings
>
> ✓ Logged feedback
```

## Output

After logging:
- ✓ Confirmation of what was logged
- Current sample count in database
- Suggestion: "Run `/learner-analyze` to see patterns"

## Data Format

All data is stored as JSON in:
- `.data/learning/<learner_id>/executions.jsonl`
- `.data/learning/<learner_id>/feedback.jsonl`

## Related Commands

- `/learner-analyze` - Analyze patterns from logged data
- `/learner-clear` - Clear specific learner data
- `/learner-status` - Check data status
