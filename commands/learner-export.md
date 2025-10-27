# Learner Export Command

Export learner data for analysis, backup, or sharing.

## Usage

```bash
/learner-export [learner_name] [format]
```

## Export Single Learner

```bash
/learner-export style_learner json

✓ Exporting Style Learner data...

Export options:
  1. json - Machine-readable JSON
  2. csv - Spreadsheet format
  3. markdown - Human-readable markdown

Selected: json

✓ Exported to: .data/learning/style_learner_export.json

Contents:
  • 15 executions
  • 42 edit entries
  • Current style profile
  • Timestamp: 2024-10-25T14:30:00Z

Ready to:
  • Backup: Save this file
  • Share: Send to teammates
  • Analyze: Open in Python/Excel
  • Version control: Commit to git
```

## Export All Learners

```bash
/learner-export all json

✓ Exporting all learners...

decision_historian.json
  └─ 8 executions, 3 feedback entries

style_learner.json
  └─ 15 executions, 42 edits

meta_recipe_tuner.json
  └─ 6 executions, 18 stage logs

knowledge_compressor.json
  └─ 12 executions, 11 feedback entries

✓ Exported 4 files to: .data/learning/exports/

Total data: 41 executions
Total size: 250 KB
```

## Export Formats

### JSON Export

```bash
/learner-export style_learner json

{
  "learner_id": "style_learner",
  "export_date": "2024-10-25T14:30:00Z",
  "executions": [
    {
      "execution_id": "email_001",
      "timestamp": "2024-10-25T10:00:00Z",
      "input_prompt": "Professional email",
      "generated_output": "...",
      "estimated_formality": 0.65
    }
  ],
  "feedback": [
    {
      "execution_id": "email_001",
      "edits": [
        {
          "original": "I am",
          "replacement": "I'm",
          "reason": "more casual"
        }
      ]
    }
  ],
  "recommendations": {
    "formality": 0.45,
    "perspective": "first",
    "confidence": 0.82
  }
}
```

### CSV Export

```bash
/learner-export meta_recipe_tuner csv

recipe_id,run_id,stage_name,duration_sec,quality_metric
blog_writer,run_001,research,12.5,0.92
blog_writer,run_001,drafting,8.3,0.88
blog_writer,run_002,research,11.8,0.90
...

✓ Exported to: meta_recipe_tuner_export.csv
Ready to: Open in Excel, Google Sheets, Python/pandas
```

### Markdown Export

```bash
/learner-export knowledge_compressor markdown

# Knowledge Compressor Export
*Exported: 2024-10-25 14:30:00 UTC*

## Executions

### extract_001
- **Source Type**: research_paper
- **Input Tokens**: 2500
- **Sections**: 4

| Section | Tokens |
|---------|--------|
| abstract | 200 |
| methods | 800 |
| results | 1000 |
| discussion | 500 |

### extract_002
...

## Feedback

### extract_001
- **Kept**: abstract, results
- **Removed**: methods, discussion
- **Reason**: Focus on findings

...

## Recommendations

### Section Priorities
- abstract: 0.95 (include)
- results: 0.90 (include)
- methods: 0.25 (exclude)
```

## Use Cases

### Backup
```bash
/learner-export all json
# Save exported files to cloud storage or version control
```

### Analysis
```bash
/learner-export style_learner json
# Open in Python/pandas for statistical analysis
```

### Sharing
```bash
/learner-export meta_recipe_tuner markdown
# Share human-readable results with team
```

### Documentation
```bash
/learner-export knowledge_compressor markdown
# Include in project documentation
```

### Migration
```bash
/learner-export all json
# Move data to different system/backup
```

## Output Locations

Exports saved to:
- `.data/learning/<learner_id>_export.<format>`
- `.data/learning/exports/<timestamp>_<learner_id>_export.<format>`

## Related Commands

- `/learner-status` - Check what data exists
- `/learner-analyze` - Analyze exported data
- `/learner-clear` - Clear data (backup first!)
- `/learner-log` - Log new data
